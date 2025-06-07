function validateEmail() {
  const email = document.getElementById("email").value;
  const pattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;

  if (!email.match(pattern)) {
    alert("Please enter a valid email address.");
    return false;
  }

  alert("Thank you! You'll be contacted soon.");
  return false; // prevent form submission for demo
}
