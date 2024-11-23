<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AsientosDAOimpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Asiento" %>
<%
String cine = request.getParameter("cine");
    String horario = request.getParameter("horario");
    String fecha = request.getParameter("fecha");
    String pelicula = request.getParameter("pelicula");
    String imagen = request.getParameter("imagen");
    String salaIdStr = request.getParameter("sala"); // Obtener el ID de la sala
    
    

    // Guardar en la sesión
    session.setAttribute("cine", cine);
    session.setAttribute("horario", horario);
    session.setAttribute("fecha", fecha);
    session.setAttribute("pelicula", pelicula);
    session.setAttribute("imagen", imagen);
    session.setAttribute("sala", salaIdStr);
    
    
    int salaId = Integer.parseInt(salaIdStr); // Convertir el ID de la sala a entero

    // Obtener los asientos desde la base de datos
    AsientosDAOimpl metodos = new AsientosDAOimpl();
    ArrayList<Asiento> asientos = metodos.obtenerAsientosPorSala(salaId);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reserva de Butacas</title>
    <link rel="stylesheet" type="text/css" href="css/butacasframe.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        let selectedSeats = [];

        document.querySelectorAll(".seat.available").forEach(seat => {
            seat.addEventListener("click", function() {
                const seatNumber = this.getAttribute("data-seat-number");
                if (selectedSeats.includes(seatNumber)) {
                    this.classList.remove("selected");
                    selectedSeats = selectedSeats.filter(s => s !== seatNumber);
                } else {
                    this.classList.add("selected");
                    selectedSeats.push(seatNumber);
                }
                updateSelectedSeats(selectedSeats);
            });
        });

        function updateSelectedSeats(selectedSeats) {
            const selectedSeatsList = document.getElementById("selected-seats-list");
            selectedSeatsList.textContent = selectedSeats.length > 0 ? selectedSeats.join(", ") : "Ningún asiento seleccionado";
        }

        document.querySelector(".button-continue").addEventListener("click", function() {
            if (selectedSeats.length > 0) {
                const numAsientos = selectedSeats.length;
                
                Swal.fire({
                    title: 'Iniciar sesión',
                    text: 'Estimado usuario, debe loguearse primero para continuar.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Iniciar sesión',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        const numAsientos = selectedSeats.length; // Contar el número de asientos seleccionados
                        const asientosSeleccionados = selectedSeats.join(", "); // Crear la cadena de asientos seleccionados

                        // Mostrar la alerta con el número de asientos seleccionados y los asientos específicos
                        Swal.fire({
                            title: 'Asientos seleccionados',
                            text: 'Entradas seleccionadas: ' + numAsientos + ' - Butacas: ' + asientosSeleccionados,
                            icon: 'info',
                            confirmButtonText: 'Continuar'
                        }).then(() => {
                            window.location.href = 'loginusuario.jsp?asientos=' + encodeURIComponent(asientosSeleccionados) +
                                '&cine=' + encodeURIComponent('<%= cine %>') +
                                '&horario=' + encodeURIComponent('<%= horario %>') +
                                '&fecha=' + encodeURIComponent('<%= fecha %>') +
                                '&pelicula=' + encodeURIComponent('<%= pelicula %>') +
                                '&imagen=' + encodeURIComponent('<%= imagen %>') +
                                '&sala=' + encodeURIComponent('<%= salaId %>'); // Asegúrate de que salaId se incluye
                        });
                    }
                });

            } else {
                Swal.fire({
                    title: 'Error',
                    text: 'Por favor, selecciona al menos un asiento.',
                    icon: 'error',
                    confirmButtonText: 'Ok'
                });
            }
        });
    });
    </script>
</head>
<body>
    <jsp:include page="/fragmentos/encabezado_butacas.jsp" />
    <div class="main-content-butacas">
        <div class="left-panel-butacas">
            <img src="img/<%= session.getAttribute("imagen") %>" alt="Imagen de la Película" class="cine-image-butacas" />
            <h2><%= session.getAttribute("pelicula") %></h2>
            <p>2D, Regular, Doblada</p>
            <p><strong><%= session.getAttribute("cine") %></strong></p>
            <p>Fecha: <%= session.getAttribute("fecha") %></p>
            <p>Horario: <%= session.getAttribute("horario") %></p>
            <p>Sala: <%= salaId %></p> <!-- Asignar sala dinamicamente -->
        </div>
        <div class="right-panel-butacas">
            <div class="screen-label">Pantalla</div>
            <div class="seating-chart">
                <% 
                    char[] filas = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'};
                    int asientosPorFila = 15;

                    for (char fila : filas) {
                %>
                <div class="row">
                    <span class="row-label"><%= fila %></span>
                    <% for (int i = 1; i <= asientosPorFila; i++) {
                        boolean ocupado = false;
                        for (Asiento asiento : asientos) {
                            if (asiento.getFila().equals(String.valueOf(fila)) && asiento.getNumero() == i) {
                                ocupado = asiento.getEstado().equals("ocupada");
                                break;
                            }
                        }
                    %>
                        <span class="seat <%= ocupado ? "occupied" : "available" %>" 
                              data-seat-number="<%= fila %><%= i %>"></span>
                    <% } %>
                </div>
                <% } %>
            </div>
            <div class="seating-info">
                <span class="seat available"></span> Disponible
                <span class="seat occupied"></span> Ocupada
                <span class="seat selected"></span> Seleccionada
            </div>
            <div class="selected-seats">
                <p>Butacas seleccionadas: <span id="selected-seats-list">Ningún asiento seleccionado</span></p>
                <button class="button-continue">Continuar</button>
            </div>
        </div>
    </div>
    
</body>
</html>


