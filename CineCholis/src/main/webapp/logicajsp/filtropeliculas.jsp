<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Metodos.Pelicula"%>
<%@ page import="Metodos.metPeliculasCines"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
String cineSeleccionado = request.getParameter("cineSeleccionado");
String generoSeleccionado = request.getParameter("generoSeleccionado");
metPeliculasCines relacionManager = new metPeliculasCines();
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
%>
<div class="cont-pelicula">
    <a href="#" onclick="checkLogin('<%=tituloPelicula%>')"> 
        <img src="img/<%=pelicula != null ? pelicula.getImagen() : "default.jpg"%>" alt="Imagen de la Película Detalle" id="vertical-image">
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
