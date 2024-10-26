<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pago Exitoso</title>
    <link rel="stylesheet" type="text/css" href="css/pago_con_exito.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="success-container">
        <div class="check-icon">
            <img src="img/pagoexito.png" alt="Check Icon">
        </div>
        <h1>¡Pago Exitoso!</h1>
        <p>Gracias por su pago. Su transacción ha sido procesada con éxito.</p>

        <p>Seleccione para ver su comprobante de pago.</p>
        <a href="comprobante.jsp?full-name=<%= URLEncoder.encode(request.getParameter("full-name"), "UTF-8") %>&pelicula=<%= URLEncoder.encode(request.getParameter("pelicula"), "UTF-8") %>&cine=<%= URLEncoder.encode(request.getParameter("cine"), "UTF-8") %>&sala=<%= URLEncoder.encode(request.getParameter("sala"), "UTF-8") %>&asientos=<%= URLEncoder.encode(request.getParameter("asientos"), "UTF-8") %>&total=<%= URLEncoder.encode(request.getParameter("total"), "UTF-8") %>&fecha=<%= URLEncoder.encode(request.getParameter("fecha"), "UTF-8") %>&horario=<%= URLEncoder.encode(request.getParameter("horario"), "UTF-8") %>&forma_pago=<%= URLEncoder.encode(request.getParameter("forma_pago"), "UTF-8") %>" class="btn-comprobante">Ver comprobante de pago</a>
    </div>
</body>
</html>
