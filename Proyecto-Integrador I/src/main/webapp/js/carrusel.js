document.addEventListener('DOMContentLoaded', function() {
    const prevButton = document.querySelector('.prev');
    const nextButton = document.querySelector('.next');
    const carouselImages = document.querySelector('.carousel-images');
    
    let index = 0;

    function showSlide(i) {
        const slides = document.querySelectorAll('.carousel-images > div');
        if (i >= slides.length) {
            index = 0;
        } else if (i < 0) {
            index = slides.length - 1;
        } else {
            index = i;
        }
        carouselImages.style.transform = `translateX(-${index * 100}%)`;
    }

    nextButton.addEventListener('click', function() {
        showSlide(index + 1);
    });

    prevButton.addEventListener('click', function() {
        showSlide(index - 1);
    });

    //ESTO ES PARA EL CAMBIO AUTOMATICO
    setInterval(() => {
        showSlide(index + 1);
    }, 5000); // TIEMPO QUE SE VA CAMBIAR
});
