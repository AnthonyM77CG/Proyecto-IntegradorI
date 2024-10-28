package model;

public class pago_targeta {
    private String cardNumber;
    private String expiryDate;
    private String cvv;
    private String fullName;
    private String email;
    private String fecha;
    private String tipoTargeta;

    // Constructor predeterminado
    public pago_targeta() {}

    // Constructor con parámetros
    public pago_targeta(String cardNumber, String expiryDate, String cvv, String fullName, String email, String fecha, String tipoTargeta) {
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
        this.fullName = fullName;
        this.email = email;
        this.fecha = fecha;
        this.tipoTargeta = tipoTargeta;
    }

    // Getters y Setters
    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getTipoTargeta() {
        return tipoTargeta;
    }

    public void setTipoTargeta(String tipoTargeta) {
        this.tipoTargeta = tipoTargeta;
    }
}
