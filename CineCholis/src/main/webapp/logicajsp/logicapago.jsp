<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Conexion.conexion" %>
<%@ page import="Metodos.Cifrado" %>
<%@ page import="java.net.URLEncoder" %>

<%
    // Obtener parámetros del formulario
    String formaPago = request.getParameter("forma_pago"); // Obtener forma de pago
    String cardNumber = request.getParameter("card-number");
    String expiryDate = request.getParameter("expiry-date");
    String cvv = request.getParameter("cvv");
    String fullName = request.getParameter("full-name");
    String email = request.getParameter("email");
    String asientosSeleccionados = request.getParameter("asientos"); // Obtener asientos seleccionados
    String montoTotal = request.getParameter("total"); // Obtener el monto total
    String cine = request.getParameter("cine"); // Obtener cine
    String sala = request.getParameter("sala");
    String pelicula = request.getParameter("pelicula"); // Obtener el nombre de la película
    String fecha = request.getParameter("fecha");
    String horario = request.getParameter("horario");

    // Validar que montoTotal no sea nulo o vacío
    if (montoTotal == null || montoTotal.isEmpty()) {
        out.println("<h3>Error: Monto total no puede ser nulo o vacío.</h3>");
        return; // Salir si no hay monto total
    }

    String tipoTarjeta = "";
    int id_pago_yape = -1; // Para almacenar el id del pago Yape
    int id_pago_targeta = -1; // Para almacenar el id del pago tarjeta
    String tipo_pago = "Efectivo"; // Asignar un valor predeterminado
    int id_pelicula = -1; // Inicializar el ID de la película

    // Conexión a la base de datos
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = conexion.getConnection();

        // Obtener el id_usuario basado en el email
        String sqlObtenerUsuario = "SELECT id FROM usuarios WHERE email = ?";
        pstmt = conn.prepareStatement(sqlObtenerUsuario);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
            out.println("<h3>Error: Usuario no encontrado.</h3>");
            return;
        }
        int id_usuario = rs.getInt("id");

        // Procesar el pago
        if (formaPago.equals("Tarjeta")) {
            // Determinar el tipo de tarjeta
            if (cardNumber.startsWith("4")) {
                tipoTarjeta = "Visa";
            } else if (cardNumber.startsWith("5")) {
                tipoTarjeta = "Mastercard";
            } else if (cardNumber.startsWith("34") || cardNumber.startsWith("37")) {
                tipoTarjeta = "American Express";
            } else {
                response.sendRedirect("../pago_sinexito.jsp");
                return; // Salir si no es una tarjeta válida
            }

            // Cifrar el número de tarjeta y el CVV
            String cardNumberCifrado = Cifrado.cifrar(cardNumber);
            String cvvCifrado = Cifrado.cifrar(cvv);

            // Insertar en la tabla de pagos_targeta
            String sqlPagosTargeta = "INSERT INTO pagos_targeta (card_number, expiry_date, cvv, full_name, email, fecha, tipo_targeta) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";
            pstmt = conn.prepareStatement(sqlPagosTargeta);
            pstmt.setString(1, cardNumberCifrado); // Guardar el número de tarjeta cifrado
            pstmt.setString(2, expiryDate);
            pstmt.setString(3, cvvCifrado); // Guardar el CVV cifrado
            pstmt.setString(4, fullName);
            pstmt.setString(5, email);
            pstmt.setString(6, tipoTarjeta); // Almacenar el tipo de tarjeta

            int rowsAffectedPagos = pstmt.executeUpdate();
            if (rowsAffectedPagos > 0) {
                // Obtener el id del pago realizado en pagos_targeta
                String sqlIdPagoTargeta = "SELECT id FROM pagos_targeta WHERE email = ? ORDER BY fecha DESC LIMIT 1";
                pstmt = conn.prepareStatement(sqlIdPagoTargeta);
                pstmt.setString(1, email);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    id_pago_targeta = rs.getInt("id");
                }
                tipo_pago = tipoTarjeta; // Almacenar el tipo de tarjeta como tipo de pago
            }

        } else if (formaPago.equals("Yape")) {
            String numeroYape = request.getParameter("numero-yape"); // Obtener número Yape

            // Insertar en la tabla de pagos_yape
            String sqlPagosYape = "INSERT INTO pagos_yape (numero_yape, fecha) VALUES (?, CURRENT_TIMESTAMP)";
            pstmt = conn.prepareStatement(sqlPagosYape);
            pstmt.setString(1, numeroYape);
            int rowsAffectedYape = pstmt.executeUpdate();

            if (rowsAffectedYape > 0) {
                // Obtener el id del pago realizado en pagos_yape
                String sqlIdPagoYape = "SELECT id FROM pagos_yape WHERE numero_yape = ? ORDER BY fecha DESC LIMIT 1";
                pstmt = conn.prepareStatement(sqlIdPagoYape);
                pstmt.setString(1, numeroYape);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    id_pago_yape = rs.getInt("id");
                }
                tipo_pago = "Yape"; // Asignar tipo de pago
            }

        } else {
            // Redirigir a la página de error si la forma de pago no es válida
            response.sendRedirect("../pago_sinexito.jsp");
            return;
        }

        // Obtener el id de la película a partir del nombre de la película
        String sqlObtenerIdPelicula = "SELECT id FROM pelicula WHERE nombre_pelicula = ?"; // Asumiendo que tienes una tabla peliculas
        pstmt = conn.prepareStatement(sqlObtenerIdPelicula);
        pstmt.setString(1, pelicula);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            id_pelicula = rs.getInt("id");
        } else {
            out.println("<h3>Error: Película no encontrada.</h3>");
            return; // Salir si no se encontró la película
        }

        // Insertar en la tabla de registro de ventas
        String sqlVentas = "INSERT INTO registro_ventas (id_usuario, asientos_seleccionados, fecha_compra, monto_total, cine, sala, id_pago_yape, id_pago_targeta, tipo_pago, id_pelicula) VALUES (?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sqlVentas);
        pstmt.setInt(1, id_usuario); // Usar id_usuario
        pstmt.setString(2, asientosSeleccionados);
        pstmt.setString(3, montoTotal);
        pstmt.setString(4, cine); // Guardar cine
        pstmt.setString(5, sala); // Guardar sala
        pstmt.setObject(6, id_pago_yape == -1 ? null : id_pago_yape); // Manejar el caso de id_pago_yape nulo
        pstmt.setObject(7, id_pago_targeta == -1 ? null : id_pago_targeta); // Manejar el caso de id_pago_targeta nulo
        pstmt.setString(8, tipo_pago); // Almacenar el tipo de pago
        pstmt.setInt(9, id_pelicula); // Almacenar el id de la película

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
