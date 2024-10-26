<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Metodos.Pelicula" %>
<%@ page import="Metodos.Cines" %>
<%@ page import="Metodos.metPeliculasCines" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reserva de Entradas</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/elpadrinoo.css">
    
    <%@ include file="logicajsp/logica_combobox.jsp" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        // Cargar los cines cuando se selecciona una ciudad
        $('#ciudad').change(function() {
            var ciudad = $(this).val();
            if (ciudad) {
                $.ajax({
                    url: 'logicajsp/get_cines.jsp',
                    type: 'GET',
                    data: { ciudad: ciudad },
                    success: function(data) {
                        $('#cine').html(data);
                    }
                });
            } else {
                $('#cine').html('<option value="">Elige tu cine favorito</option>');
                $('#sala').html('<option value="">Elige la sala</option>'); // Reinicia la sala
            }
        });

        // Cargar las salas cuando se selecciona un cine
        $('#cine').change(function() {
            var cine = $(this).val();
            if (cine) {
                $.ajax({
                    url: 'logicajsp/get_salas.jsp',
                    type: 'GET',
                    data: { cine: cine },
                    success: function(data) {
                        $('#sala').html(data);
                    }
                });
            } else {
                $('#sala').html('<option value="">Elige la sala</option>'); // Reinicia la sala
            }
        });
    });

   
    </script>
</head>
<body>
    <jsp:include page="/fragmentos/encabezado_iniciosesion.jsp" />

    <div id="movie-details-container">
        <div id="movie-details">
            <div id="details-content">
                <div id="vertical-image-container">
                    <%
                        // Obtener detalles de "El Padrino"
                        metPeliculasCines metodos = new metPeliculasCines();
                        Pelicula pelicula = metodos.getPeliculaPorNombre("Parasite");
                        
                        String imagenPelicula = (pelicula != null) ? pelicula.getImagen() : "default.jpg"; // Imagen por defecto
                    %>
                    <img src="img/<%= imagenPelicula %>" alt="Imagen de la Película Detalle" id="vertical-image">
                </div>
                <div id="synopsis">
                    <h2>Sinopsis</h2>
                    <p><%= pelicula != null ? pelicula.getSinopsis() : "Sinopsis no disponible" %></p>
                    <div class="details-section">
                        <h3>Director</h3>
                        <p><%= pelicula != null ? pelicula.getDirector() : "Información no disponible" %></p>
                    </div>
                    <div class="details-section">
                        <h3>Idioma</h3>
                        <p><%= pelicula != null ? pelicula.getIdioma() : "Información no disponible" %></p>
                    </div>
                    <div class="details-section">
                        <h3>Disponible</h3>
                        <p>REGULAR, 2D</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Comboboxes -->
        <div class="combobox-container">
    <form action="dulceria.jsp" method="get">
        <div class="combobox-row">
            <div class="combobox-item">
                <label for="ciudad">Selecciona una ciudad:</label>
                <select id="ciudad" name="ciudad">
                    <option value="">Donde estás ubicado</option>
                    <%
                        List<String> listaCiudades = metodos.obtenerCiudadesPorPelicula("Parasite");
                        for (String ciudad : listaCiudades) {
                    %>
                        <option value="<%= ciudad %>"><%= ciudad %></option>
                    <% } %>
                </select>
            </div>

           <div class="combobox-item">
			    <label for="cine">Selecciona un cine:</label>
			    <select id="cine" name="cine">
			        <option value="">Elige tu cine favorito</option>
			        <%
			            String ciudadParam = request.getParameter("ciudad");
			            if (ciudadParam != null && !ciudadParam.isEmpty()) {
			                List<Cines> listaCines = metodos.obtenerCinesPorCiudad(ciudadParam);
			                for (Cines cine : listaCines) {
			        %>
			                    <option value="<%= cine.getNombre_cine() %>"><%= cine.getNombre_cine() %></option>
			        <%
			                }
			            } else {
			        %>
			                <option value="">No se ha seleccionado ninguna ciudad</option>
			        <%
			            }
			        %>
			    </select>
			</div>


            <div class="combobox-item">
                <label for="horario">Selecciona un horario:</label>
                <select id="horario" name="horario">
                    <option value="">Elige tu mejor horario</option>
                    <%
                        List<String> listaHorarios = metodos.obtenerHorariosPorPelicula(4);
                        for (String horario : listaHorarios) {
                    %>
                        <option value="<%= horario %>"><%= horario %></option>
                    <% } %>
                </select>
            </div>

            <div class="combobox-item">
                <label for="sala">Selecciona una sala:</label>
                <select id="sala" name="sala">
                    <option value="">Elige la sala</option>
                </select>
            </div>
        </div>
        <input type="hidden" id="salaId" name="salaId" value="">

        <button type="button" id="continuarButton" onclick="continuar()">Continuar</button>

       <script>
            // Modificar la función continuar para incluir el ID de la sala
            function continuar() {
                var cine = document.getElementById('cine').value;
                var horario = document.getElementById('horario').value;
                var sala = document.getElementById('sala').value; // Obtener el valor de la sala
                var fecha = new Date().toISOString().split('T')[0];
                var pelicula = "Parasite";
                var imagenPelicula = "<%= imagenPelicula %>";

                if (cine && horario && sala) { // Validar que se seleccionen cine, horario y sala
                    window.location.href = 'butacas.jsp?cine=' + encodeURIComponent(cine) +  
                                            '&horario=' + encodeURIComponent(horario) + 
                                            '&fecha=' + encodeURIComponent(fecha) + 
                                            '&pelicula=' + encodeURIComponent(pelicula) +
                                            '&imagen=' + encodeURIComponent(imagenPelicula) +
                                            '&sala=' + encodeURIComponent(sala); // Pasar el ID de la sala
                } else {
                    alert("Por favor, selecciona un cine, un horario y una sala.");
                }
            }
        </script>
    </form>
</div>
        </div>
    
</body>
</html>
