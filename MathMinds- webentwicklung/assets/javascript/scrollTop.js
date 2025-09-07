const scrollBtn = document.getElementById("scrollTopBtn");

window.onscroll = function() {showBtn()}; /* Überwacht das Scrollen der Seite */

function showBtn() {
    /* Wenn der Benutzer mehr als 400px gescrollt hat, Button anzeigen */
    if( (document.body.scrollTop > 400 || document.documentElement.scrollTop > 400) ) {
        scrollBtn.style.display = "flex";
    } else {
        scrollBtn.style.display = "none";
    }
    
    /* Wenn der Benutzer 100px vor dem unteren Ende der Seite ist, Button ausblenden */
    if (((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 100)){
        scrollBtn.style.display = "none";
    }
}

/* Scrollen zum oberen Ende der Seite bei Klick auf den Button */
scrollBtn.addEventListener('click', () => {
    window.scrollTo({top:0, behavior: 'smooth'}); /* Weiches Scrollen zum oberen Rand */
})
