<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/crudFunciones.css">
<head>
<meta charset="UTF-8">
<title>CineCholis</title>
<script>
	function cargarCines() {
		var ciudadId = document.getElementById("ciudad").value;
		if (ciudadId) {
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "getCines2.jsp?ciudad_id=" + ciudadId, true);
			xhr.onload = function() {
				if (xhr.status == 200) {
					document.getElementById("cine").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}
	}

	function cargarSalas() {
		var cineId = document.getElementById("cine").value;
		if (cineId) {
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "getSalas2.jsp?cine_id=" + cineId, true);
			xhr.onload = function() {
				if (xhr.status == 200) {
					document.getElementById("sala").innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}
	}
</script>
</head>
<body>
	<jsp:include page="/fragmentos/encabezado_admin.jsp" />
	<h2>Gestión de Funciones</h2>

	<!-- Formulario para agregar funciones -->
	<form id="form-funcion" action="logicajsp/logicaFunciones.jsp" method="post">
		<label for="ciudad">Selecciona Ciudad:</label>
		<select name="ciudad" id="ciudad" onchange="cargarCines()">
			<%
			// Cargar ciudades desde la base de datos
			Connection conn = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
				PreparedStatement ps = conn.prepareStatement("SELECT id, nombre_ciudad FROM ciudades");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
			%>
			<option value="<%=rs.getInt("id")%>"><%=rs.getString("nombre_ciudad")%></option>
			<%
				}
			} catch (Exception e) {
				out.println("Error: " + e.getMessage());
			} finally {
				if (conn != null) try { conn.close(); } catch (SQLException e) {}
			}
			%>
		</select>

		<label for="pelicula">Selecciona Película:</label>
		<select name="pelicula" id="pelicula">
			<%
			try {
				conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
				PreparedStatement ps = conn.prepareStatement("SELECT id, nombre_pelicula FROM pelicula");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
			%>
			<option value="<%=rs.getInt("id")%>"><%=rs.getString("nombre_pelicula")%></option>
			<%
				}
			} catch (Exception e) {
				out.println("Error: " + e.getMessage());
			} finally {
				if (conn != null) try { conn.close(); } catch (SQLException e) {}
			}
			%>
		</select>

		<label for="cine">Selecciona Cine:</label>
		<select name="cine" id="cine" onchange="cargarSalas()">
			<option value="">Selecciona Ciudad primero</option>
		</select>

		<label for="sala">Selecciona Sala:</label>
		<select name="sala" id="sala">
			<option value="">Selecciona Cine primero</option>
		</select>

		<label for="horario">Selecciona Horario:</label>
		<select name="horarios[]" id="horario">
			<%
			String[] horarios = { "14:00:00", "13:30:00", "16:15:00", "19:45:00", "15:00:00", "18:30:00", "22:00:00", "12:00:00",
					"19:00:00", "11:45:00", "14:20:00", "20:35:00", "17:30:00", "21:00:00" };
			for (String horario : horarios) {
			%>
			<option value="<%=horario%>"><%=horario%></option>
			<%
			}
			%>
		</select>

		<button type="submit" id="btn-guardar" class="button-guardar">Guardar Función</button>
	</form>

	<!-- Tabla de funciones -->
	<table border="1" class="funciones-table">
		<thead>
			<tr>
				<th>ID</th>
				<th>Película</th>
				<th>Cine</th>
				<th>Horario</th>
				<th>Acciones</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (request.getParameter("accion") != null && request.getParameter("accion").equals("eliminar")) {
				try {
					int idFuncion = Integer.parseInt(request.getParameter("idFuncion"));
					conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
					PreparedStatement ps = conn.prepareStatement("DELETE FROM funciones WHERE id = ?");
					ps.setInt(1, idFuncion);
					ps.executeUpdate();
				} catch (Exception e) {
					out.println("<tr><td colspan='5'>Error al eliminar: " + e.getMessage() + "</td></tr>");
				} finally {
					if (conn != null) try { conn.close(); } catch (SQLException e) {}
				}
			}

			try {
				conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
				String query = "SELECT f.id, p.nombre_pelicula, c.nombre_cine, f.horario FROM funciones f " +
				               "JOIN pelicula p ON f.id_pelicula = p.id " +
				               "JOIN cines c ON f.id_cine = c.id";
				PreparedStatement ps = conn.prepareStatement(query);
				ResultSet rs = ps.executeQuery();

				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getInt("id")%></td>
				<td><%=rs.getString("nombre_pelicula")%></td>
				<td><%=rs.getString("nombre_cine")%></td>
				<td><%=rs.getString("horario")%></td>
				<td>
					<form method="post" style="display:inline;">
						<input type="hidden" name="accion" value="eliminar">
						<input type="hidden" name="idFuncion" value="<%=rs.getInt("id")%>">
						<button type="submit" onclick="return confirm('¿Estás seguro de que deseas eliminar esta función?')">Eliminar</button>
					</form>
				</td>
			</tr>
			<%
				}
			} catch (Exception e) {
				out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
			} finally {
				if (conn != null) try { conn.close(); } catch (SQLException e) {}
			}
			%>
		</tbody>
	</table>
</body>
</html>
