package Metodos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Conexion.conexion;

public class met_registro {

    // Método para verificar si el email ya existe en la base de datos
    public static boolean esEmailExistente(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ?";

        try {
            conn = conexion.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Retorna true si ya existe el email
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cierra recursos
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    // Método para registrar un usuario
    public static boolean registrarUsuario(String nombre, String apellidos, String celular, String dni, String email, String password) {
        if (nombre == null || nombre.isEmpty() || 
            apellidos == null || apellidos.isEmpty() || 
            celular == null || celular.isEmpty() || 
            dni == null || dni.isEmpty() || 
            email == null || email.isEmpty() || 
            password == null || password.isEmpty()) {
            
            System.out.println("Todos los campos son obligatorios.");
            return false; // Retorna false si hay campos vacíos
        }

        if (esEmailExistente(email)) {
            System.out.println("El correo electrónico ya está registrado.");
            return false; // Retorna false si el email ya existe
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO usuarios (nombre, apellidos, celular, dni, email, rol, password, fecha_creacion) VALUES (?, ?, ?, ?, ?, 'usuario', ?, NOW())";

        try {
            conn = conexion.getConnection();
            if (conn == null) {
                System.out.println("Conexión fallida.");
                return false;
            }

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setString(2, apellidos);
            stmt.setString(3, celular);
            stmt.setString(4, dni);
            stmt.setString(5, email);
            stmt.setString(6, password); // Almacena la contraseña sin hash

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Filas afectadas: " + rowsAffected);
            return rowsAffected > 0; // Retorna true si se insertó al menos un registro

        } catch (SQLException e) {
            System.out.println("Error SQL: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            // Cierre de recursos
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println("Error SQL: " + e.getMessage());

                }
            }
        }
    }
}

