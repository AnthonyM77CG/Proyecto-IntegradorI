package dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import config.conexion;
import model.Pelicula;

public class Comboboxdulceria {

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
        String query = "SELECT nombre_cine FROM Cines WHERE id_ciudad = (SELECT id FROM Ciudades WHERE nombre_ciudad = '" + ciudad + "')";

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
            pelicula = new Pelicula(
                0, rs.getString("nombre_pelicula"),
                rs.getString("sinopsis"),
                rs.getString("director"),
                rs.getString("idioma"),
                rs.getString("imagen"),
                rs.getString("genero")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return pelicula;
}
}
