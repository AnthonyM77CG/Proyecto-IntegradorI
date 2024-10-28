package model;

public class Asiento {
    private String fila;
    private int numero;
    private String estado; // "disponible", "ocupada", etc.

    // Getters y setters
    public String getFila() { return fila; }
    public void setFila(String fila) { this.fila = fila; }

    public int getNumero() { return numero; }
    public void setNumero(int numero) { this.numero = numero; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
