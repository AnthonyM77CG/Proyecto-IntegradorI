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


	<jsp:include page="/fragmentos/encabezado.jsp" />

	<div class="container">


		<div class="hero">
			<div class="carousel">
				<div class="carousel-images">
					<%
					for (Slide slide : slides) {
					%>
					<div class="carousel-slide">
						<img src="<%=slide.getImagePath()%>"
							alt="<%=slide.getTitle()%>" />
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


		<div class="content">


			<div class="section mision">
				<img src="img/mision.jpg" alt="Misión" class="section-img" />
				<div class="section-content">
					<h2>Misión</h2>
					<p><%=mision%></p>
				</div>
			</div>


			<div class="section vision">
				<div class="section-content">
					<h2>Visión</h2>
					<p><%=vision%></p>
				</div>
				<img src="img/vision.jpg" alt="Visión" class="section-img" />
			</div>


			<div class="section objetivos">
				<img src="img/objetivo.jpg" alt="Objetivos" class="section-img" />
				<div class="section-content">
					<h2>Objetivos</h2>
					<ul>
						<%
						for (String objetivo : objetivos) {
						%>
						<li><%=objetivo%></li>
						<%
						}
						%>
					</ul>
				</div>
			</div>


			<div class="section valores">
				<img src="img/valores.jpg" alt="Valores" class="section-img" />
				<div class="section-content">
					<h2>Valores</h2>
					<ul>
						<%
						for (String valor : valores) {
						%>
						<li><%=valor%></li>
						<%
						}
						%>
					</ul>
				</div>
			</div>

		</div>

	</div>

</body>
</html>