package dao;

import java.sql.SQLException;

import model.pago_targeta;

public interface PagoTarjetaDAO {
	void almacenarPago(pago_targeta pago) throws SQLException;
}
