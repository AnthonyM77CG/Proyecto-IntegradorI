package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.conexion;
import model.Asiento;

public class AsientosDAOimpl {

    // Método para obtener los asientos por sala
    public ArrayList<Asiento> obtenerAsientosPorSala(int salaId) {
        ArrayList<Asiento> asientos = new ArrayList<>();
        try {
            Connection conn = conexion.getConnection();
            String sql = "SELECT fila, numero, estado FROM asientos WHERE sala_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, salaId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Asiento asiento = new Asiento();
                asiento.setFila(rs.getString("fila"));
                asiento.setNumero(rs.getInt("numero"));
                asiento.setEstado(rs.getString("estado"));
                asientos.add(asiento);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return asientos;
    }
}
