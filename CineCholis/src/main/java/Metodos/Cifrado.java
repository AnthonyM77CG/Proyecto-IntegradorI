package Metodos;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class Cifrado {

    private static final String ALGORITHM = "AES";
    private static final byte[] keyValue = "ClaveSecreta1234".getBytes(); // Clave de 16 bytes (128 bits)

    // Método para cifrar
    public static String cifrar(String datos) throws Exception {
        SecretKeySpec key = new SecretKeySpec(keyValue, ALGORITHM);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] cifradoBytes = cipher.doFinal(datos.getBytes());
        return Base64.getEncoder().encodeToString(cifradoBytes); // Codificamos el cifrado en Base64
    }

    // Método para descifrar
    public static String descifrar(String datosCifrados) throws Exception {
        SecretKeySpec key = new SecretKeySpec(keyValue, ALGORITHM);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] descifradoBytes = cipher.doFinal(Base64.getDecoder().decode(datosCifrados));
        return new String(descifradoBytes);
    }
}

