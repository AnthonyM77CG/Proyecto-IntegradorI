<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pasarela de Pago</title>
<link rel="stylesheet" type="text/css" href="css/pasarela_pagoo.css">
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const cardNumberInput = document.getElementById('card-number');
        const expiryDateInput = document.getElementById('expiry-date');
        const cvvInput = document.getElementById('cvv');
        const visaIcon = document.querySelector('img[alt="Visa"]');
        const mastercardIcon = document.querySelector('img[alt="Mastercard"]');
        const amexIcon = document.querySelector('img[alt="American Express"]');
        const yapeButton = document.getElementById('yape-button');
        const yapeForm = document.getElementById('yape-form');
        const cardPaymentForm = document.getElementById('card-payment-form');
        const paymentIcons = document.querySelector('.payment-icons');
        const paymentHeader = document.querySelector('.payment-header');
        
        
        cardPaymentForm.addEventListener('submit', function(event) {
            // Validar número de tarjeta
            let cardNumber = cardNumberInput.value.replace(/\s/g, '');
            const isAmex = cardNumber.startsWith('34') || cardNumber.startsWith('37');
            if ((!isAmex && cardNumber.length !== 16) || (isAmex && cardNumber.length !== 15)) {
                alert('Por favor, introduzca un número de tarjeta válido.');
                event.preventDefault();  // Evita que se envíe el formulario
                return;
            }

            // Validar fecha de vencimiento
            let expiryDate = expiryDateInput.value;
            if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
                alert('Por favor, introduzca una fecha de vencimiento válida en el formato MM/AA.');
                event.preventDefault();  // Evita que se envíe el formulario
                return;
            }

            // Validar CVV
            let cvv = cvvInput.value.replace(/\D/g, '');
            const maxCVVLength = isAmex ? 4 : 3;
            if (cvv.length !== maxCVVLength) {
            	alert(`Por favor, introduzca un CVV válido (${maxCVVLength} dígitos para ${isAmex ? 'American Express' : 'Visa/Mastercard'}).`);


                event.preventDefault();  // Evita que se envíe el formulario
                return;
            }
        });
        // Muestra el formulario de Yape y oculta el de tarjeta
        yapeButton.addEventListener('click', function() {
    cardPaymentForm.style.display = 'none';
    yapeForm.style.display = 'block';
    paymentIcons.style.display = 'none'; // Ocultar íconos de pago
    yapeButton.style.display = 'none'; // Ocultar botón de Yape
    document.getElementById('card-button').style.display = 'block'; // Mostrar botón de pagar con tarjeta
    paymentHeader.style.display = 'none'; // Ocultar el encabezado
});
        // Botón para volver al pago con tarjeta
        document.getElementById('card-button').addEventListener('click', function() {
    cardPaymentForm.style.display = 'block';
    yapeForm.style.display = 'none';
    paymentIcons.style.display = 'block'; // Mostrar íconos de pago
    yapeButton.style.display = 'block'; // Mostrar botón de Yape
    this.style.display = 'none'; // Ocultar botón de pagar con tarjeta
    paymentHeader.style.display = 'block'; // Mostrar el encabezado
});

        // Formatear y validar número de tarjeta
        cardNumberInput.addEventListener('input', function (e) {
			    let cardNumber = cardNumberInput.value.replace(/\s/g, '');
			
			    // Limitar a 16 dígitos (Visa y Mastercard) o 15 dígitos (Amex)
			    if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
			        if (cardNumber.length > 15) {
			            cardNumber = cardNumber.slice(0, 15);
			        }
			    } else {
			        if (cardNumber.length > 16) {
			            cardNumber = cardNumber.slice(0, 16);
			        }
			    }
            // Formatear en grupos de 4 dígitos para Visa/Mastercard o 4-6-5 para Amex
			    if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
			        cardNumber = cardNumber.replace(/(\d{4})(\d{6})(\d{0,5})/, '$1 $2 $3').trim();
			    } else {
			        cardNumber = cardNumber.replace(/(\d{4})(?=\d)/g, '$1 ').trim();
			    }
			    cardNumberInput.value = cardNumber;

			    // Validar tarjeta y mostrar solo el icono correspondiente
			    if (cardNumber.startsWith('4') && cardNumber.length === 19) {
			        // Visa
			        showOnlyIcon(visaIcon);
			    } else if (cardNumber.startsWith('5') && cardNumber.length === 19) {
			        // Mastercard
			        showOnlyIcon(mastercardIcon);
			    } else if ((cardNumber.startsWith('34') || cardNumber.startsWith('37')) && cardNumber.length === 17) {
			        // American Express
			        showOnlyIcon(amexIcon);
			    } else {
			        showAllIcons();
			    }
			});

        // Formatear y validar fecha de vencimiento
        expiryDateInput.addEventListener('input', function () {
            let expiryDate = expiryDateInput.value.replace(/\D/g, '');

            // Limitar a MM/AA
            if (expiryDate.length > 4) {
                expiryDate = expiryDate.slice(0, 4);
            }

            // Formatear como MM/AA
            if (expiryDate.length > 2) {
                expiryDate = expiryDate.slice(0, 2) + '/' + expiryDate.slice(2);
            }

            // Validar mes entre 01 y 12
            let month = expiryDate.slice(0, 2);
            if (month.length === 2 && (parseInt(month) < 1 || parseInt(month) > 12)) {
                expiryDate = '';
            }

            expiryDateInput.value = expiryDate;
        });

        // Limitar CVV a 3 dígitos para Visa/Mastercard y 4 dígitos para Amex
        cvvInput.addEventListener('input', function () {
            let cvv = cvvInput.value.replace(/\D/g, '');

            // Si es Amex, CVV es de 4 dígitos, sino es de 3 dígitos
            const isAmex = cardNumberInput.value.startsWith('34') || cardNumberInput.value.startsWith('37');
            const maxCVVLength = isAmex ? 4 : 3;

            if (cvv.length > maxCVVLength) {
                cvv = cvv.slice(0, maxCVVLength);
            }
            cvvInput.value = cvv;
        });

        function showOnlyIcon(iconToShow) {
            visaIcon.style.display = 'none';
            mastercardIcon.style.display = 'none';
            amexIcon.style.display = 'none';
            iconToShow.style.display = 'inline';
        }

        function showAllIcons() {
            visaIcon.style.display = 'inline';
            mastercardIcon.style.display = 'inline';
            amexIcon.style.display = 'inline';
        }
    });
    
</script>

</head>
<body>
    <jsp:include page="/fragmentos/encabezado_pago.jsp" />

<%
String asientos = request.getParameter("asientos");
int numAsientos = Integer.parseInt(request.getParameter("numAsientos"));
String pelicula = request.getParameter("pelicula");
String fecha = request.getParameter("fecha");
String horario = request.getParameter("horario");
String cine = request.getParameter("cine");
String imagen = request.getParameter("imagen");
String sala = request.getParameter("sala");
String usuario = request.getParameter("usuario");
String total = request.getParameter("total");

%>
<div class="main-content-pago">
    <div class="main-content-productos">
        <div class="left-panel-productos">
            <img src="img/<%= imagen != null ? imagen : "default.jpg" %>" alt="Imagen de la Película" class="cine-image-butacas" />
            <h2><%= pelicula != null ? pelicula : "Película no disponible" %></h2>
            <p>2D, Regular, Doblada</p>
            <p><strong><%= cine != null ? cine : "Cine no disponible" %></strong></p>
            <p>Fecha: <%= fecha != null ? fecha : "Fecha no disponible" %></p>
            <p>Horario: <%= horario != null ? horario : "Horario no disponible" %></p>
            <p>Sala: <%= sala != null ? sala : "Sala no disponible" %></p>
            <p>Butacas seleccionadas: <strong><%= (asientos != null && !asientos.isEmpty()) ? asientos : "Ninguna" %></strong></p>
            <div class="user-info">
                <p>Bienvenido, <strong><%= usuario %></strong></p>
                <form id="logoutForm" action="loginusuario.jsp" method="get" style="display:none;">
                    <input type="hidden" name="logout" value="true" />
                </form>
            </div>
        </div>

        <!-- Sección de pasarela de pago -->
        <div class="payment-panel">
            <h2 class="payment-header">Elige tu método de pago</h2>

            <div class="payment-icons">
                <img src="img/visa.png" alt="Visa" />
                <img src="img/mastercard.png" alt="Mastercard" />
                <img src="img/americanexpress.png" alt="American Express" />
            </div>

            <!-- Formulario de Pago con Tarjeta -->
            <form id="card-payment-form" action="logicajsp/logicapago.jsp" method="post">
                <input type="hidden" name="asientos" value="<%= asientos %>" />
                <input type="hidden" name="total" value="<%= total != null ? total : "0.00" %>" />
                <input type="hidden" name="usuario" value="<%= usuario %>" />
                <input type="hidden" name="cine" value="<%= cine %>" /> 
                <input type="hidden" name="sala" value="<%= sala %>" /> 
                <input type="hidden" name="pelicula" value="<%= pelicula %>" />
                <input type="hidden" name="fecha" value="<%= fecha %>" /> 
                <input type="hidden" name="horario" value="<%= horario %>" />
                
                <input type="hidden" name="forma_pago" value="Tarjeta" />

                <div class="form-group">
                    <input type="text" id="card-number" name="card-number" placeholder="Número de tarjeta" required />
                </div>
                <div class="form-group flex-group">
                    <input type="text" id="expiry-date" name="expiry-date" placeholder="Fecha de vencimiento MM/AA" required />
                    <input type="text" id="cvv" name="cvv" placeholder="CVV" required />
                </div>
                <div class="form-group">
                    <input type="text" id="full-name" name="full-name" placeholder="Nombre completo" required />
                </div>
                <div class="form-group">
                    <input type="email" id="email" name="email" value="<%= usuario %>" placeholder="Correo Electrónico" required readonly />
                </div>
                <p style="font-size: 14px; color: #333;">
                    Estimado usuario, por seguridad le enviaremos su comprobante de pago a su correo electrónico.
                </p>
                <div class="terms-total-container">
                    <div class="terms-and-conditions">
                        <input type="checkbox" id="terms" name="terms" required />
                        <label for="terms">Acepto los términos y condiciones</label>
                    </div>
                    <p>Total: <strong>S/. <%= (total != null && !total.isEmpty()) ? total : "0.00" %></strong></p>
                </div>
                <button type="submit" class="btn-pagar">Pagar</button>
            </form>

            <!-- Botón para Pagar con Yape -->
            <button id="yape-button" class="btn-yape">Pagar con Yape</button>

            <!-- Formulario de Pago con Yape -->
            <form id="yape-form" method="post" action="logicajsp/logica_yape.jsp" style="display:none;" onsubmit="return validarYape();">
                <h2>Pagar con Yape</h2>
                <p>Escanea el código QR para pagar con Yape</p>
                <img src="img/qryape.jpeg" alt="Código QR" class="qr-code" />
                
                <div class="form-group">
                    <input type="text" id="celular" name="celular" placeholder="Número de celular" required maxlength="14" oninput="formatCelular(this)" />
                    <small style="color: #666;">Ejemplo: 965 458 658</small>
                </div>
                
                <div class="form-group">
			        <input type="text" name="full-name" placeholder="Nombre Completo" required /> <!-- Campo de nombre completo visible -->
			    </div>
                <div class="form-group">
                    <input type="email" id="yape-email" name="email" value="<%= usuario %>" placeholder="Correo Electrónico" required readonly />
                </div>
                <p style="font-size: 14px; color: #333;">
                    Recibirá un comprobante de pago por correo.
                </p>
                
                <input type="hidden" name="asientos" value="<%= asientos %>" />
                <input type="hidden" name="total" value="<%= total != null ? total : "0.00" %>" />
                <input type="hidden" name="usuario" value="<%= usuario %>" />
                <input type="hidden" name="cine" value="<%= cine %>" />
                <input type="hidden" name="sala" value="<%= sala %>" />
                <input type="hidden" name="pelicula" value="<%= pelicula %>" />
                <input type="hidden" name="fecha" value="<%= fecha %>" /> 
                <input type="hidden" name="horario" value="<%= horario %>" />
                
                <input type="hidden" name="forma_pago" value="Yape" />
                
                
                <button type="submit" class="btn-confirmar">Confirmar Pago</button>
            </form>

            <button id="card-button" class="btn-pagar-targeta" style="display:none;">Pagar con Tarjeta</button>
        </div>
    </div>
</div>

</body>
</html>
