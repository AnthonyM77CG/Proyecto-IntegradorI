package dao;

import java.util.Date;

public class ventaentradas {
    private int id;
    private int idUsuario;
    private int idAsiento;
    private Date fechaCompra;
    private double montoTotal;

    // Constructor
    public ventaentradas(int id, int idUsuario, int idAsiento, Date fechaCompra, double montoTotal) {
        this.id = id;
        this.idUsuario = idUsuario;
        this.idAsiento = idAsiento;
        this.fechaCompra = fechaCompra;
        this.montoTotal = montoTotal;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdAsiento() {
        return idAsiento;
    }

    public void setIdAsiento(int idAsiento) {
        this.idAsiento = idAsiento;
    }

    public Date getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(Date fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public double getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(double montoTotal) {
        this.montoTotal = montoTotal;
    }
}
