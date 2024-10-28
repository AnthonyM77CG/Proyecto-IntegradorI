package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import config.conexion;
import model.Pelicula;

import java.sql.PreparedStatement;

public class CineDAOimpl {

	// Método para agregar un cine
	public void agregarCine(String nombre) {
		String query = "INSERT INTO cines (nombre) VALUES (?)";
		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
			pstmt.setString(1, nombre);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Método para obtener todos los cines
	// Método para obtener todos los cines
	// Método para obtener todos los cines
	public List<String> obtenerCines() {
		List<String> cines = new ArrayList<>();
		String sql = "SELECT id, nombre_cine FROM cines"; // Ajusta según tu tabla y columnas

		// Asegúrate de que 'conexion' es el nombre correcto de tu clase de conexión
		try (Connection con = conexion.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql)) {

			while (rs.next()) {
				int id = rs.getInt("id");
				String nombreCine = rs.getString("nombre_cine");
				cines.add(id + "," + nombreCine); // Almacena ID y nombre juntos
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Para depurar, muestra el error
		}
		return cines;
	}

	// Método para eliminar un cine
	public void eliminarCine(int id) {
		String query = "DELETE FROM cines WHERE id_cines = ?";
		try (Connection conn = conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static List<String> getCiudades() {
		List<String> ciudades = new ArrayList<>();
		String query = "SELECT nombre_ciudad FROM Ciudades";

		try (Connection conn = conexion.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				ciudades.add(rs.getString("nombre_ciudad"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ciudades;
	}

	public static List<String> getCines() {
		List<String> cines = new ArrayList<>();
		String query = "SELECT nombre_cine FROM Cines";

		try (Connection conn = conexion.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				cines.add(rs.getString("nombre_cine"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cines;
	}

// este metodo es para los combobox
	public static List<String> getCinesPorCiudad(String ciudad) {
		List<String> cines = new ArrayList<>();
		String query = "SELECT nombre_cine FROM Cines WHERE id_ciudad = (SELECT id FROM Ciudades WHERE nombre_ciudad = '"
				+ ciudad + "')";

		try (Connection conn = conexion.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				cines.add(rs.getString("nombre_cine"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cines;
	}

	public static Pelicula getPeliculaPorNombre(String nombrePelicula) {
		Pelicula pelicula = null;
		String query = "SELECT * FROM pelicula WHERE nombre_pelicula = '" + nombrePelicula + "'";

		try (Connection conn = conexion.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query)) {

			if (rs.next()) {
				pelicula = new Pelicula(0, rs.getString("nombre_pelicula"), rs.getString("sinopsis"),
						rs.getString("director"), rs.getString("idioma"), rs.getString("imagen"),
						rs.getString("genero"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return pelicula;
	}
}
