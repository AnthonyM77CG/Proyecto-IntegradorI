package model;


public class Cines {
    private int id;
    private String nombre_cine;
    private String direccion_cine;
    private String telefono_cine;
    private String correo_cine;
    private int id_ciudad;

    // Getters y Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre_cine() {
        return nombre_cine;
    }

    public void setNombre_cine(String nombre_cine) {
        this.nombre_cine = nombre_cine;
    }

    public String getDireccion_cine() {
        return direccion_cine;
    }

    public void setDireccion_cine(String direccion_cine) {
        this.direccion_cine = direccion_cine;
    }

    public String getTelefono_cine() {
        return telefono_cine;
    }

    public void setTelefono_cine(String telefono_cine) {
        this.telefono_cine = telefono_cine;
    }

    public String getCorreo_cine() {
        return correo_cine;
    }

    public void setCorreo_cine(String correo_cine) {
        this.correo_cine = correo_cine;
    }

    public int getId_ciudad() {
        return id_ciudad;
    }

    public void setId_ciudad(int id_ciudad) {
        this.id_ciudad = id_ciudad;
    }
}
