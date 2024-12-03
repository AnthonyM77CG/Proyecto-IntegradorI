<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CineCholis</title>
<link rel="stylesheet" type="text/css" href="css/principal.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<script src="js/carrusel.js" defer></script>
</head>
<body>
	<!-- FALTA ORDENAR EN ARCHIVOS JAVA PARA DESPUES CONECTARLO CON ESTOS FRAMES-->
	<%
	class Slide {
		String imagePath;
		String title;
		String description;
		String buttonText;

		public Slide(String imagePath, String title, String description, String buttonText) {
			this.imagePath = imagePath;
			this.title = title;
			this.description = description;
			this.buttonText = buttonText;
		}

		public String getImagePath() {
			return imagePath;
		}

		public String getTitle() {
			return title;
		}

		public String getDescription() {
			return description;
		}

		public String getButtonText() {
			return buttonText;
		}
	}

	List<Slide> slides = new ArrayList<>();
	slides.add(new Slide("img/alien.jpeg", "Alien: Romulus",
			"Vuelve a las raíces de la exitosa franquicia ALIEN, mientras exploran una estación espacial abandonada.",
			"Comprar"));
	slides.add(new Slide("img/amelie.jpg", "Amelie",
			"Cuando las luces se apagan en el viejo teatro de Central Park, las marionetas recobran vida. Entre ellas, Don.",
			"Comprar"));
	slides.add(new Slide("img/elpadrino.jpg", "El Padrino",
			"Las familias mafiosas de Nueva York entran en conflicto cuando el capo de una de las más poderosas, Vito Corleone, se opone a que la Cosa Nostra entre en el negocio del tráfico de drogas. Como consecuencia, sufre un atentado que le deja al borde de la muerte.",
			"Comprar"));

	String mision = "Nuestra misión es brindar una experiencia cinematográfica de alta calidad, donde nuestros clientes puedan disfrutar de las mejores películas en un ambiente confortable y moderno.";
	String vision = "Ser el cine preferido de nuestra comunidad, reconocidos por nuestro excelente servicio y la innovación en la experiencia cinematográfica.";
	String[] objetivos = { "Ofrecer una selección variada de películas para todos los gustos.",
			"Garantizar la satisfacción del cliente en cada visita.",
			"Incorporar tecnologías avanzadas en nuestras salas de cine." };
	String[] valores = { "Compromiso con la calidad.", "Innovación constante.", "Responsabilidad social.",
			"Respeto hacia nuestros clientes y colaboradores." };
	%>


	<jsp:include page="/fragmentos/encabezadousuario_intranet.jsp" />

	<div class="container">


		<div class="hero">
			<div class="carousel">
				<div class="carousel-images">
					<%
					for (Slide slide : slides) {
					%>
					<div class="carousel-slide">
						<img src="<%=slide.getImagePath()%>" alt="<%=slide.getTitle()%>" />
						<div class="slide-content">
							<h2><%=slide.getTitle()%></h2>
							<p><%=slide.getDescription()%></p>
							<a href="#"> <%=slide.getButtonText()%>
							</a>
						</div>
					</div>
					<%
					}
					%>
				</div>
				<button class="prev">❮</button>
				<button class="next">❯</button>
			</div>
		</div>




	</div>

</body>
</html>

<div class="card-container">
	<div class="card">
		<img src="img/tarjeta.png" alt="Tarjeta Socio Cineplanet"
			class="card-image">
	</div>
	<div class="info">
		<h1>
			Bienvenido<br>Sobrino CineCholis
		</h1>
		<p>
			¿Estás listo para vivir la más grande experiencia y disfrutar los
			mejores beneficios? <a href="#">CineCholis</a> es el programa que
			esperabas.
		</p>
		<div class="buttons">
			<a href="#" class="btn btn-red">Únete</a> <a href="#"
				class="btn btn-outline">Ver más</a>
		</div>
	</div>
</div>

<jsp:include page="/fragmentos/footer.jsp" />

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>