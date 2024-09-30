package Metodos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Conexion.conexion;

public class metFunciones {
	
	// Método para obtener todas las películas
    public List<Pelicula> obtenerTodasLasPeliculas() {
        List<Pelicula> peliculas = new ArrayList<>();
        String sql = "SELECT * FROM pelicula";

        try (Connection conn = conexion.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Pelicula pelicula = new Pelicula();
                pelicula.setId(rs.getInt("id"));
                pelicula.setTitulo(rs.getString("nombre_pelicula"));
                pelicula.setImagen(rs.getString("imagen"));
                pelicula.setGenero(rs.getString("genero"));
                peliculas.add(pelicula);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return peliculas;
    }
    
	public List<Pelicula> obtenerPeliculasPorCine(int cineId) {
		List<Pelicula> peliculas = new ArrayList<>();
		String sql = "SELECT p.* FROM pelicula p " + "JOIN funciones f ON p.id = f.id_pelicula "
				+ "WHERE f.id_cine = ?";

		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, cineId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Pelicula pelicula = new Pelicula();
				pelicula.setId(rs.getInt("id"));
				pelicula.setTitulo(rs.getString("nombre_pelicula"));
				pelicula.setGenero(rs.getString("genero"));
				pelicula.setImagen(rs.getString("imagen"));
				peliculas.add(pelicula);
			}
			System.out.println("Películas encontradas: " + peliculas.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return peliculas;
	}

	// Método para obtener películas por género
	public List<Pelicula> obtenerPeliculasPorGenero(String genero) {
		List<Pelicula> peliculas = new ArrayList<>();
		String sql = "SELECT * FROM pelicula WHERE genero = ?";

		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, genero);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Pelicula pelicula = new Pelicula();
				pelicula.setId(rs.getInt("id"));
				pelicula.setTitulo(rs.getString("nombre_pelicula"));
				pelicula.setImagen(rs.getString("imagen"));
				pelicula.setGenero(rs.getString("genero"));
				peliculas.add(pelicula);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return peliculas;
	}

	// Método para obtener los detalles de una película por nombre
	public Pelicula getPeliculaPorNombre(String nombrePelicula) {
		Pelicula pelicula = null;
		String sql = "SELECT * FROM pelicula WHERE nombre_pelicula = ?";

		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nombrePelicula);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				pelicula = new Pelicula();
				pelicula.setId(rs.getInt("id"));
				pelicula.setTitulo(rs.getString("nombre_pelicula"));
				pelicula.setImagen(rs.getString("imagen"));
				pelicula.setSinopsis(rs.getString("sinopsis"));
				pelicula.setDirector(rs.getString("director"));
				pelicula.setIdioma(rs.getString("idioma"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pelicula;
	}

	// Método para obtener las ciudades donde se proyecta una película
	public List<String> obtenerCiudadesPorPelicula(String nombrePelicula) {
		List<String> ciudades = new ArrayList<>();
		String sql = "SELECT DISTINCT ci.nombre_ciudad " + "FROM cines c " + "JOIN funciones f ON c.id = f.id_cine "
				+ "JOIN pelicula p ON p.id = f.id_pelicula " + "JOIN ciudades ci ON c.id_ciudad = ci.id "
				+ "WHERE p.nombre_pelicula = ?";

		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, nombrePelicula);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ciudades.add(rs.getString("nombre_ciudad"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ciudades;
	}

	// Método para obtener los horarios de una película
	public List<String> obtenerHorariosPorPelicula(int idPelicula) {
		List<String> horarios = new ArrayList<>();
		String sql = "SELECT horario FROM funciones WHERE id_pelicula = ?";

		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, idPelicula);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				horarios.add(rs.getString("horario"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return horarios;
	}
	
	public Pelicula getPeliculaPorId(int id) {
        Pelicula pelicula = null;

        // Consulta SQL para obtener los detalles de la película por ID
        String sql = "SELECT * FROM pelicula WHERE id = ?";

        try {
            // Establecer la conexión a la base de datos
            Connection conn = conexion.getConnection();  // Asumiendo que tienes una clase ConexionBD para manejar la conexión
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);  // Asignar el ID al parámetro en la consulta

            // Ejecutar la consulta
            ResultSet rs = stmt.executeQuery();

            // Si la película existe, crear un objeto Pelicula
            if (rs.next()) {
                pelicula = new Pelicula(
                    rs.getInt("id"),
                    rs.getString("nombre_pelicula"),
                    rs.getString("sinopsis"),
                    rs.getString("director"),
                    rs.getString("idioma"),
                    rs.getString("genero"),
                    rs.getString("imagen")
                );
            }

            // Cerrar la conexión y los recursos
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pelicula;  // Retorna la película o null si no se encontró
    }
}
