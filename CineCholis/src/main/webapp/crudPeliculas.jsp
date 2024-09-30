<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="Conexion.conexion" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CRUD de Películas</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/crudpeliculas.css">
</head>
<body>
    <jsp:include page="/fragmentos/encabezado_admin.jsp" />
    <h1>Gestión de Películas</h1>

    <h2>Agregar Nueva Película</h2>
    <form action="crudPeliculas.jsp" method="post" enctype="multipart/form-data">
        <label for="nombre_pelicula">Nombre de la Película:</label>
        <input type="text" name="nombre_pelicula" required><br>

        <label for="sinopsis">Sinopsis:</label>
        <textarea name="sinopsis" required></textarea><br>

        <label for="director">Director:</label>
        <input type="text" name="director" required><br>

        <label for="idioma">Idioma:</label>
        <input type="text" name="idioma" required><br>

        <label for="genero">Género:</label>
        <input type="text" name="genero" required><br>

        <label for="imagen">Seleccionar Imagen:</label>
        <input type="file" name="imagen" accept="image/*" required><br>

        <input type="submit" name="action" value="add">
    </form>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = conexion.getConnection();

            // Insertar nueva película con carga de archivo
            if ("add".equals(request.getParameter("action"))) {
                String nombre_pelicula = request.getParameter("nombre_pelicula");
                String sinopsis = request.getParameter("sinopsis");
                String director = request.getParameter("director");
                String idioma = request.getParameter("idioma");
                String genero = request.getParameter("genero");
                String imagen = "";

                // Procesar la imagen
                Part filePart = request.getPart("imagen"); // Obtiene la parte del archivo
                String fileName = filePart.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    // Define la ruta donde se guardará la imagen
                    String filePath = application.getRealPath("/") + "img/" + fileName;
                    File uploadedFile = new File(filePath);
                    filePart.write(uploadedFile.getAbsolutePath());
                    imagen = "img/" + fileName; // Guardar la ruta de la imagen
                }

                // Inserción en la base de datos
                String sqlInsert = "INSERT INTO pelicula (nombre_pelicula, sinopsis, director, idioma, imagen, genero) VALUES (?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(sqlInsert);
                ps.setString(1, nombre_pelicula);
                ps.setString(2, sinopsis);
                ps.setString(3, director);
                ps.setString(4, idioma);
                ps.setString(5, imagen); // Ruta de la imagen almacenada
                ps.setString(6, genero);
                int rowsInserted = ps.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<script>alert('Película agregada exitosamente.');</script>");
                } else {
                    out.println("<script>alert('Error al agregar la película.');</script>");
                }
            }

            // Listar películas
            String sqlSelect = "SELECT * FROM pelicula";
            ps = conn.prepareStatement(sqlSelect);
            rs = ps.executeQuery();
    %>
    <h2>Listado de Películas</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Sinopsis</th>
            <th>Director</th>
            <th>Idioma</th>
            <th>Imagen</th>
            <th>Género</th>
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
        <tr>
            <td><%= id %></td>
            <td><%= nombre %></td>
            <td><%= sinopsis %></td>
            <td><%= director %></td>
            <td><%= idioma %></td>
            <td><img src="<%= imagenPath %>" alt="<%= nombre %>" width="100" /></td>
            <td><%= genero %></td>
        </tr>
    <%
            }
    %>
    </table>

    <%
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>
</body>
</html>

