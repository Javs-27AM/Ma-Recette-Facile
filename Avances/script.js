// Manejadores de botones para cambiar entre formularios de login y registro
document.getElementById("btn-login").addEventListener("click", function () {
  document.getElementById("login-form-container").classList.remove("d-none");
  document.getElementById("register-form-container").classList.add("d-none");
});

document.getElementById("btn-register").addEventListener("click", function () {
  document.getElementById("register-form-container").classList.remove("d-none");
  document.getElementById("login-form-container").classList.add("d-none");
});

// Manejo del formulario de registro
document
  .getElementById("register-form")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    const nombreUsuario = document.getElementById(
      "nombreUsuarioRegister"
    ).value;
    const password = document.getElementById("passwordRegister").value;

    fetch("register.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ nombreUsuario, password }),
    })
      .then((response) => response.json())
      .then((data) => {
        alert(data.message);
        if (data.success) {
          document.getElementById("register-form").reset();
        }
      })
      .catch((error) => console.error("Error:", error));
  });

// Manejo del formulario de inicio de sesión
document.getElementById("login-form").addEventListener("submit", function (e) {
  e.preventDefault();
  const nombreUsuario = document.getElementById("nombreUsuario").value;
  const password = document.getElementById("password").value;

  fetch("login.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ nombreUsuario, password }),
  })
    .then((response) => response.json())
    .then((data) => {
      alert(data.message);
      if (data.success) {
        // Ocultar botones de invitado
        document.getElementById("guest-buttons").classList.add("d-none");

        // Mostrar información del usuario
        document.getElementById("user-info").classList.remove("d-none");
        document.getElementById("user-name").textContent = nombreUsuario;

        // Puedes redirigir al usuario o cargar otra página si es necesario
      }
    })
    .catch((error) => console.error("Error:", error));
});
