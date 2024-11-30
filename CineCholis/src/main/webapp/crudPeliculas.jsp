<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="config.conexion"%>

<!DOCTYPE html>
<html>
<head>
    <title>CRUD de Peliculas</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/crudpeliculas.css">

    <script>
        function cargarDatos(id, nombre, sinopsis, director, idioma, genero, imagen) {
            document.getElementById('id').value = id;
            document.getElementById('nombre_pelicula').value = nombre;
            document.getElementById('sinopsis').value = sinopsis;
            document.getElementById('director').value = director;
            document.getElementById('idioma').value = idioma;
            document.getElementById('genero').value = genero;
            document.getElementById('imagen').value = imagen;
            
            document.getElementById('nombre_pelicula').focus();
        }
    </script>
</head>
<body>
    <jsp:include page="/fragmentos/encabezado_admin.jsp" />
    <h1>Gestión de Películas</h1>

    <h2>Agregar o Editar Película</h2>
    <form action="crudPeliculas.jsp" method="post" class="formulario-pelicula">
        <input type="hidden" id="id" name="id" value="">
        <label for="nombre_pelicula" class="label-pelicula">Nombre de la Película:</label>
        <input type="text" id="nombre_pelicula" name="nombre_pelicula" class="input-pelicula" required><br>

        <label for="sinopsis" class="label-pelicula">Sinopsis:</label>
        <textarea id="sinopsis" name="sinopsis" required></textarea><br>

        <label for="director" class="label-pelicula">Director:</label>
        <input type="text" id="director" name="director" class="input-pelicula" required><br>

        <label for="idioma" class="label-pelicula">Idioma:</label>
        <input type="text" id="idioma" name="idioma" class="input-pelicula" required><br>

        <label for="genero" class="label-pelicula">Género:</label>
        <input type="text" id="genero" name="genero" class="input-pelicula" required><br>

        <label for="imagen" class="label-pelicula">Ruta de Imagen:</label>
        <input type="text" id="imagen" name="imagen" class="input-pelicula" required placeholder="Ej: nombre_imagen.jpg"><br>

        <input type="submit" name="action" value="save" class="boton-submit">
    </form>

    <%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Conexión a la base de datos
        conn = conexion.getConnection();
        if (conn == null) {
            out.println("<script>alert('Error: No se pudo conectar a la base de datos.');</script>");
        }

        // Insertar o actualizar película
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
                    String sqlInsert = "INSERT INTO pelicula (nombre_pelicula, sinopsis, director, idioma, imagen, genero) VALUES (?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sqlInsert);
                    ps.setString(1, nombre_pelicula);
                    ps.setString(2, sinopsis);
                    ps.setString(3, director);
                    ps.setString(4, idioma);
                    ps.setString(5, "../img/" + imagen);
                    ps.setString(6, genero);

                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<script>alert('Película agregada exitosamente.');</script>");
                    } else {
                        out.println("<script>alert('Error: No se pudo agregar la película.');</script>");
                    }
                } else {
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
                        out.println("<script>alert('Película actualizada exitosamente.');</script>");
                    } else {
                        out.println("<script>alert('Error: No se pudo actualizar la película.');</script>");
                    }
                }
            } catch (SQLException e) {
                out.println("<script>alert('Error al guardar la película: " + e.getMessage() + "');</script>");
            }
        }

        // Eliminar película
        if ("Eliminar".equals(request.getParameter("actionDelete"))) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String sqlDelete = "DELETE FROM pelicula WHERE id = ?";
                ps = conn.prepareStatement(sqlDelete);
                ps.setInt(1, id);

                int rowsDeleted = ps.executeUpdate();
                if (rowsDeleted > 0) {
                    out.println("<script>alert('Película eliminada exitosamente.');</script>");
                } else {
                    out.println("<script>alert('Error: No se pudo eliminar la película.');</script>");
                }
            } catch (SQLException e) {
                out.println("<script>alert('Error al eliminar la película: " + e.getMessage() + "');</script>");
            }
        }

        // Listar películas
        String sqlSelect = "SELECT * FROM pelicula";
        ps = conn.prepareStatement(sqlSelect);
        rs = ps.executeQuery();
    %>
    <h2>Listado de Películas</h2>
    <table class="tabla-peliculas">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Sinopsis</th>
            <th>Director</th>
            <th>Idioma</th>
            <th>Género</th>
            <th>Imagen</th>
            <th>Acciones</th>
        </tr>
        <%
        while (rs.next()) {
            int id = rs.getInt("id");
            String nombre = rs.getString("nombre_pelicula");
            String sinopsis = rs.getString("sinopsis");
            String director = rs.getString("director");
            String idioma = rs.getString("idioma");
            String genero = rs.getString("genero");
            String imagen = rs.getString("imagen");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= nombre %></td>
            <td><%= sinopsis %></td>
            <td><%= director %></td>
            <td><%= idioma %></td>
            <td><%= genero %></td>
            <td><img src="<%= request.getContextPath() + "/img/" + imagen %>" alt="<%= nombre %>" width="100"></td>
            <td>
                <button onclick="cargarDatos('<%= id %>', '<%= nombre %>', '<%= sinopsis %>', '<%= director %>', '<%= idioma %>', '<%= genero %>', '<%= imagen %>')">Editar</button>
                <form action="crudPeliculas.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="submit" name="actionDelete" value="Eliminar" onclick="return confirm('¿Está seguro de eliminar esta película?');">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <%
    } catch (SQLException e) {
        out.println("<script>alert('Error al listar las películas: " + e.getMessage() + "');</script>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
    %>
</body>
</html>





