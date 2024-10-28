package dao;

import java.sql.SQLException;
import java.util.List;

import model.Cines;
import model.Pelicula;
import model.Sala;

public interface PeliculaCineDAO {
	// Método para obtener películas por ID de cine
    List<Pelicula> obtenerPeliculasPorCine(int cineId) throws SQLException;

    // Método para obtener películas por género
    List<Pelicula> obtenerPeliculasPorGenero(String genero) throws SQLException;

    // Método para obtener todas las películas
    List<Pelicula> obtenerTodasLasPeliculas() throws SQLException;

    // Método para obtener ciudades por película
    List<String> obtenerCiudadesPorPelicula(String nombrePelicula) throws SQLException;

    // Método para obtener horarios por película
    List<String> obtenerHorariosPorPelicula(int idPelicula) throws SQLException;

    // Método para obtener una película por su nombre
    Pelicula getPeliculaPorNombre(String nombrePelicula) throws SQLException;

    // Método para obtener cines por ciudad
    List<Cines> obtenerCinesPorCiudad(String ciudad) throws SQLException;

    // Método para obtener nombres de salas por nombre de cine
    List<Sala> obtenerSalasPorNombreCine(String nombreCine) throws SQLException;

    // Método para obtener todas las salas
    List<Sala> obtenerSalas() throws SQLException;
}
