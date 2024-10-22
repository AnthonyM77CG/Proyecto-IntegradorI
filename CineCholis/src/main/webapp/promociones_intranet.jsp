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
<title>Insert title here</title>
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

	    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	    let codigo = '';
	    for (let i = 0; i < 8; i++) {
	        codigo += caracteres.charAt(Math.floor(Math.random() * caracteres.length));
	    }

	    const fechaActual = new Date();
	    const diaSemana = fechaActual.getDay();

	    switch (tipoPromocion) {
	        case 'estudiantes':
	            parrafoCodigo.textContent = "Tu código de descuento: " + codigo;
	            break;
	        case 'martes':
	            if (diaSemana === 2) {
	                parrafoCodigo.textContent = "Tu código de descuento: " + codigo;
	            } else {
	                parrafoCodigo.textContent = "El descuento solo está disponible los martes.";
	            }
	            break;
	        case 'mayores':
	            parrafoCodigo.textContent = "Tu código de descuento: " + codigo;
	            break;
	        default:
	            parrafoCodigo.textContent = "Error en la promoción.";
	            break;
	    }

	    parrafoCodigo.style.fontWeight = 'bold';
	    parrafoCodigo.style.color = '#2ecc71'; 
	    parrafoCodigo.style.fontSize = '16px';
	    parrafoCodigo.style.marginTop = '30px';

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


	<!-- Importa tu clase de conexión -->

	<%
    Connection conn = null;

    try {
        conn = conexion.getConnection(); // Usar la conexión de la clase
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Verifica si la solicitud es POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String tipoPromocion = request.getParameter("tipoPromocion");
        String codigo = request.getParameter("codigo");

        if (tipoPromocion != null && codigo != null) {
            String sql = "INSERT INTO descuentos (descripcion, codigo, porcentaje, fecha_inicio, fecha_fin) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, tipoPromocion);
                stmt.setString(2, codigo);
                stmt.setDouble(3, DescuentoUtil.obtenerPorcentajeDescuento(tipoPromocion));
                stmt.setDate(4, java.sql.Date.valueOf(LocalDate.now())); // Fecha de inicio
                stmt.setDate(5, java.sql.Date.valueOf(LocalDate.now().plusDays(30))); // Fecha de fin (un mes después)
                stmt.executeUpdate();
                out.println("Descuento agregado correctamente."); // Mensaje de éxito
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Error al agregar el descuento: " + e.getMessage()); // Mensaje de error
            } finally {
                if (conn != null) {
                    try {
                        conn.close(); // Cerrar la conexión
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
%>
</body>
</html>