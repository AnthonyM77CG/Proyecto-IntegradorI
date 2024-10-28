package model;

public class Ciudades {
    private int id;
    private String nombre_ciudad;

    // Constructor
    public Ciudades(int id, String nombre_ciudad) {
        this.id = id;
        this.nombre_ciudad = nombre_ciudad;
    }

    // Método getter para id
    public int getId() {
        return id;
    }

    // Método setter para id
    public void setId(int id) {
        this.id = id;
    }

    // Método getter para nombre_ciudad
    public String getNombreCiudad() {
        return nombre_ciudad;
    }

    // Método setter para nombre_ciudad
    public void setNombreCiudad(String nombre_ciudad) {
        this.nombre_ciudad = nombre_ciudad;
    }
}
