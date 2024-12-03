	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contáctanos</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="icon" type="image/png" href="img/favicon.png">
    <!-- Estilos para el popup -->
    <style>
        #popup {
            display: none; /* Oculto por defecto */
            position: fixed;
            left: 50%;	
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
            z-index: 1000; /* Por encima de todo */
        }
        #popup h3 {
            margin-bottom: 10px;
        }
        #popup button {
            padding: 10px 20px;
            background-color: #d9534f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        #popup button:hover {
            background-color: #c9302c;
        }
        #overlay {
            display: none; /* Oculto por defecto */
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999; /* Por debajo del popup pero encima del resto */
        }
    </style>
</head>
<body>
<jsp:include page="/fragmentos/encabezado.jsp" />

<main>
    <div class="contenedor-contactanos">
        <h2>Contáctanos</h2>
        <p class="mensaje-consulta">Atención de Consultas o Reclamos</p>
        <p class="mensaje-completar">Por favor, complete todos los campos solicitados.</p>
        
        <form id="contactForm" action="https://formsubmit.co/cinecholis@gmail.com" method="POST">
            <div class="fila-contacto">
                <div class="campo">
                    <label for="apellidos">Apellidos</label>
                    <input type="text" id="apellidos" name="apellidos" maxlength="50" required>
                </div>
                <div class="campo">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" maxlength="50" required>
                </div>
            </div>
        
            <div class="fila-contacto">
                <div class="campo">
                    <label for="telefono">Teléfono o celular</label>
                    <input type="tel" id="telefono" name="telefono" maxlength="15" required>
                </div>
                <div class="campo">
                    <label for="correo">Correo electrónico</label>
                    <input type="email" id="correo" name="correo" maxlength="50" required>
                </div>
            </div>
        
            <div class="fila-contacto">
                <label for="mensaje">Mensaje</label>
                <textarea id="mensaje" name="mensaje" rows="5" maxlength="500" placeholder="Ingrese aquí los detalles de su consulta o reclamo." required></textarea>
                <p class="caracteres-restantes">Caracteres restantes: 500</p>
            </div>
            
            <div class="fila-contacto">
                <button type="submit">Enviar</button>
                
            </div>
        </form>
    </div>
</main>

<!-- Ventana emergente -->
<div id="overlay"></div> <!-- Fondo oscuro -->
<div id="popup">
    <h3>¡Formulario enviado con éxito!</h3>
    <p>Gracias por contactarnos, nos pondremos en contacto contigo pronto.</p>
    <button id="closePopup">Cerrar</button>
</div>

<jsp:include page="/fragmentos/footer.jsp" />

<!-- Script para mostrar la ventana emergente si el formulario fue enviado -->
<script>
    // Verifica si la URL contiene "sent=true" para mostrar el popup
    const urlParams = new URLSearchParams(window.location.search);
    const formSent = urlParams.get('sent');

    if (formSent) {
        // Mostrar el popup si el formulario ha sido enviado
        document.getElementById('popup').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    // Listener para cerrar el popup
    document.getElementById('closePopup').addEventListener('click', function() {
        document.getElementById('popup').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
        
        // Elimina el parámetro 'sent' de la URL
        urlParams.delete('sent');
        window.history.replaceState({}, document.title, window.location.pathname + '?' + urlParams.toString());
    });
</script>
</body>
</html>

