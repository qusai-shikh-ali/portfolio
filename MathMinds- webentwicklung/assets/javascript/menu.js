const menuIcon = document.querySelector(".hamburger"); /* Das Hamburger-Icon (Menü-Icon) auswählen */
// const menuIcon = document.querySelector("#hamburger"); 
// const menuIcon = document.querySelector("nav"); 
// const menuIcon = document.getElementById("hamburger"); 
// const menuIcon = document.getElementsByClassName("hamburger"); 
// const menuIcon = document.getElementsByName(".hamburger"); 
const navMenu = document.querySelector(".nav-menu"); 
const navLink = document.querySelectorAll(".nav-link"); 

menuIcon.addEventListener("click", () => {
    menuIcon.classList.toggle("active"); /* Toggle der "active"-Klasse für das Hamburger-Icon (Menü öffnen/schließen) */
    navMenu.classList.toggle("active"); 
})
// onclick
// navLink.forEach(i => i.addEventListener("click", () => {
//     navMenu.classList.remove("active"); /* Menü schließen */
//     menuIcon.classList.remove("active"); 
// }))
