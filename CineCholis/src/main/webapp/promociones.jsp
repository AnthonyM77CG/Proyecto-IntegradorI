<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CineCholis</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700,800,900|Montserrat:300,400,800,900|Montserrat-Medium:500">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" href="css/promociones.css">
</head>
<body>
	
	<jsp:include page="/fragmentos/encabezado.jsp" />
	
	<div class="main-content">
        <h1>PROMOCIONES</h1>
         <h2>¡Ahorros increíbles en entradas!</h2>
        <div class="promotions-container">
            <div class="promotion promotion-left">
                <img src="img/ESTUDIANTES.png" alt="Promoción Estudiantes">
                <div class="promotion-content">
                    <h3>Los Estudiantes siempre ahorran en CineCholis</h3>
                    <p>Descuento disponible con identificación de estudiante con fotografía válida.</p>
                </div>
            </div>
            <div class="promotion promotion-right">
                <img src="img/MARTES.png" alt="Promoción Martes">
                <div class="promotion-content">
                    <h3>Los martes son para ahorrar entradas</h3>
                    <p>Todos los Martes, durante todo el año, aprovecha y comienza a ahorrar.</p>
                </div>
            </div>
            <div class="promotion promotion-left">
                <img src="img/Adultos mayores.png" alt="Promoción Mayores">
                <div class="promotion-content">
                    <h3>Los Mayores ahorran en entradas</h3>
                    <p>Nuestro objetivo es ofrecerte las películas que quieres a los precios que más te gustan. Por eso, los clientes mayores de 60 años pueden ahorrar en entradas todo el día, todos los días.</p>

                </div>
            </div>
            
            <a href="loginusuario_promocion.jsp" class="btn">Conseguir entradas</a>
        </div>
    </div>
    
    <jsp:include page="/fragmentos/footer.jsp" />
</body>
</html>