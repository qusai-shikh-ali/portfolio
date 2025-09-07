const dots = document.querySelectorAll(".dot-container .dot");
const images = document.querySelectorAll(".slider .img");

let i = 0;
const j = images.length; // Dynamisch die Anzahl der Bilder ermitteln

function next(){
    document.getElementById("content" + (i+1)).classList.remove("activeSlider");
    i = (i + 1) % j; // Index auf den nächsten Wert setzen (geht von 0 bis j-1)
    document.getElementById("content" + (i+1)).classList.add("activeSlider");
    indicator(i + 1);
}

function prev(){
    document.getElementById("content" + (i+1)).classList.remove("activeSlider");
    i = (i - 1 + j) % j; // Index zurücksetzen, aber sicherstellen, dass er nicht negativ wird
    document.getElementById("content" + (i+1)).classList.add("activeSlider");
    indicator(i + 1);
}

function indicator(num) {
    dots.forEach(function(dot){
        dot.style.backgroundColor = "transparent";
    });
    // Sicherstellen, dass der richtige Dot ausgewählt wird
    document.querySelector(".dot-container .dot:nth-child(" + num + ")").style.backgroundColor = "#e68d1a";
}

function dot(index){
    if (index < 1 || index > j) return; // Verhindert falsche Indizes
    images.forEach(function(image){
        image.classList.remove("activeSlider");
    });
    i = index - 1; // Index auf den richtigen Wert setzen (0-basiert)
    document.getElementById("content" + index).classList.add("activeSlider");
    indicator(index);
}
