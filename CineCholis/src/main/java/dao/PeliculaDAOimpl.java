package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.conexion;

public class PeliculaDAOimpl implements PeliculaDAO{

    // Clase para representar una película
    public static class Pelicula {
        private int id;
        private String titulo;
        private String sinopsis;
        private String director;
        private String idioma;
        private String genero;
        private String imagen;

        // Constructor completo
        public Pelicula(int id, String titulo, String sinopsis, String director, String idioma, String genero, String imagen) {
            this.id = id;
            this.titulo = titulo;
            this.sinopsis = sinopsis;
            this.director = director;
            this.idioma = idioma;
            this.genero = genero;
            this.imagen = imagen;
        }

        // Constructor alternativo para el método obtenerPeliculasPorCine
        public Pelicula(int id, String titulo, String genero, String imagen) {
            this.id = id;
            this.titulo = titulo;
            this.genero = genero;
            this.imagen = imagen;
        }

        // Getters
        public int getId() {
            return id;
        }

        public String getTitulo() {
            return titulo;
        }

        public String getSinopsis() {
            return sinopsis;
        }

        public String getDirector() {
            return director;
        }

        public String getIdioma() {
            return idioma;
        }

        public String getGenero() {
            return genero;
        }

        public String getImagen() {
            return imagen;
        }
    }

    // Método para agregar una película
    public void agregarPelicula(String titulo, String sinopsis, String director, String idioma, String genero, String imagen) {
        String query = "INSERT INTO pelicula (nombre_pelicula, sinopsis, director, idioma, genero, imagen) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, titulo);
            pstmt.setString(2, sinopsis);
            pstmt.setString(3, director);
            pstmt.setString(4, idioma);
            pstmt.setString(5, genero);
            pstmt.setString(6, imagen);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para obtener todas las películas
    public List<model.Pelicula> obtenerPeliculas() {
        List<model.Pelicula> peliculas = new ArrayList<>();
        String query = "SELECT * FROM pelicula"; // Asegúrate de que la tabla se llame 'pelicula'
        try (Connection conn = conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                peliculas.add(new model.Pelicula(
                    rs.getInt("id"),
                    rs.getString("nombre_pelicula"),
                    rs.getString("sinopsis"),
                    rs.getString("director"),
                    rs.getString("idioma"),
                    rs.getString("genero"),
                    rs.getString("imagen")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return peliculas;
    }

    // Método para obtener películas por ID de cine
    

    // Método para eliminar una película
    public void eliminarPelicula(int id) {
        String query = "DELETE FROM pelicula WHERE id = ?";
        try (Connection conn = conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para obtener géneros
    public List<String> obtenerGeneros() {
        List<String> generos = new ArrayList<>();
        String query = "SELECT DISTINCT genero FROM pelicula"; // Asegúrate de que la columna 'genero' exista

        try (Connection conn = conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                generos.add(rs.getString("genero"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generos;
    }
}
