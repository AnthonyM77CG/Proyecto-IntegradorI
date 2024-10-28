package service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class DNIService {

    private static final String API_URL = "https://api.apis.net.pe/v2/reniec/dni?numero=";
    private static final String TOKEN = "apis-token-10244.FwkvlRQjdpD7G7g1HzFS7lUvp5ug6FL4"; // Reemplaza con tu token

    public static String consultarDNI(String dni) {
        StringBuilder result = new StringBuilder();
        HttpURLConnection conn = null;
        BufferedReader in = null;

        try {
            URL url = new URL(API_URL + dni); 
            conn = (HttpURLConnection) url.openConnection(); 
            conn.setRequestMethod("GET"); 
            conn.setRequestProperty("Authorization", "Bearer " + TOKEN); 
            conn.setRequestProperty("Accept", "application/json"); 
            conn.setRequestProperty("Referer", "https://apis.net.pe/consulta-dni-api"); 

            int responseCode = conn.getResponseCode(); 
            if (responseCode == HttpURLConnection.HTTP_OK) { 
                in = new BufferedReader(new InputStreamReader(conn.getInputStream())); 
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    result.append(inputLine);
                }
                System.out.println("Respuesta de la API: " + result.toString());
            } else {
                System.out.println("Error: HTTP response code " + responseCode);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close(); 
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                conn.disconnect(); 
            }
        }

        return result.toString();
    }
}
