package dao;

import java.util.List;

import model.Pelicula;	

public interface PeliculaDAO {
	// Método para agregar una película
    void agregarPelicula(String titulo, String sinopsis, String director, String idioma, String genero, String imagen);

    // Método para obtener todas las películas
    List<Pelicula> obtenerPeliculas();

    // Método para eliminar una película
    void eliminarPelicula(int id);

    // Método para obtener los géneros de películas
    List<String> obtenerGeneros();
}
