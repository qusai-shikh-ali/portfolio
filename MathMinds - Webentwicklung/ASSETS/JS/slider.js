const dots = document.querySelectorAll(".dot-container .dot");
const images = document.querySelectorAll(".slider .img");

let i = 0;
let j = 4;

function next(){
    document.getElementById("content" + (i+1)).classList.remove("activeSlider");
    i = ( j + i + 1) % j;
    document.getElementById("content" + (i+1)).classList.add("activeSlider");
    indicator( i+ 1 );
}
function prev(){
    document.getElementById("content" + (i+1)).classList.remove("activeSlider");
    i = ( j + i - 1) % j;
    document.getElementById("content" + (i+1)).classList.add("activeSlider");
    indicator( i + 1 );
}

function indicator(num) {
    dots.forEach(function(dot){
        dot.style.backgroundColor = "transparent";
    });
    document.querySelector(".dot-container .dot:nth-child(" + num + ")").style.backgroundColor = "#e68d1a";
}

function dot(index){
    images.forEach(function(image){
        image.classList.remove("activeSlider");
    });
    document.getElementById("content" + index).classList.add("activeSlider");
    i = index - 1;
    indicator(index);
}
