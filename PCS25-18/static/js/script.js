document.getElementById("vqa-form").addEventListener("submit", function (e) {
  e.preventDefault();
  const form = e.target;
  const question = form.question.value;

  fetch("/ask", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: `question=${encodeURIComponent(question)}`,
  })
    .then((res) => res.json())
    .then((data) => {
      document.getElementById("answer").innerText = "Answer: " + data.answer;
    });
});
