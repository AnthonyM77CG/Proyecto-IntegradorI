package Metodos;

public class Funciones {
    private int id;
    private int idPelicula;
    private int idCine;
    private String horario;

    // Constructor
    public Funciones(int id, int idPelicula, int idCine, String horario) {
        this.id = id;
        this.idPelicula = idPelicula;
        this.idCine = idCine;
        this.horario = horario;
    }

    // Método getter para id
    public int getId() {
        return id;
    }

    // Método setter para id
    public void setId(int id) {
        this.id = id;
    }

    // Método getter para idPelicula
    public int getIdPelicula() {
        return idPelicula;
    }

    // Método setter para idPelicula
    public void setIdPelicula(int idPelicula) {
        this.idPelicula = idPelicula;
    }

    // Método getter para idCine
    public int getIdCine() {
        return idCine;
    }

    // Método setter para idCine
    public void setIdCine(int idCine) {
        this.idCine = idCine;
    }

    // Método getter para horario
    public String getHorario() {
        return horario;
    }

    // Método setter para horario
    public void setHorario(String horario) {
        this.horario = horario;
    }
}
