<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.conexion" %>
<%@ page import="java.net.URLEncoder" %>
<%
    // Obtener parámetros del formulario
    String formaPago = request.getParameter("forma_pago");
    String celular = request.getParameter("celular");
    String email = request.getParameter("email");
    String asientosSeleccionados = request.getParameter("asientos");
    String fullName = request.getParameter("full-name");
    String montoTotal = request.getParameter("total");
    String cine = request.getParameter("cine");
    String sala = request.getParameter("sala");
    String pelicula = request.getParameter("pelicula");
    String fecha = request.getParameter("fecha");
    String horario = request.getParameter("horario");

    // Depuración: Imprimir el monto total
    out.println("Monto Total: " + montoTotal);

    // Validar que montoTotal no sea nulo o vacío
    if (montoTotal == null || montoTotal.isEmpty()) {
        out.println("<h3>Error: Monto total no puede ser nulo o vacío.</h3>");
        return; 
    }

    // Conexión a la base de datos
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int id_pelicula = -1;
    int id_pago_yape = -1; // Inicializar con un valor inválido
    String tipo_pago = "Yape"; // Asignar un valor predeterminado
    int id_pago_targeta = -1; // Inicializar el id de pago con tarjeta

    try {
        conn = conexion.getConnection();

        // Obtener id_usuario basado en el email
        int id_usuario = -1;
        String sqlObtenerUsuario = "SELECT id FROM usuarios WHERE email = ?";
        pstmt = conn.prepareStatement(sqlObtenerUsuario);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            id_usuario = rs.getInt("id");
        } else {
            out.println("<h3>Error: Usuario no encontrado.</h3>");
            return;
        }

        // Cerrar ResultSet y PreparedStatement antes de reutilizarlos
        rs.close();
        pstmt.close();

        // Procesar la forma de pago
        if (formaPago.equals("Yape")) {
            // Insertar en la tabla de pagos Yape
            String sqlPagosYape = "INSERT INTO pagos_yape (celular, email, fecha, monto_total) VALUES (?, ?, CURRENT_TIMESTAMP, ?)";
            pstmt = conn.prepareStatement(sqlPagosYape);
            pstmt.setString(1, celular);
            pstmt.setString(2, email);
            pstmt.setString(3, montoTotal);
            int rowsAffectedPagosYape = pstmt.executeUpdate();

            // Si se insertó correctamente, obtener el id del pago
            if (rowsAffectedPagosYape > 0) {
                pstmt.clearParameters();

                // Obtener el id del pago realizado en pagos_yape
                String sqlIdPagoYape = "SELECT id FROM pagos_yape WHERE email = ? ORDER BY fecha DESC LIMIT 1";
                pstmt = conn.prepareStatement(sqlIdPagoYape);
                pstmt.setString(1, email);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    id_pago_yape = rs.getInt("id");
                }

                // Obtener el id de la película a partir del nombre de la película
                String sqlObtenerIdPelicula = "SELECT id FROM pelicula WHERE nombre_pelicula = ?";
                pstmt = conn.prepareStatement(sqlObtenerIdPelicula);
                pstmt.setString(1, pelicula);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    id_pelicula = rs.getInt("id");
                } else {
                    out.println("<h3>Error: Película no encontrada.</h3>");
                    return;
                }

                // Insertar en la tabla de registro de ventas
                String sqlVentas = "INSERT INTO registro_ventas (id_usuario, asientos_seleccionados, fecha_compra, monto_total, cine, sala, id_pago_yape, id_pago_targeta, tipo_pago, id_pelicula) VALUES (?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sqlVentas);
                pstmt.setInt(1, id_usuario);
                pstmt.setString(2, asientosSeleccionados);
                pstmt.setString(3, montoTotal);
                pstmt.setString(4, cine);
                pstmt.setString(5, sala);
                pstmt.setObject(6, id_pago_yape == -1 ? null : id_pago_yape);
                pstmt.setObject(7, id_pago_targeta == -1 ? null : id_pago_targeta);
                pstmt.setString(8, tipo_pago);
                pstmt.setInt(9, id_pelicula);
					
                
                int rowsAffectedVentas = pstmt.executeUpdate();
                if (rowsAffectedVentas > 0) {
                    // Redirigir a la página de éxito con los datos necesarios
                    String redirectUrl = String.format("../pago_exitoso.jsp?full-name=%s&pelicula=%s&cine=%s&sala=%s&asientos=%s&total=%s&fecha=%s&horario=%s&forma_pago=%s", 
                        URLEncoder.encode(fullName, "UTF-8"),
                        URLEncoder.encode(pelicula, "UTF-8"),
                        URLEncoder.encode(cine, "UTF-8"),
                        URLEncoder.encode(sala, "UTF-8"),
                        URLEncoder.encode(asientosSeleccionados, "UTF-8"),
                        URLEncoder.encode(montoTotal, "UTF-8"),
                        URLEncoder.encode(fecha, "UTF-8"),
                        URLEncoder.encode(horario, "UTF-8"),
                        URLEncoder.encode(tipo_pago, "UTF-8")); // Aquí se añade la forma de pago
                    response.sendRedirect(redirectUrl);
                        
                } else {
                    // Redirigir a la página de error
                    response.sendRedirect("../pago_sinexito.jsp");
                }
            } else {
                // Redirigir a la página de error si la inserción en pagos falla
                response.sendRedirect("../pago_sinexito.jsp");
            }
        } else {
            // Aquí puedes manejar otros tipos de pago si es necesario
            out.println("<h3>Error: Forma de pago no válida.</h3>");
            return;
        }

    } catch (SQLException e) {
        e.printStackTrace();
        // Redirigir a la página de error
        response.sendRedirect("../pago_sinexito.jsp");
    } finally {
        // Cerrar recursos
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
