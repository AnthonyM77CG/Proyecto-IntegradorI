<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.CineDAOimpl"%>
<%@ page import="model.Pelicula"%>
<%@ page import="dao.PeliculaDAOimpl"%>
<%@ page import="dao.PeliculasCinesDAOimpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CineCholis</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" type="text/css" href="css/carteleraa.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<link rel="icon" type="image/png" href="img/favicon.png">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	// Redirige al detalle de una película pasando su título como parámetro
	function redirigirDetalle(tituloPelicula) {
		window.location.href = 'detallesPelicula.jsp?titulo='
				+ encodeURIComponent(tituloPelicula);
	}

	// AJAX para filtrar películas
	function filtrarPeliculas() {
		const cineSeleccionado = $('#cineSeleccionado').val();
		const generoSeleccionado = $('#generoSeleccionado').val();

		$.ajax({
			url : './logicajsp/filtropeliculas.jsp',
			type : 'POST',
			data : {
				cineSeleccionado : cineSeleccionado,
				generoSeleccionado : generoSeleccionado
			},
			success : function(response) {
				$('#contenedorPeliculas').html(response);
			},
			error : function() {
				alert('Error al cargar las películas.');
			}
		});
	}

	$(document).ready(function() {
		$('#cineSeleccionado, #generoSeleccionado').change(function() {
			filtrarPeliculas();
		});

		$('#btnMostrarTodas').click(function() {
			$('#cineSeleccionado').val('');
			$('#generoSeleccionado').val('');
			filtrarPeliculas();
		});
	});
</script>
</head>
<body>
	<jsp:include page="/fragmentos/encabezado.jsp" />

	<main>
		<div class="cont-todo-cartelera">
			<div class="cont-encabezado-peli">
				<h1>Películas</h1>
			</div>
			<div class="cont-unido-peliculas">
				<div class="cont-filtro-peli">
					<h2>Filtrar Por:</h2>
					<form id="filtroForm">
						<div class="combox-filtro">
							<label for="cineSeleccionado">Cine:</label> <select
								class="styled-select" name="cineSeleccionado"
								id="cineSeleccionado">
								<option value="">Todos los cines</option>
								<%
								CineDAOimpl cineManager = new CineDAOimpl();
								List<String> cines = cineManager.obtenerCines();
								for (String cine : cines) {
									String[] cineData = cine.split(",");
									String cineId = cineData[0];
									String cineNombre = cineData[1];
								%>
								<option value="<%=cineId%>"><%=cineNombre%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="combox-filtro">
							<label for="generoSeleccionado">Género:</label> <select
								class="styled-select" name="generoSeleccionado"
								id="generoSeleccionado">
								<option value="">Todos los géneros</option>
								<%
								PeliculaDAOimpl peliculaManager = new PeliculaDAOimpl();
								List<String> generos = peliculaManager.obtenerGeneros();
								for (String genero : generos) {
								%>
								<option value="<%=genero%>"><%=genero%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="combox-filtro">
							<button type="button" id="btnMostrarTodas" class="styled-button">Mostrar
								todas las películas</button>
						</div>
					</form>
				</div>
				<div class="cont-cartelera-peli" id="contenedorPeliculas">
					<%
					PeliculasCinesDAOimpl relacionManager = new PeliculasCinesDAOimpl();
					List<Pelicula> peliculas = relacionManager.obtenerTodasLasPeliculas();
					if (peliculas.isEmpty()) {
					%>
					<p>No hay películas disponibles.</p>
					<%
					} else {
					for (Pelicula pelicula : peliculas) {
						String tituloPelicula = pelicula.getTitulo();
						String imagenPelicula = pelicula.getImagen();
					%>
					<div class="cont-pelicula">
						<a href="#" onclick="redirigirDetalle('<%=tituloPelicula%>')">
							<img
							src="img/<%=imagenPelicula != null && !imagenPelicula.isEmpty() ? imagenPelicula : "default.jpg"%>"
							alt="Imagen de la Película Detalle" id="vertical-image">
						</a>
						<h2><%=tituloPelicula%></h2>
						<p>
							Género:
							<%=pelicula.getGenero()%></p>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>
	</main>

	<jsp:include page="/fragmentos/footer.jsp" />

</body>
</html>


