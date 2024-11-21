<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="config.conexion" %>

<!DOCTYPE html>
<html>
<head>
    <title>CRUD de Peliculas</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/crudpeliculas.css">
    
    <script>
        function mostrarDatos(id, nombre, sinopsis, director, idioma, genero, imagen) {
            document.getElementById('id').value = id; // Agregar el ID
            document.getElementById('nombre_pelicula').value = nombre;
            document.getElementById('sinopsis').value = sinopsis;
            document.getElementById('director').value = director;
            document.getElementById('idioma').value = idioma;
            document.getElementById('genero').value = genero;
            document.getElementById('imagen').value = imagen;
        }
    </script>
</head>
<body>
    <jsp:include page="/fragmentos/encabezado_admin.jsp" />
    <h1>Gesti�n de Pel�culas</h1>

    <h2>Agregar o Editar Pelicula</h2>
    <form action="crudPeliculas.jsp" method="post">
        <input type="hidden" id="id" name="id" value="">
        <label for="nombre_pelicula">Nombre de la Pelicula:</label>
        <input type="text" id="nombre_pelicula" name="nombre_pelicula" required><br>

        <label for="sinopsis">Sinopsis:</label>
        <textarea id="sinopsis" name="sinopsis" required></textarea><br>

        <label for="director">Director:</label>
        <input type="text" id="director" name="director" required><br>

        <label for="idioma">Idioma:</label>
        <input type="text" id="idioma" name="idioma" required><br>

        <label for="genero">Genero:</label>
        <input type="text" id="genero" name="genero" required><br>

        <label for="imagen">Ruta de Imagen:</label>
        <input type="text" id="imagen" name="imagen" required placeholder="Ej: nombre_imagen.jpg"><br>

        <input type="submit" name="action" value="save">
    </form>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Conexi�n a la base de datos
            conn = conexion.getConnection();
            if (conn == null) {
                out.println("<script>alert('Error: No se pudo conectar a la base de datos.');</script>");
            }

            // Insertar nueva pel�cula o actualizar existente
            if ("save".equals(request.getParameter("action"))) {
                try {
                    String nombre_pelicula = request.getParameter("nombre_pelicula");
                    String sinopsis = request.getParameter("sinopsis");
                    String director = request.getParameter("director");
                    String idioma = request.getParameter("idioma");
                    String genero = request.getParameter("genero");
                    String imagen = request.getParameter("imagen");
                    String idParam = request.getParameter("id");

                    if (idParam == null || idParam.isEmpty()) {
                        // Inserci�n en la base de datos
                        String sqlInsert = "INSERT INTO pelicula (nombre_pelicula, sinopsis, director, idioma, imagen, genero) VALUES (?, ?, ?, ?, ?, ?)";
                        ps = conn.prepareStatement(sqlInsert);
                        ps.setString(1, nombre_pelicula);
                        ps.setString(2, sinopsis);
                        ps.setString(3, director);
                        ps.setString(4, idioma);
                        ps.setString(5, "../img/" + imagen); // Ruta de la imagen almacenada
                        ps.setString(6, genero);

                        int rowsInserted = ps.executeUpdate();
                        if (rowsInserted > 0) {
                            out.println("<script>alert('Pel�cula agregada exitosamente.');</script>");
                        } else {
                            out.println("<script>alert('Error: No se pudo agregar la pel�cula.');</script>");
                        }
                    } else {
                        // Actualizaci�n de la pel�cula existente
                        int id = Integer.parseInt(idParam);
                        String sqlUpdate = "UPDATE pelicula SET nombre_pelicula = ?, sinopsis = ?, director = ?, idioma = ?, imagen = ?, genero = ? WHERE id = ?";
                        ps = conn.prepareStatement(sqlUpdate);
                        ps.setString(1, nombre_pelicula);
                        ps.setString(2, sinopsis);
                        ps.setString(3, director);
                        ps.setString(4, idioma);
                        ps.setString(5, "../img/" + imagen);
                        ps.setString(6, genero);
                        ps.setInt(7, id);

                        int rowsUpdated = ps.executeUpdate();
                        if (rowsUpdated > 0) {
                            out.println("<script>alert('Pelicula actualizada exitosamente.');</script>");
                        } else {
                            out.println("<script>alert('Error: No se pudo actualizar la pel�cula.');</script>");
                        }
                    }
                } catch (SQLException e) {
                    out.println("<script>alert('Error al guardar la pel�cula: " + e.getMessage() + "');</script>");
                    e.printStackTrace();
                }
            }

            // Eliminar pel�cula
            // Eliminar pel�cula
			if ("Eliminar".equals(request.getParameter("actionDelete"))) {
			    try {
			        // Aseg�rate de que el par�metro id se est� pasando correctamente
			        int id = Integer.parseInt(request.getParameter("id"));
			        
			        // Consulta SQL para eliminar
			        String sqlDelete = "DELETE FROM `pelicula` WHERE `pelicula`.`id` = ?";
			        ps = conn.prepareStatement(sqlDelete);
			        ps.setInt(1, id);
			        
			        // Ejecutar la eliminaci�n
			        int rowsDeleted = ps.executeUpdate();
			        
			        // Verificar si se elimin� correctamente
			        if (rowsDeleted > 0) {
			            out.println("<script>alert('Pelecula eliminada exitosamente.');</script>");
			        } else {
			            out.println("<script>alert('Error: No se pudo eliminar la pel�cula.');</script>");
			        }
			    } catch (SQLException e) {
			        out.println("<script>alert('Error al eliminar la pel�cula: " + e.getMessage() + "');</script>");
			        e.printStackTrace();
			    } catch (NumberFormatException e) {
			        out.println("<script>alert('Error en el ID de la pel�cula: " + e.getMessage() + "');</script>");
			        e.printStackTrace();
			    }
			}

            // Listar pel�culas
            try {
                String sqlSelect = "SELECT * FROM pelicula";
                ps = conn.prepareStatement(sqlSelect);
                rs = ps.executeQuery();
    %>
    <h2>Listado de Peliculas</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Sinopsis</th>
            <th>Director</th>
            <th>Idioma</th>
            <th>Imagen</th>
            <th>G�nero</th>
            <th>Ruta de Imagen</th>
            <th>Acciones</th>
        </tr>

    <%
    while (rs.next()) {
        int id = rs.getInt("id");
        String nombre = rs.getString("nombre_pelicula");
        String sinopsis = rs.getString("sinopsis");
        String director = rs.getString("director");
        String idioma = rs.getString("idioma");
        String imagenPath = rs.getString("imagen");
        String genero = rs.getString("genero");
    %>
    <tr onclick="mostrarDatos('<%= id %>', '<%= nombre %>', '<%= sinopsis %>', '<%= director %>', '<%= idioma %>', '<%= genero %>', '<%= imagenPath %>');">
        <td><%= id %></td>
        <td><%= nombre %></td>
        <td><%= sinopsis %></td>
        <td><%= director %></td>
        <td><%= idioma %></td>
        <td>
            <img src="<%= request.getContextPath() + "/img/" + imagenPath %>" alt="<%= nombre %>" width="100" />
            <br>
            <small>Ruta: <%= request.getContextPath() + "/img/" + imagenPath %></small>
        </td>
        <td><%= genero %></td>
        <td><%= imagenPath %></td>
        <td>
            <form action="crudPeliculas.jsp" method="post" style="display:inline;">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="submit" name="actionDelete" value="Eliminar" 
               onclick="return confirm('�Est� seguro de que desea eliminar esta pel�cula?');">
    </form>

            <form action="crudPeliculas.jsp" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="submit" name="actionEdit" value="Editar">
            </form>
        </td>
    </tr>
    <%
    }
    %>
    </table>
    <%
            } catch (SQLException e) {
                out.println("<script>alert('Error al listar las pel�culas: " + e.getMessage() + "');</script>");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            out.println("<script>alert('Error de conexi�n: " + e.getMessage() + "');</script>");
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { }
            if (ps != null) try { ps.close(); } catch (SQLException e) { }
            if (conn != null) try { conn.close(); } catch (SQLException e) { }
        }
    %>
</body>
</html>






