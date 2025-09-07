const menuIcon = document.querySelector(".hamburger");
const navMenu = document.querySelector(".nav-menu");
const navLink = document.querySelectorAll(".nav-link");

menuIcon.addEventListener("click", () => {
    menuIcon.classList.toggle("active");
    navMenu.classList.toggle("active");
})

navLink.forEach(i => i.addEventListener("click", () => {
    navMenu.classList.remove("active");
    menuIcon.classList.remove("active");
}))

