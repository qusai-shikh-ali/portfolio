const scrollBtn = document.getElementById("scrollTopBtn");

window.onscroll = function() {showBtn()};

function showBtn() {
    if( (document.body.scrollTop > 400 || document.documentElement.scrollTop > 400) ) {
        scrollBtn.style.display = "flex";
    } else {
        scrollBtn.style.display = "none";
    }
    //If User is 100px above Bottom hide ScrollBTN
    if (((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 100)){
        scrollBtn.style.display = "none";
    }
}

scrollBtn.addEventListener('click', () => {
    window.scrollTo({top:0, behavior: 'smooth'});
})

