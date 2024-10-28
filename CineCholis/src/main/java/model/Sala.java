package model;

public class Sala {
    private int id;
    private int cineId; // ID del cine al que pertenece la sala
    private String nombre;
    private int capacidad; // Capacidad de la sala

    // Constructor vacío
    public Sala() {
    }

    // Constructor con parámetros
    public Sala(int id, int cineId, String nombre, int capacidad) {
        this.id = id;
        this.cineId = cineId;
        this.nombre = nombre;
        this.capacidad = capacidad; // Inicializar capacidad
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCineId() {
        return cineId; // Getter para cineId
    }

    public void setCineId(int cineId) {
        this.cineId = cineId; // Setter para cineId
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCapacidad() {
        return capacidad; // Getter para capacidad
    }

    public void setCapacidad(int capacidad) {
        if (capacidad < 0) {
            throw new IllegalArgumentException("La capacidad no puede ser negativa.");
        }
        this.capacidad = capacidad; // Setter para capacidad
    }
}

