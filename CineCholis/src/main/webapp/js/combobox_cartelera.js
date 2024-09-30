function cargarPeliculas() {
    console.log("Cargar películas...");
    document.getElementById("filtroForm").submit();
}

document.addEventListener("DOMContentLoaded", function() {
    const cineSelect = document.getElementById("cineSeleccionado");
    const generoSelect = document.getElementById("generoSeleccionado");

    cineSelect.addEventListener("change", cargarPeliculas);
    generoSelect.addEventListener("change", cargarPeliculas);
});
