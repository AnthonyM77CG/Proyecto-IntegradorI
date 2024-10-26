<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="Conexion.conexion"%>
<%@ page import="Metodos.DescuentoUtil"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Promociones CineCholis</title>
<link rel="stylesheet"
    href="https://fonts.googleapis.com/css?family=Lato:300,400,700,800,900|Montserrat:300,400,800,900|Montserrat-Medium:500">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" href="css/promociones.css">
</head>
<body>

    <jsp:include page="/fragmentos/encabezadousuario_intranet.jsp" />

    <div class="main-content">
        <h1>PROMOCIONES</h1>
        <h2>¡Ahorros increíbles en entradas!</h2>
        <div class="promotions-container">
            <div class="promotion promotion-left">
                <img src="img/ESTUDIANTES.png" alt="Promoción Estudiantes">
                <div class="promotion-content">
                    <h3>Los Estudiantes siempre ahorran en CineCholis</h3>
                    <p>Descuento disponible con identificación de estudiante con
                        fotografía válida.</p>
                    <a class="btn"
                        onclick="generarCodigoDescuento(this, 'estudiantes')">Conseguir
                        descuento</a> <br>
                    <p class="codigo-descuento"></p>
                </div>
            </div>
            <div class="promotion promotion-right">
                <img src="img/MARTES.png" alt="Promoción Martes">
                <div class="promotion-content">
                    <h3>Los martes son para ahorrar entradas</h3>
                    <p>Todos los Martes, durante todo el año, aprovecha y comienza
                        a ahorrar.</p>
                    <a class="btn" onclick="generarCodigoDescuento(this,'martes')">Conseguir
                        descuento</a> <br>
                    <p class="codigo-descuento"></p>
                </div>
            </div>
            <div class="promotion promotion-left">
                <img src="img/Adultos mayores.png" alt="Promoción Mayores">
                <div class="promotion-content">
                    <h3>Los Mayores ahorran en entradas</h3>
                    <p>Nuestro objetivo es ofrecerte las películas que quieres a
                        los precios que más te gustan. Por eso, los clientes mayores de 60
                        años pueden ahorrar en entradas todo el día, todos los días.</p>
                    <a class="btn" onclick="generarCodigoDescuento(this, 'mayores')">Conseguir
                        descuento</a>
                    <p class="codigo-descuento"></p>
                </div>
            </div>
        </div>
    </div>

    <script>
    function generarCodigoDescuento(elemento, tipoPromocion) {
        const parrafoCodigo = elemento.parentElement.querySelector('.codigo-descuento');

        if (parrafoCodigo.textContent !== "") {
            return;
        }

        const letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const numeros = '0123456789';

        let codigo = '';

        switch (tipoPromocion) {
        case 'estudiantes':
            // Código: 2 letras, 1 número, 2 letras
            codigo = letras.charAt(Math.floor(Math.random() * letras.length)) + // 1ra letra
                     letras.charAt(Math.floor(Math.random() * letras.length)) + // 2da letra
                     numeros.charAt(Math.floor(Math.random() * numeros.length)) + // número
                     letras.charAt(Math.floor(Math.random() * letras.length)) + // 3ra letra
                     letras.charAt(Math.floor(Math.random() * letras.length));  // 4ta letra
            break;

            case 'martes':
                // Código: 3 números, 2 letras
                codigo = numeros.charAt(Math.floor(Math.random() * numeros.length)) +
                         numeros.charAt(Math.floor(Math.random() * numeros.length)) +
                         numeros.charAt(Math.floor(Math.random() * numeros.length)) +
                         letras.charAt(Math.floor(Math.random() * letras.length)) +
                         letras.charAt(Math.floor(Math.random() * letras.length));
                break;

            case 'mayores':
                // Código: número, letra, número, letra, número
                codigo = numeros.charAt(Math.floor(Math.random() * numeros.length)) +
                         letras.charAt(Math.floor(Math.random() * letras.length)) +
                         numeros.charAt(Math.floor(Math.random() * numeros.length)) +
                         letras.charAt(Math.floor(Math.random() * letras.length)) +
                         numeros.charAt(Math.floor(Math.random() * numeros.length));
                break;

            default:
                parrafoCodigo.textContent = "Error en la promoción.";
                return;
        }

        const fechaActual = new Date();
        const diaSemana = fechaActual.getDay();

        if (tipoPromocion === 'martes' && diaSemana !== 2) {
            parrafoCodigo.textContent = "El descuento solo está disponible los martes.";
        } else {
            parrafoCodigo.textContent = "Tu código de descuento: " + codigo;
            parrafoCodigo.style.fontWeight = 'bold';
            parrafoCodigo.style.color = '#2ecc71';
            parrafoCodigo.style.fontSize = '16px';
            parrafoCodigo.style.marginTop = '30px';
        }

        // Enviar datos a la misma página
        const formData = new FormData();
        formData.append('tipoPromocion', tipoPromocion);
        formData.append('codigo', codigo);

        fetch(window.location.href, {
            method: 'POST',
            body: formData
        }).then(response => response.text())
          .then(data => console.log(data));
    }
    </script>

    
</body>
</html>
