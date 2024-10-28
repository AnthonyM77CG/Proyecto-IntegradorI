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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" type="text/css" href="css/carteleraa.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Cartelera</title>

<script>
    // Función para redirigir según la película
    function checkLogin(tituloPelicula) {
        switch (tituloPelicula) {
            case 'El Padrino':
                window.location.href = 'elpadrino.jsp';
                break;
            case 'La Matrix':
                window.location.href = 'lamatrix.jsp';
                break;
            case 'El Señor de los Anillos: La Comunidad del Anillo':
                window.location.href = 'señor_delos_anillos.jsp';
                break;
            case 'Parasite':
                window.location.href = 'parasite.jsp';
                break;
            case 'Amélie':
                window.location.href = 'amelie.jsp';
                break;
            case 'Alien':
                window.location.href = 'alien.jsp';
                break;
            default:
                alert('No hay página disponible para esta película.');
                break;
        }
    }

    // Función AJAX para obtener las películas filtradas
    function filtrarPeliculas() {
        const cineSeleccionado = $('#cineSeleccionado').val();
        const generoSeleccionado = $('#generoSeleccionado').val();
        
        $.ajax({
            url: './logicajsp/filtropeliculas.jsp',  // Aquí llamamos a una página JSP que maneje la lógica de filtrado
            type: 'POST',
            data: {
                cineSeleccionado: cineSeleccionado,
                generoSeleccionado: generoSeleccionado
            },
            success: function(response) {
                $('#contenedorPeliculas').html(response);  // Actualizamos la sección de películas
            },
            error: function() {
                alert('Error al cargar las películas.');
            }
        });
    }

    // Función para mostrar todas las películas
    function mostrarTodasLasPeliculas() {
        $('#cineSeleccionado').val(''); // Limpiar el filtro de cine
        $('#generoSeleccionado').val(''); // Limpiar el filtro de género
        filtrarPeliculas(); // Llamar a la función para actualizar la lista sin filtros
    }

    // Escuchar cambios en los selectores
    $(document).ready(function() {
        $('#cineSeleccionado, #generoSeleccionado').change(function() {
            filtrarPeliculas();
        });

        // Escuchar el botón para mostrar todas las películas
        $('#btnMostrarTodas').click(function() {
            mostrarTodasLasPeliculas();
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
					<!-- Formulario para filtrar por Cine y Género -->
					<form id="filtroForm">
						<div class="combox-filtro">
							<label for="cineSeleccionado">Cine:</label> 
							<select class="styled-select" name="cineSeleccionado" id="cineSeleccionado">
								<option value="">Todos los cines</option>
								<%
								CineDAOimpl cineManager = new CineDAOimpl();
																																List<String> cines = cineManager.obtenerCines();
																																String cineSeleccionado = request.getParameter("cineSeleccionado");
																																for (String cine : cines) {
																																	String[] cineData = cine.split(",");
																																	String cineId = cineData[0];
																																	String cineNombre = cineData[1];
								%>
								<option value="<%=cineId%>" <%=cineSeleccionado != null && cineSeleccionado.equals(cineId) ? "selected" : ""%>><%=cineNombre%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="combox-filtro">
							<label for="generoSeleccionado">Género:</label> 
							<select class="styled-select" name="generoSeleccionado" id="generoSeleccionado">
								<option value="">Todos los géneros</option>
								<%
								PeliculaDAOimpl peliculaManager = new PeliculaDAOimpl();
																										List<String> generos = peliculaManager.obtenerGeneros();
																										String generoSeleccionado = request.getParameter("generoSeleccionado");
																										for (String genero : generos) {
								%>
								<option value="<%=genero%>" <%=generoSeleccionado != null && generoSeleccionado.equals(genero) ? "selected" : ""%>><%=genero%></option>
								<%
								}
								%>
							</select>
						</div>

						<!-- Botón para mostrar todas las películas -->
						<div class="combox-filtro">
							<button type="button" id="btnMostrarTodas" class="styled-button">Mostrar todas las películas</button>
						</div>
					</form>
				</div>

				<div class="cont-cartelera-peli" id="contenedorPeliculas">
					<!-- Las películas filtradas se cargarán aquí -->
					<%
					cineSeleccionado = request.getParameter("cineSeleccionado");
											generoSeleccionado = request.getParameter("generoSeleccionado");
											PeliculasCinesDAOimpl relacionManager = new PeliculasCinesDAOimpl();
											List<Pelicula> peliculas = new ArrayList<>();

											try {
												if (cineSeleccionado != null && !cineSeleccionado.isEmpty()) {
													int cineId = Integer.parseInt(cineSeleccionado);
													peliculas = relacionManager.obtenerPeliculasPorCine(cineId);
												} else if (generoSeleccionado != null && !generoSeleccionado.isEmpty()) {
													peliculas = relacionManager.obtenerPeliculasPorGenero(generoSeleccionado);
												} else {
													peliculas = relacionManager.obtenerTodasLasPeliculas();
												}

												if (peliculas.isEmpty()) {
					%>
					<p>No hay películas disponibles para la selección actual.</p>
					<%
					} else {
					for (Pelicula pelicula : peliculas) {
						String tituloPelicula = pelicula.getTitulo();
						String imagenPelicula = pelicula.getImagen(); // Obtener el nombre de la imagen
					%>
					<div class="cont-pelicula">
						<a href="#" onclick="checkLogin('<%=tituloPelicula%>')"> 
							<img src="img/<%= imagenPelicula != null && !imagenPelicula.isEmpty() ? imagenPelicula : "default.jpg" %>" alt="Imagen de la Película Detalle" id="vertical-image">

						</a>
						<h2><%=tituloPelicula%></h2>
						<p>Género: <%=pelicula.getGenero()%></p>
					</div>
					<%
					}
					}
					} catch (Exception e) {
					out.println("<p>Error al cargar las películas: " + e.getMessage() + "</p>");
					}
					%>
				</div>
			</div>
		</div>
	</main>

	<footer>
		<!-- Contenido del pie de página -->
	</footer>
	
</body>
</html>


