const check1 = document.getElementById("check1");
const check2 = document.getElementById("check2");
const check3 = document.getElementById("check3");
const check4 = document.getElementById("check4");

const result1 = document.getElementById("resultq1");
const result2 = document.getElementById("resultq2");
const result3 = document.getElementById("resultq3");
const result4 = document.getElementById("resultq4");


const resulticon1 = document.getElementsByClassName("result-icon")[0];
const resulticon2 = document.getElementsByClassName("result-icon")[1];
const resulticon3 = document.getElementsByClassName("result-icon")[2];
const resulticon4 = document.getElementsByClassName("result-icon")[3];


check1.addEventListener("click", () => {
   if(result1.value == 7) {
      resulticon1.classList.add("correct-icon");
      resulticon1.classList.remove("uncorrect-icon");
      resulticon1.innerHTML = "&#x2714;";
   } else {
      resulticon1.classList.remove("correct-icon");
      resulticon1.classList.add("uncorrect-icon");
      resulticon1.innerHTML = "&#x2716;";
   }
});

check2.addEventListener("click", () => {
   if(result2.value == -7) {
   resulticon2.classList.add("correct-icon");
   resulticon2.classList.remove("uncorrect-icon");
   resulticon2.innerHTML = "&#x2714;";
   } else {
      resulticon2.classList.remove("correct-icon");
      resulticon2.classList.add("uncorrect-icon");
      resulticon2.innerHTML = "&#x2716;";
   }
});

check3.addEventListener("click", () => {
   if(result3.value == 4) {
   resulticon3.classList.add("correct-icon");
   resulticon3.classList.remove("uncorrect-icon");
   resulticon3.innerHTML = "&#x2714;";
   } else {
      resulticon3.classList.remove("correct-icon");
      resulticon3.classList.add("uncorrect-icon");
      resulticon3.innerHTML = "&#x2716;";
   }
});

check4.addEventListener("click", () => {
   if(result4.value == 5) {
   resulticon4.classList.add("correct-icon");
   resulticon4.classList.remove("uncorrect-icon");
   resulticon4.innerHTML = "&#x2714;";
   } else {
      resulticon4.classList.remove("correct-icon");
      resulticon4.classList.add("uncorrect-icon");
      resulticon4.innerHTML = "&#x2716;";
   }
});