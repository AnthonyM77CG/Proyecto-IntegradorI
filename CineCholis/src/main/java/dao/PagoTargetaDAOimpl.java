package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import config.conexion;
import model.pago_targeta;

public class PagoTargetaDAOimpl implements PagoTarjetaDAO {
    
    // Método para almacenar el pago de tarjeta
    public void almacenarPago(pago_targeta pago) throws SQLException { // Declarar que puede lanzar SQLException
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Obtener la conexión
            conn = conexion.getConnection();
            
            // Preparar la consulta SQL para insertar el pago
            String sql = "INSERT INTO pagos_targeta (card_number, expiry_date, cvv, full_name, email, fecha, tipo_targeta) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pago.getCardNumber());
            pstmt.setString(2, pago.getExpiryDate());
            pstmt.setString(3, pago.getCvv());
            pstmt.setString(4, pago.getFullName());
            pstmt.setString(5, pago.getEmail());
            pstmt.setString(6, pago.getFecha());
            pstmt.setString(7, pago.getTipoTargeta()); // Asegúrate de que esta propiedad esté definida en tu clase `pago_targeta`
            
            // Ejecutar la inserción
            pstmt.executeUpdate();
            System.out.println("Pago almacenado con éxito.");
        } catch (SQLException e) {
            // Lanzar la excepción para manejarla en el JSP
            throw e; // Lanzar la excepción hacia arriba
        } finally {
            // Cerrar los recursos
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
