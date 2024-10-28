package dao;
	
public class DescuentoUtil {
	// Método para obtener el porcentaje de descuento según el tipo de promoción
    public static double obtenerPorcentajeDescuento(String tipoPromocion) {
        switch (tipoPromocion) {
            case "estudiantes":
                return 10.0;
            case "martes":
                return 20.0;
            case "mayores":
                return 15.0;
            default:
                return 0.0;
        }
    }
}
