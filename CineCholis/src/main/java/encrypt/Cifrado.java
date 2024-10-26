package encrypt;



import java.util.Base64;

public class Cifrado {

    // Método para cifrar utilizando Base64
    public String cifrar(String texto) {
        if (texto == null) {
            throw new IllegalArgumentException("El texto a cifrar no puede ser null");
        }
        return Base64.getEncoder().encodeToString(texto.getBytes());
    }

    // Método para descifrar
    public String descifrar(String textoCifrado) {
        if (textoCifrado == null) {
            throw new IllegalArgumentException("El texto cifrado no puede ser null");
        }
        return new String(Base64.getDecoder().decode(textoCifrado));
    }
}
