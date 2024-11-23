<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    // Comprobar si el usuario ha iniciado sesión
    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) {
        // Si no hay sesión, redirigir al inicio de sesión
        response.sendRedirect("loginusuario.jsp");
        return;
    }

    // Manejar el cierre de sesión
    String logout = request.getParameter("logout");
    if (logout != null) {
        // Invalidar la sesión
        session.invalidate(); 
        // Redirigir al inicio de sesión
        response.sendRedirect("loginusuario.jsp");
        return; // Terminar la ejecución del JSP
    }

    // Obtener detalles de la sesión o parámetros de la solicitud
     String pelicula = request.getParameter("pelicula");
     String fecha = request.getParameter("fecha");
     String horario = request.getParameter("horario");
     String cine = request.getParameter("cine");
    String asientos = request.getParameter("asientos");
    String imagen = request.getParameter("imagen"); 
    String salaIdStr = request.getParameter("sala");
    
    // Validar y convertir el número de asientos
    String numAsientosParam = request.getParameter("numAsientos");
    Integer numAsientos = 0; // Inicializa el valor por defecto

    // Verificar si el parámetro numAsientos está presente
    if (numAsientosParam != null && !numAsientosParam.isEmpty()) {
        try {
            numAsientos = Integer.parseInt(numAsientosParam);
        } catch (NumberFormatException e) {
            // Manejo de error: si no se puede convertir, se mantiene en 0
        }
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Reserva de Entradas</title>
    <link rel="stylesheet" type="text/css" href="css/seleccionentrad.css">
    <script src="js/selectbutacas.js" defer></script>
    
    <script>
document.addEventListener("DOMContentLoaded", function() {
    const btnCanje = document.querySelector('.btn-canje');
    const inputCodigo = document.getElementById('codigo');
    const precioGeneralInput = document.querySelector('input[name="precioGeneral"]');
    const precioMayoresInput = document.querySelector('input[name="precioMayores"]');
    const precioNinosInput = document.querySelector('input[name="precioNinos"]')
    
    const precioGeneralLabel = document.querySelector('.entradas-generales .entrada-item strong');
    const precioMayoresLabel = document.querySelector('.entradas-generales .mayores strong');
    const precioNinosLabel = document.querySelector('.entradas-generales .ninos strong');

    btnCanje.addEventListener('click', function() {
        const codigo = inputCodigo.value.trim();
        
        /// Regex para los formatos de códigos
        const regexEstudiante = /^[A-Za-z]{2}\d[A-Za-z]{2}$/;
        const regexMartes = /^\d{3}[A-Za-z]{2}$/;             // 3 números, 2 letras
        const regexMayores = /^\d[A-Za-z]\d[A-Za-z]\d$/;   //numero, letra, numero, letra

        if (regexEstudiante.test(codigo)) {
            // Código para estudiantes
            precioNinosInput.value = "10.00"; // Cambia el precio a 10
            precioNinosLabel.textContent = "S/10.00"; // Actualiza el texto en el label
            alert('Código para estudiantes canjeado correctamente. Precio reducido a S/10.00.');
        } else if (regexMartes.test(codigo)) {
            // Código para martes
            precioGeneralInput.value = "8.00"; // Cambia el precio a 8
            precioGeneralLabel.textContent = "S/8.00"; // Actualiza el texto en el label
            alert('Código para promoción de martes canjeado correctamente. Precio reducido a S/8.00.');
        } else if (regexMayores.test(codigo)) {
            // Código para mayores
            precioMayoresInput.value = "12.00"; // Cambia el precio a 12
            precioMayoresLabel.textContent = "S/12.00"; // Actualiza el texto en el label
            alert('Código para mayores canjeado correctamente. Precio reducido a S/12.00.');
        } else {
            alert('Código inválido. Asegúrate de ingresarlo correctamente.');
        }
    });
});
</script>



    
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const selectedSeats = new URLSearchParams(window.location.search).get('asientos');
        const maxEntradas = selectedSeats ? selectedSeats.split(',').length : 0; // Número máximo de entradas

        const selectedSeatsList = document.querySelector('.entradas-seleccionadas p strong');

        // Actualiza la visualización de entradas seleccionadas
        const updateSelectedSeatsDisplay = () => {
            const totalSelected = [...document.querySelectorAll('.cantidad-selector input')]
                .reduce((sum, input) => sum + parseInt(input.value), 0);
            selectedSeatsList.textContent = totalSelected + ' seleccionadas de ' + maxEntradas;
            
        };

        // Inicializar el conteo de entradas seleccionadas
        updateSelectedSeatsDisplay();

        // Implementación de incremento y decremento de entradas
        const updateCount = (increment, inputField) => {
            const currentValue = parseInt(inputField.value);
            const newValue = Math.max(0, currentValue + increment);
            inputField.value = newValue; // Actualiza el valor en el input
            updateSelectedSeatsDisplay();
        };

        document.querySelectorAll('.btn-mas').forEach(button => {
            button.addEventListener('click', () => {
                const totalSelected = [...document.querySelectorAll('.cantidad-selector input')]
                    .reduce((sum, input) => sum + parseInt(input.value), 0);
                if (totalSelected < maxEntradas) {
                    const inputField = button.parentElement.querySelector('input');
                    updateCount(1, inputField);
                }
            });
        });

        document.querySelectorAll('.btn-menos').forEach(button => {
            button.addEventListener('click', () => {
                const inputField = button.parentElement.querySelector('input');
                updateCount(-1, inputField);
            });
        });
    });
    

        // Código para cerrar sesión automáticamente al cerrar la pestaña
        window.addEventListener('beforeunload', function (event) {
            // Enviar una solicitud para cerrar sesión al servidor
            navigator.sendBeacon('logout.jsp');
        });
        
        document.addEventListener("DOMContentLoaded", function() {
            const updateTotal = () => {
                const generalCount = parseInt(document.getElementById("general").value) || 0;
                const mayoresCount = parseInt(document.getElementById("mayores").value) || 0;
                const ninosCount = parseInt(document.getElementById("ninos").value) || 0;

                const precioGeneral = parseFloat(document.querySelector('input[name="precioGeneral"]').value);
                const precioMayores = parseFloat(document.querySelector('input[name="precioMayores"]').value);
                const precioNinos = parseFloat(document.querySelector('input[name="precioNinos"]').value);

                const total = (generalCount * precioGeneral) + (mayoresCount * precioMayores) + (ninosCount * precioNinos);
                document.getElementById("total").value = total.toFixed(2); // Asigna el total al campo oculto
            };

            // Llama a updateTotal al modificar las cantidades
            document.querySelectorAll('.cantidad-selector input').forEach(input => {
                input.addEventListener('change', updateTotal);
            });
            // Llama a updateTotal al hacer clic en los botones
            document.querySelectorAll('.btn-mas, .btn-menos').forEach(button => {
                button.addEventListener('click', updateTotal);
            });
            
            // Inicializar el total al cargar la página
            updateTotal();
        });
        document.addEventListener("DOMContentLoaded", function() {
            const form = document.getElementById("form-reserva");
            const maxEntradas = new URLSearchParams(window.location.search).get('asientos').split(',').length; // Obtener el número máximo de entradas

            form.addEventListener("submit", function(event) {
                // Contar el número total de entradas seleccionadas
                const totalSelected = [...document.querySelectorAll('.cantidad-selector input')]
                    .reduce((sum, input) => sum + parseInt(input.value), 0);

                // Verificar si el total de entradas seleccionadas es igual al máximo
                if (totalSelected < maxEntradas) {
                    event.preventDefault(); // Prevenir el envío del formulario
                    alert(`Debes seleccionar toda la cantidad de entradas que escogiste antes de confirmar la reserva.`);
                }
            });
        });

    </script>
</head>
<body>
    <jsp:include page="/fragmentos/encabezado_entradas.jsp" />
    
    <div class="main-content-butacas-entradas">
        <!-- Panel Izquierdo -->
        <div class="left-panel-butacas">
            <img src="img/<%= imagen != null ? imagen : "default.jpg" %>" alt="Imagen de la Película" class="cine-image-butacas" />
            <h2><%= pelicula != null ? pelicula : "Película no disponible" %></h2>
            <p>2D, Regular, Doblada</p>
            <p><strong><%= cine != null ? cine : "Cine no disponible" %></strong></p>
            <p>Fecha: <%= fecha != null ? fecha : "Fecha no disponible" %></p>
            <p>Horario: <%= horario != null ? horario : "Horario no disponible" %></p>
            <p>Sala: <%= salaIdStr != null ? salaIdStr : "Sala no disponible" %></p>
            <p>Butacas seleccionadas: <strong>
                <%= (asientos != null) ? asientos : "Ninguna" %>
            </strong></p>
            <div class="user-info">
                <p>Bienvenido, <strong><%= usuario %></strong></p>
                <form id="logoutForm" action="loginusuario.jsp" method="get" style="display:none;">
		    <input type="hidden" name="logout" value="true" />
		</form>
            </div>
        </div>

        <!-- Panel Derecho -->
        <div class="right-panel-entradas">
            <h2>Selecciona tus entradas</h2>
            <p>¡Combínalas como prefieras! Recuerda que deben coincidir con el número de butacas que seleccionaste.</p>

            <div class="entradas-generales">
    <h3>Entradas generales</h3>
    <div class="entrada-item">
        <label for="general">General 2D OL</label>
        <span>Incluye servicio online</span>
        <strong>S/23.00</strong>
        <div class="cantidad-selector">
            <button type="button" class="btn-menos">-</button>
            <input type="text" id="general" name="general" value="0" readonly style="width: 40px; text-align: center;">
            <button type="button" class="btn-mas">+</button>
        </div>
        <input type="hidden" name="precioGeneral" value="23.00"> <!-- Precio general -->
    </div>
    <div class="entrada-item mayores">
        <label for="mayores">Mayores 60 años 2D OL</label>
        <span>Incluye servicio online. Precio más bajo</span>
        <strong>S/20.00</strong>
        <div class="cantidad-selector">
            <button type="button" class="btn-menos">-</button>
            <input type="text" id="mayores" name="mayores" value="0" readonly style="width: 40px; text-align: center;">
            <button type="button" class="btn-mas">+</button>
        </div>
        <input type="hidden" name="precioMayores" value="20.00"> <!-- Precio mayores -->
    </div>
    <div class="entrada-item ninos">
        <label for="ninos">Niños 2D OL</label>
        <span>Para niños de 2 a 11 años. Incluye servicio online. Precio más bajo</span>
        <strong>S/20.00</strong>
        <div class="cantidad-selector">
            <button type="button" class="btn-menos">-</button>
            <input type="text" id="ninos" name="ninos" value="0" readonly style="width: 40px; text-align: center;">
            <button type="button" class="btn-mas">+</button>
        </div>
        <input type="hidden" name="precioNinos" value="20.00"> <!-- Precio niños -->
    </div>
</div>


            <div class="codigo-promocional">
                <label for="codigo">Canjea tu código promocional:</label>
                <input type="text" id="codigo" name="codigo">
                <button type="button" class="btn-canje">Canjear</button>
            </div>

            <div class="entradas-seleccionadas">
                <p>Entradas seleccionadas: <strong>
                    <%= (numAsientos != null) ? numAsientos : 0 %>
                    de <%= (asientos != null) ? asientos.split(",").length : 0 %>
                </strong></p>
                <form id="form-reserva" action="Pasarela_pago.jsp" method="post">
                    <input type="hidden" name="asientos" value="<%= asientos != null ? asientos : "" %>">
                    <input type="hidden" name="numAsientos" value="<%= numAsientos != null ? numAsientos : 0 %>">
                    <input type="hidden" name="imagen" value="<%= imagen != null ? imagen : "default.jpg" %>">
                    <input type="hidden" name="pelicula" value="<%= pelicula != null ? pelicula : "" %>">
                    <input type="hidden" name="cine" value="<%= cine != null ? cine : "" %>">
                    <input type="hidden" name="fecha" value="<%= fecha != null ? fecha : "" %>">
                    <input type="hidden" name="horario" value="<%= horario != null ? horario : "" %>">
                    <input type="hidden" name="sala" value="<%= salaIdStr != null ? salaIdStr : "" %>">
                    <input type="hidden" name="usuario" value="<%= usuario != null ? usuario : "" %>">
                    
                    <input type="hidden" name="total" id="total" value="0">
                    <button type="submit" class="btn-confirmar">Confirmar Reserva</button>
                </form>
            </div>
        </div>
    </div>

    
</body>
</html>

