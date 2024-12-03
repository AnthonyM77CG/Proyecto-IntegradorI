<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Pelicula"%>
<%@ page import="model.Cines"%>
<%@ page import="dao.PeliculasCinesDAOimpl"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CineCholis</title>
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/elpadrinoo.css">
<link rel="icon" type="image/png" href="img/favicon.png">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		// Cargar dinámicamente cines y salas según la selección
		$('#ciudad').change(function() {
			var ciudad = $(this).val();
			$.ajax({
				url : 'logicajsp/get_cines.jsp',
				type : 'GET',
				data : {
					ciudad : ciudad
				},
				success : function(data) {
					$('#cine').html(data);
				}
			});
		});

		$('#cine').change(function() {
			var cine = $(this).val();
			$.ajax({
				url : 'logicajsp/get_salas.jsp',
				type : 'GET',
				data : {
					cine : cine
				},
				success : function(data) {
					$('#sala').html(data);
				}
			});
		});
	});
</script>

</head>
<body>
	<jsp:include page="/fragmentos/encabezadousuario_intranet.jsp" />
	<%
	// Obtener el título de la película desde el parámetro
	String tituloPelicula = request.getParameter("titulo");
	PeliculasCinesDAOimpl metodos = new PeliculasCinesDAOimpl();
	Pelicula pelicula = null;

	if (tituloPelicula != null && !tituloPelicula.isEmpty()) {
		pelicula = metodos.getPeliculaPorNombre(tituloPelicula);

	}

	String imagenPelicula = (pelicula != null) ? pelicula.getImagen() : "default.jpg";
	%>

	<div id="movie-details-container">
		<div id="movie-details">
			<div id="details-content">
				<div id="vertical-image-container">
					<img src="img/<%=imagenPelicula%>" alt="Imagen de la Película"
						id="vertical-image" />
				</div>
				<div id="synopsis">
					<h2>Sinopsis</h2>
					<p><%=pelicula != null ? pelicula.getSinopsis() : "Sinopsis no disponible"%></p>
					<div class="details-section">
						<h3>Director</h3>
						<p><%=pelicula != null ? pelicula.getDirector() : "No disponible"%></p>
					</div>
					<div class="details-section">
						<h3>Idioma</h3>
						<p><%=pelicula != null ? pelicula.getIdioma() : "No disponible"%></p>
				
					</div>
					<div class="details-section">
						<h3>Usuario</h3>
						<p id="usuarioDisplay"></p>
					</div>
				</div>
			</div>
		</div>

		<div class="combobox-container">
			<!-- Formulario para seleccionar ciudad, cine, sala y horario -->
			<form action="dulceria.jsp" id="selection-form" method="get">
				<div class="combobox-row">
					<div class="combobox-item">
						<label for="ciudad">Selecciona una ciudad:</label> <select
							id="ciudad" name="ciudad">
							<option value="">Elige tu ciudad</option>
							<%
							if (pelicula != null) {
								// Asegúrate de pasar el nombre de la película, no el id
								List<String> ciudades = metodos.obtenerCiudadesPorPelicula(pelicula.getTitulo());
								for (String ciudad : ciudades) {
							%>
							<option value="<%=ciudad%>"><%=ciudad%></option>
							<%
							}
							}
							%>
						</select>
					</div>

					<div class="combobox-item">
						<label for="cine">Selecciona un cine:</label> <select id="cine"
							name="cine">
							<option value="">Elige un cine</option>
						</select>
					</div>

					<div class="combobox-item">
						<label for="sala">Selecciona una sala:</label> <select id="sala"
							name="sala">
							<option value="">Elige una sala</option>
						</select>
					</div>

					<div class="combobox-item">
						<label for="horario">Selecciona un horario:</label> <select
							id="horario" name="horario">
							<option value="">Elige un horario</option>
							<%
							if (pelicula != null) {
								List<String> horarios = metodos.obtenerHorariosPorPelicula(pelicula.getId());
								for (String horario : horarios) {
							%>
							<option value="<%=horario%>"><%=horario%></option>
							<%
							}
							}
							%>
						</select>
					</div>
				</div>
				<!-- Campo oculto para el ID de la sala -->
				<input type="hidden" id="salaId" name="salaId" value="123">
				<!-- Este valor debe asignarse dinámicamente -->

				<button type="button" onclick="continuar()">Continuar</button>
				<script>
            // Modificar la función continuar para incluir el ID de la sala
            function continuar() {
                var cine = document.getElementById('cine').value;
                var horario = document.getElementById('horario').value;
                var sala = document.getElementById('sala').value; // Obtener el valor de la sala
                var fecha = new Date().toISOString().split('T')[0];
                var pelicula = "<%=tituloPelicula%>";
                var imagenPelicula = "<%=imagenPelicula%>";

						if (cine && horario && sala) { // Validar que se seleccionen cine, horario y sala
							window.location.href = 'butacas_intranet.jsp?cine='
									+ encodeURIComponent(cine) + '&horario='
									+ encodeURIComponent(horario) + '&fecha='
									+ encodeURIComponent(fecha) + '&pelicula='
									+ encodeURIComponent(pelicula) + '&imagen='
									+ encodeURIComponent(imagenPelicula)
									+ '&sala=' + encodeURIComponent(sala); // Pasar el ID de la sala
						} else {
							alert("Por favor, selecciona un cine, un horario y una sala.");
						}
					}
				</script>
			</form>
		</div>
	</div>
	<script>
					// Recuperar el valor almacenado en localStorage
					const usuarioGuardado = localStorage.getItem("usuario");

					// Verificar si el valor existe
					if (usuarioGuardado) {
						// Mostrar el valor en el elemento <p>
						document.getElementById("usuarioDisplay").textContent = usuarioGuardado;
					} else {
						// Si no se encuentra, mostrar un mensaje predeterminado
						document.getElementById("usuarioDisplay").textContent = "No se encontró el usuario.";
					}
				</script>
</body>
</html>