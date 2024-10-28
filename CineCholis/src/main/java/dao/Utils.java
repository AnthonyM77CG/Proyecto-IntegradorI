package dao;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class Utils {
    public static String encodeURIComponent(String value) {
        try {
            return URLEncoder.encode(value, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // Manejo de errores si es necesario
            return value; // Retorna el valor sin codificar si hay un error
        }
    }
}
