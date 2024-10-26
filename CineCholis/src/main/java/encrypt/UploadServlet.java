package encrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("imagen"); // nombre del input en el formulario
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Ruta donde se guardará la imagen
        File uploads = new File(getServletContext().getRealPath("/img"));
        if (!uploads.exists()) {
            uploads.mkdirs(); // Crea el directorio si no existe
        }
        
        File file = new File(uploads, fileName);
        filePart.write(file.getAbsolutePath()); // Guarda la imagen en el servidor
        
        // Envía una respuesta al usuario
        response.getWriter().write("Archivo subido con éxito: " + fileName);
    }
}
