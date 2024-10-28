package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.conexion;

public class Met_login {

    public String validarUsuario(String email, String password) {
        String rol = null;
        String sql = "SELECT rol FROM usuarios WHERE email = ? AND password = ?";

        try (Connection conn = conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Establecer parámetros de la consulta
            stmt.setString(1, email);
            stmt.setString(2, password);

            // Ejecutar consulta
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    rol = rs.getString("rol");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rol;
    }
} 