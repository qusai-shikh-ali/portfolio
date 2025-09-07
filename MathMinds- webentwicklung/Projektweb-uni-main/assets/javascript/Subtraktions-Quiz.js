document.addEventListener("DOMContentLoaded", function() {
    // Funktion zum Generieren einer zufälligen Subtraktionsaufgabe
    function generateSubtractionQuestion() {
        const num1 = Math.floor(Math.random() * 10) + 1; // Zahl zwischen 1 und 10
        const num2 = Math.floor(Math.random() * num1); // Zahl zwischen 0 und num1 (um negatives Ergebnis zu vermeiden)
        return { num1, num2, answer: num1 - num2 };
    }

    // Funktion zum Anzeigen mehrerer Subtraktionsaufgaben
    function displaySubtractionQuestions() {
        const quizContainer = document.getElementById("quizContainer");
        if (!quizContainer) {
            console.error("Quiz Container nicht gefunden!");
            return;
        }

        quizContainer.innerHTML = ""; // Vorherige Fragen entfernen

        for (let i = 0; i < 5; i++) { // 5 Aufgaben gleichzeitig anzeigen
            const question = generateSubtractionQuestion();

            // Erstelle ein neues Frage-Element
            const questionDiv = document.createElement("div");
            questionDiv.classList.add("question-item");

            const questionText = document.createElement("p");
            questionText.textContent = `${question.num1} - ${question.num2} = ?`;

            const inputField = document.createElement("input");
            inputField.type = "number";
            inputField.classList.add("userAnswer");
            inputField.dataset.correctAnswer = question.answer; // Speichere die richtige Antwort

            questionDiv.appendChild(questionText);
            questionDiv.appendChild(inputField);
            quizContainer.appendChild(questionDiv);
        }

        // Feedback leeren
        const feedback = document.getElementById("feedback");
        if (feedback) {
            feedback.textContent = "";
        }
    }

    // Funktion zum Überprüfen der Antworten
    function checkSubtractionAnswers() {
        const inputFields = document.querySelectorAll(".userAnswer");
        let correctCount = 0;

        inputFields.forEach((inputField) => {
            const userAnswer = parseInt(inputField.value, 10);
            const correctAnswer = parseInt(inputField.dataset.correctAnswer, 10);

            if (userAnswer === correctAnswer) {
                inputField.style.borderColor = "green"; // Richtig markiert
                correctCount++;
            } else {
                inputField.style.borderColor = "red"; // Falsch markiert
            }
        });

        // Feedback anzeigen
        const feedback = document.getElementById("feedback");
        if (feedback) {
            feedback.textContent = `Du hast ${correctCount} von ${inputFields.length} Aufgaben richtig beantwortet!`;
            feedback.style.color = correctCount === inputFields.length ? "green" : "red";
        }

        // Nächste Fragen anzeigen nach kurzer Zeit
        setTimeout(displaySubtractionQuestions, 4000);
    }

    // Initialisierung des Subtraktions-Quizzes
    const solveButton = document.getElementById("solveButton");
    if (solveButton) {
        solveButton.addEventListener("click", checkSubtractionAnswers);
    }

    // Zeige die ersten Subtraktionsfragen
    displaySubtractionQuestions();
});
