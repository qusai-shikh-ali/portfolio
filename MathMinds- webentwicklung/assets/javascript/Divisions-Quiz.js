document.addEventListener("DOMContentLoaded", function() {
    /* Funktion zum Generieren einer zufälligen Divisionsaufgabe */
    function generateDivisionQuestion() {
        const num1 = Math.floor(Math.random() * 5) + 1; /* Zahl zwischen 1 und 5 */
        const num2 = Math.floor(Math.random() * 5) + 1; /* Zahl zwischen 1 und 5 */
        
        /* Sicherstellen, dass die Division auf eine ganze Zahl aufgeht (Rest 0) */
        const answer = num1 * num2; /* Multipliziere, damit die Antwort eine ganze Zahl ist */
        return { num1: answer, num2, answer: answer / num2 }; /* Division ergibt die Zahl */
    }

    /* Funktion zum Anzeigen mehrerer Divisionsaufgaben */
    function displayDivisionQuestions() {
        const quizContainer = document.getElementById("quizContainer");
        if (!quizContainer) {
            console.error("Quiz Container nicht gefunden!");
            return;
        }

        quizContainer.innerHTML = ""; /* Vorherige Fragen entfernen */

        for (let i = 0; i < 5; i++) { /* 5 Aufgaben gleichzeitig anzeigen */
            const question = generateDivisionQuestion();

            /* Erstelle ein neues Frage-Element */
            const questionDiv = document.createElement("div");
            questionDiv.classList.add("question-item");

            const questionText = document.createElement("p");
            questionText.textContent = `${question.num1} ÷ ${question.num2} = ?`;

            const inputField = document.createElement("input");
            inputField.type = "number";
            inputField.classList.add("userAnswer");
            inputField.dataset.correctAnswer = question.answer; /* Speichere die richtige Antwort */

            questionDiv.appendChild(questionText);
            questionDiv.appendChild(inputField);
            quizContainer.appendChild(questionDiv);
        }

        /* Feedback leeren */
        const feedback = document.getElementById("feedback");
        if (feedback) {
            feedback.textContent = "";
        }
    }

    /* Funktion zum Überprüfen der Antworten */
    function checkDivisionAnswers() {
        const inputFields = document.querySelectorAll(".userAnswer");
        let correctCount = 0;

        inputFields.forEach((inputField) => {
            const userAnswer = parseInt(inputField.value, 10);
            const correctAnswer = parseInt(inputField.dataset.correctAnswer, 10);

            if (userAnswer === correctAnswer) {
                inputField.style.borderColor = "green"; /* Richtig markiert */
                correctCount++;
            } else {
                inputField.style.borderColor = "red"; /* Falsch markiert */
            }
        });

        /* Feedback anzeigen */
        const feedback = document.getElementById("feedback");
        if (feedback) {
            feedback.textContent = `Du hast ${correctCount} von ${inputFields.length} Aufgaben richtig beantwortet!`;
            feedback.style.color = correctCount === inputFields.length ? "green" : "red";
        }

        /* Nächste Fragen anzeigen nach kurzer Zeit */
        setTimeout(displayDivisionQuestions, 6000);
    }

    /* Initialisierung des Divisions-Quizzes */
    const solveButton = document.getElementById("solveButton");
    if (solveButton) {
        solveButton.addEventListener("click", checkDivisionAnswers);
    }

    /* Zeige die ersten Divisionsfragen */
    displayDivisionQuestions();
});
