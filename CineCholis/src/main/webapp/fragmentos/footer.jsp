<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Footer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
     footer {
    background-color: #0B1F3D;
    padding: 6px 0;
    flex-shrink: 10;
    text-align: center;
    justify-content: center;
    align-items: center;
}


.footer-container {
    display: flex;
    justify-content: center;
    max-width: 1200px;
    margin: 0 auto;
    background-color: #0B1F3D;
    color: white;
    width: 100%;
    height: 100%;
    box-sizing: border-box;
}

.footer-section {
   flex: 1;
    text-align: justify;
}

.footer-section h3 {
    font-size: 15px;
    margin-bottom: 30px;
    font-weight: bold;
}

.footer-section ul {
    list-style-type: none;
    padding: 0;
    margin-top: 10px;
}

.footer-section ul li {
    margin-bottom: 30px;
}

.footer-section ul li a {
    color: white;
    text-decoration: none;
    font-weight: normal;
    font-size: 15px;
}

.footer-section ul li a:hover {
    text-decoration: underline;
}

.footer-section img {
    margin-top: 20px;
    width: 150px;
}

.footer-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;
    background-color: #f8f8f8;
    font-family: Arial, sans-serif;
    border-top: 5px solid #E50246;
    justify-content: center;
    align-items: center;
    gap: 70px;
}
.footer-bottom .social-media,
.footer-bottom .download-app {
    display: flex;
    align-items: center;
}

.footer-bottom .social-media p,
.footer-bottom .download-app p {
    margin-right: 10px;
    font-size: 14px;
    color: #2c3e50;
}

.footer-bottom .social-media a,
.footer-bottom .download-app a {
    margin: 0 5px;
    text-decoration: none;
    font-size: 20px;
    color: #2c3e50;
}

.footer-bottom .libro-reclamaciones {
    font-size: 14px;
    color: #2c3e50;
    text-decoration: none;
}

.footer-bottom .libro-reclamaciones:hover {
    text-decoration: underline;
}

.icon-facebook::before {
    content: '\f09a';
    font-family: 'FontAwesome';
}

.icon-twitter::before {
    content: '\f099';
    font-family: 'FontAwesome';
}

.icon-instagram::before {
    content: '\f16d';
    font-family: 'FontAwesome';
}

.icon-youtube::before {
    content: '\f167';
    font-family: 'FontAwesome';
}

.icon-apple::before {
    content: '\f179';
    font-family: 'FontAwesome';
}

.icon-playstore::before {
    content: '\f3ab';
    font-family: 'FontAwesome';
}

.button-container {
    text-align: left;
}

.contact-button {
    display: inline-block;
    padding: 10px 4px;
    background-color: transparent;
    color: white;
    border: 2px solid white;
    border-radius: 10px;
    text-align: center;
    text-decoration: none;
    font-size: 14px;
    width: 300px;
    margin-top: 15px;
    box-shadow: 0 0 20px rgba(255, 255, 255, 0.4);
}

.contact-button i {
    margin-right: 10px;
}

.contact-button:hover {
    box-shadow: 0 0 30px rgba(255, 255, 255, 0.8);
}
    </style>
</head>
<body>
<footer>
    <div class="footer-container">
        <div class="footer-section">
            <h3>Nosotros</h3>
            <ul>
                <li><a href="#">Conócenos</a></li>
                <li><a href="#">Trabaja con nosotros</a></li>
                <li><a href="#">Ventas corporativas</a></li>
                <li><a href="#">Memoria de gestión de sostenibilidad 2023</a></li>
            </ul>
            <img src="img/huella.png" alt="Huella de Carbono">
        </div>
        <div class="footer-section">
            <h3>Atención al cliente</h3>
            <ul>
                <li><a href="#">Ver mi boleta electrónica</a></li>
                <li><a href="#">Ver lista de productos permitidos</a></li>
            </ul>
            <div class="button-container">
                <a href="#" class="contact-button">
                    <i class="fa fa-envelope"></i> Atención de Consultas<br> o Incidencias por Contáctanos.
                </a>
            </div>
        </div>
        <div class="footer-section">
            <h3>Políticas y condiciones</h3>
            <ul>
                <li><a href="#">Política de SST</a></li>
                <li><a href="#">Política de sostenibilidad</a></li>
                <li><a href="#">Política de diversidad e inclusión</a></li>
                <li><a href="#">Política de privacidad</a></li>
                <li><a href="#">Condiciones de uso y seguridad</a></li>
                <li><a href="#">Reglas de convivencia</a></li>
                <li><a href="#">Términos y condiciones</a></li>
            </ul>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="social-media">
            <p>Síguenos en:</p>
            <a href="#"><i class="fab fa-facebook"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
        <div class="download-app">
            <p>Descarga la app:</p>
            <a href="#"><i class="fab fa-apple"></i></a>
            <a href="#"><i class="fab fa-google-play"></i></a>
        </div>
        <a href="#" class="libro-reclamaciones">Libro de reclamaciones</a>
    </div>
</footer>
</body>
</html>