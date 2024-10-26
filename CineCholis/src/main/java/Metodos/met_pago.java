package Metodos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import Conexion.conexion;
import encrypt.Cifrado;

public class met_pago {

    public void procesarPago(String cardNumber, String expiryDate, String cvv, String fullName, String email) throws SQLException {
        Cifrado cifrado = new Cifrado();
        String encryptedCardNumber = cifrado.cifrar(cardNumber);
        String encryptedCvv = cifrado.cifrar(cvv);

        String sql = "INSERT INTO pagos (card_number, expiry_date, cvv, full_name, email) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBytes(1, encryptedCardNumber.getBytes());
            ps.setString(2, expiryDate);
            ps.setBytes(3, encryptedCvv.getBytes());
            ps.setString(4, fullName);
            ps.setString(5, email);
            ps.executeUpdate();
        }
    }
}
