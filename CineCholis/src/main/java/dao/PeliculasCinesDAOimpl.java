package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.conexion;
import model.Cines;
import model.Pelicula;
import model.Sala;

public class PeliculasCinesDAOimpl implements PeliculaCineDAO {
    
    // Método para obtener películas por ID de cine
    public List<Pelicula> obtenerPeliculasPorCine(int cineId) {
        List<Pelicula> peliculas = new ArrayList<>();
        String sql = "SELECT p.* FROM pelicula p " +
                     "JOIN funciones f ON p.id = f.id_pelicula " +
                     "WHERE f.id_cine = ?";

        try (Connection conn = conexion.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

        try (Connection conn = conexion.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

    // Método para obtener ciudades por película
    public List<String> obtenerCiudadesPorPelicula(String nombrePelicula) {
        List<String> ciudades = new ArrayList<>();
        String sql = "SELECT DISTINCT ci.nombre_ciudad " +
                     "FROM cines c " +
                     "JOIN funciones f ON c.id = f.id_cine " +
                     "JOIN pelicula p ON p.id = f.id_pelicula " +
                     "JOIN ciudades ci ON c.id_ciudad = ci.id " +
                     "WHERE p.nombre_pelicula = ?";

        try (Connection conn = conexion.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

    // Método para obtener horarios por película
    public List<String> obtenerHorariosPorPelicula(int idPelicula) {
        List<String> horarios = new ArrayList<>();
        String sql = "SELECT horario FROM funciones WHERE id_pelicula = ?";

        try (Connection conn = conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

public Pelicula getPeliculaPorNombre(String nombrePelicula) {
    Pelicula pelicula = null;
    String sql = "SELECT * FROM pelicula WHERE nombre_pelicula = ?";

    try (Connection conn = conexion.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

public List<Cines> obtenerCinesPorCiudad(String ciudad) {
    List<Cines> listaCines = new ArrayList<>();
    String query = "SELECT * FROM cines WHERE nombre_ciudad = ?"; // Cambia el nombre de la columna según corresponda

    try (Connection conn = conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setString(1, ciudad); // Usa el nombre de la ciudad en lugar del ID
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            // Crea una instancia de Cines y llena sus atributos
            Cines cine = new Cines();
            cine.setId(rs.getInt("id")); // Cambia "id" al nombre correcto de la columna
            cine.setNombre_cine(rs.getString("nombre_cine")); // Cambia "nombre_cine" al nombre correcto de la columna
            cine.setDireccion_cine(rs.getString("direccion_cine")); // Cambia "direccion_cine" al nombre correcto de la columna
            cine.setTelefono_cine(rs.getString("telefono_cine")); // Cambia "telefono_cine" al nombre correcto de la columna
            cine.setCorreo_cine(rs.getString("correo_cine")); // Cambia "correo_cine" al nombre correcto de la columna
            cine.setId_ciudad(rs.getInt("id_ciudad")); // Cambia "id_ciudad" al nombre correcto de la columna
            
            listaCines.add(cine);
        }
    } catch (SQLException e) {
        // Aquí podrías registrar el error en un log en lugar de solo imprimir la pila de errores
        e.printStackTrace();
    }
    return listaCines;
}
//Método para obtener nombres de salas por ciudad
public List<Sala> obtenerSalasPorNombreCine(String nombreCine) {
    List<Sala> salas = new ArrayList<>();
    String query = "SELECT s.id, s.cine_id, s.nombre, s.capacidad " +
                   "FROM salas s " +
                   "JOIN cines c ON s.cine_id = c.id " +
                   "WHERE c.nombre_cine = ?";

    try (Connection conn = conexion.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {

        stmt.setString(1, nombreCine);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            int cineId = rs.getInt("cine_id");
            String nombre = rs.getString("nombre");
            int capacidad = rs.getInt("capacidad");

            Sala sala = new Sala(id, cineId, nombre, capacidad);
            salas.add(sala);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return salas;
}



public List<Sala> obtenerSalas() {
    List<Sala> listaSalas = new ArrayList<>();
    String query = "SELECT * FROM salas"; // Asegúrate de que "salas" sea el nombre correcto de la tabla en tu DB

    try (Connection conn = conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            // Crea una instancia de Sala y llena sus atributos
            Sala sala = new Sala(
                rs.getInt("id"), // Cambia "id" al nombre correcto de la columna
                rs.getInt("cine_id"), // Cambia "cine_id" al nombre correcto de la columna
                rs.getString("nombre"), // Cambia "nombre" al nombre correcto de la columna
                rs.getInt("capacidad") // Cambia "capacidad" al nombre correcto de la columna
            );
            
            listaSalas.add(sala);
        }
    } catch (SQLException e) {
        // Aquí podrías registrar el error en un log en lugar de solo imprimir la pila de errores
        e.printStackTrace();
    }
    return listaSalas;
}
}