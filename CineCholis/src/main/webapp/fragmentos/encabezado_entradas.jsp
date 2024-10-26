<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="banner-dulceria" id="banner">
    <ul class="navdulc">
        <li><a href="javascript:goBack();" class="icon-link">
            <img src="img/iconatras.png" alt="Iniciar sesión" class="nav-icon" />
        </a></li>
        <li><a href="#">Entradas</a></li>
        <li><a href="javascript:confirmExit();" class="icon-link">
            <img src="img/salida.png" alt="Salir" class="nav-icon" />
        </a></li>
    </ul>
</div>

<div class="banner-dulceria-productos" id="banner">
    <ul class="nav">
        <li><span><img src="img/creditcard.png" alt="Icono 5" class="sub-icon" /></span></li>
    </ul>
</div>

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<script type="text/javascript">
    function goBack() {
        // Verifica si hay una página anterior en el historial
        if (document.referrer !== "") {
            // Redirige a la página anterior
            window.location.href = document.referrer;
        } else {
            // Si no hay referrer, redirige a una página por defecto
            window.location.href = 'index.jsp'; // Página predeterminada
        }
    }

    function confirmExit() {
        // Mostrar alerta interactiva antes de salir
        Swal.fire({
            title: '¿Estás seguro de que deseas salir?',
            text: "¡Te extrañaremos!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, salir',
            cancelButtonText: 'No, me quedo'
        }).then((result) => {
            if (result.isConfirmed) {
                // Si el usuario confirma, redirigir a cartelera.jsp
                window.location.href = 'cartelera.jsp';
            } else {
                // Si el usuario decide quedarse, no hacer nada
                Swal.fire(
                    '¡Genial!',
                    '¡Nos alegra que te quedes con nosotros!',
                    'success'
                );
            }
        });
    }
</script>