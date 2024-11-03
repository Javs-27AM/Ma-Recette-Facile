// JSON BASE A MOSTRAR EN FORMULARIO
var baseJSON = {
  NombreReceta: "Receta",
  Imagen: "",
  TiempoPreparacion: 0, // Valor numérico para tiempo de preparación
  FechaActualizacion: 0,
};

$(document).ready(function () {
  let edit = false;

  let JsonString = JSON.stringify(baseJSON, null, 2);
  $("#description").val(JsonString);
  $("#receta-result").hide();
  listarRecetas();

  function listarRecetas() {
    $.ajax({
      url: "./backend/receta-list.php", // Asegúrate de que esta ruta sea correcta
      type: "GET",
      success: function (response) {
        const recetas = JSON.parse(response);
        console.log(recetas);

        if (Object.keys(recetas).length > 0) {
          let template = "";

          recetas.forEach((receta) => {
            template += `
                            <div class="card-recipe" data-id="${receta.ID_Receta}">
                                <img src="${receta.Imagen}" alt="Imagen de ${receta.NombreReceta}" class="card-img">
                                <div class="card-body">
                                    <h3 class="card-title">${receta.NombreReceta}</h3>
                                    <p class="card-text">Tiempo de preparación: ${receta.TiempoPreparacion} minutos</p>
                                    <p class="card-text">Categoría: ${receta.NombreCategoria}</p>
                                </div>
                            </div>
                        `;
          });

          $("#receta").html(template);
        }
      },
    });
  }

  // Capturar clic en la tarjeta de receta
  $(document).on("click", ".card-recipe", function () {
    const recipeId = $(this).data("id");

    // Llamada AJAX para obtener los detalles de la receta específica
    $.ajax({
      url: `./backend/receta-detalles.php?id=${recipeId}`,
      type: "GET",
      success: function (response) {
        console.log("Respuesta recibida del servidor:", response); // Verificar la respuesta del servidor

        let receta;
        try {
          receta = JSON.parse(response);
          console.log("Receta parseada:", receta); // Verificar el contenido parseado de la receta
        } catch (error) {
          console.error("Error al parsear la respuesta JSON:", error); // Error de JSON
          return;
        }

        // Generar el contenido del modal
        const modalContent = `
                    <h2>${receta.NombreReceta}</h2>
                    <img src="${receta.Imagen}" alt="Imagen de ${
          receta.NombreReceta
        }" style=width:300px; height:168px; class="modal-img">
                    <p>Tiempo de preparación: ${
                      receta.TiempoPreparacion
                    } minutos</p>
                    <p>Categoría: ${receta.NombreCategoria}</p>
                    <h4>Ingredientes:</h4>
                    <ul>
                        ${receta.ingredientes
                          .map((ingrediente) => {
                            // Verificar si la cantidad está definida
                            const cantidad = ingrediente.Cantidad
                              ? ` - ${ingrediente.Cantidad}`
                              : "";
                            return `<li>${ingrediente.Nombre}${cantidad}</li>`;
                          })
                          .join("")}
                    </ul>
                    <h4>Instrucciones:</h4>
                    <ul>
                        ${receta.instrucciones
                          .map(
                            (instruccion) =>
                              `<li>Paso ${instruccion.Paso}: ${instruccion.Descripcion}</li>`
                          )
                          .join("")}
                    </ul>
                `;
        console.log("Contenido del modal generado:", modalContent); // Confirmar el HTML generado para el modal

        $("#modalBody").html(modalContent);

        // Mostrar el modal
        $("#recipeModal").css("display", "block");
        console.log("Modal mostrado"); // Confirmar que el modal se muestra
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error("Error en la llamada AJAX:", textStatus, errorThrown); // Error en la llamada AJAX
      },
    });
  });

  // Cerrar el modal al hacer clic en la "X"
  $(".close").on("click", function () {
    $("#recipeModal").css("display", "none");
  });
  $(window).on("click", function (event) {
    if ($(event.target).is("#recipeModal")) {
      $("#recipeModal").css("display", "none");
    }
  });

  $("#search").keyup(function () {
    if ($("#search").val()) {
      let search = $("#search").val();
      $.ajax({
        url: "./backend/receta-search.php?search=" + $("#search").val(),
        data: { search },
        type: "GET",
        success: function (response) {
          if (!response.error) {
            const recetas = JSON.parse(response);

            if (Object.keys(recetas).length > 0) {
              let template = "";
              let template_bar = "";

              recetas.forEach((receta) => {
                template += `
                                    <div class="card-recipe" data-id="${receta.ID_Receta}">
                                        <img src="${receta.Imagen}" alt="Imagen de ${receta.NombreReceta}" class="card-img">
                                        <div class="card-body">
                                            <h3 class="card-title">${receta.NombreReceta}</h3>
                                            <p class="card-text">Tiempo de preparación: ${receta.TiempoPreparacion} minutos</p>
                                            <p class="card-text">Categoría: ${receta.NombreCategoria}</p>
                                        </div>
                                    </div>
                        `;

                template_bar += `
                                    <li>${receta.NombreReceta}</li>
                                `;
              });

              $("#container").html(template_bar);
              $("#receta").html(template);
              $("#receta-result").show();
            }
          }
        },
      });
    } else {
      $("#receta-result").hide();
    }
  });

  $("#receta-form").submit((e) => {
    e.preventDefault();

    let formData = new FormData();
    formData.append("id", $("#recetaId").val());
    formData.append("NombreReceta", $("#NombreReceta").val());
    formData.append("Imagen", $("#Imagen")[0].files[0]);
    formData.append("TiempoPreparacion", $("#TiempoPreparacion").val());

    const url =
      edit === false ? "./backend/receta-add.php" : "./backend/receta-edit.php";

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      processData: false, // No procesar la data
      contentType: false, // No establecer el contentType
      success: (response) => {
        console.log(response);
        let respuesta = JSON.parse(response);
        let template_bar = "";
        template_bar += `
                    <li style="list-style: none;">status: ${respuesta.status}</li>
                    <li style="list-style: none;">message: ${respuesta.message}</li>
                `;
        $("#NombreReceta").val("");
        $("#Imagen").val("");
        $("#TiempoPreparacion").val("");
        $("#recetaId").val("");
        $("#receta-result").show();
        $("#container").html(template_bar);
        listarRecetas();
      },
    });
  });

  $(document).on("click", ".receta-edit", (e) => {
    if (confirm("¿Realmente deseas editar la receta?")) {
      const element = $(this)[0].activeElement.parentElement.parentElement; // Encuentra el elemento padre
      const id = $(element).attr("recetaId"); // Obtén el ID de la receta

      // Solicitar los detalles de la receta para editar
      $.post("./backend/receta-single.php", { id }, (response) => {
        console.log("Respuesta del servidor:", response);
        let receta = JSON.parse(response);
        console.log("Receta:", receta);

        // Inserta los datos en los campos correspondientes
        $("#NombreReceta").val(receta.NombreReceta);
        $("#TiempoPreparacion").val(receta.TiempoPreparacion);
        $("#recetaId").val(receta.ID_Receta); // Configura el ID de la receta en un campo oculto

        // Verificar si hay una imagen asociada y mostrarla si existe
        if (receta.Imagen) {
          $("#imagenPreview").attr("src", receta.Imagen); // Muestra la imagen en un elemento <img>
        }

        // Establece la bandera de edición en true
        edit = true;
        console.log("Modo de edición activado:", edit);

        // (Opcional) Mostrar el formulario de edición
        //$('#formulario-edicion').show(); // Asegúrate de que este ID sea correcto
      });
    }
  });

  $(document).on("click", ".receta-delete", (e) => {
    if (confirm("¿Realmente deseas eliminar la receta?")) {
      const element = $(this)[0].activeElement.parentElement.parentElement;
      const id = $(element).attr("recetaId");
      $.post("./backend/receta-delete.php", { id }, (response) => {
        console.log(response);
        let respuesta = JSON.parse(response);
        let template_bar = "";
        template_bar += `
                        <li style="list-style: none;">status: ${respuesta.status}</li>
                        <li style="list-style: none;">message: ${respuesta.message}</li>
                    `;
        $("#receta-result").show();
        $("#container").html(template_bar);
        listarRecetas();
      });
    }
  });

  $(document).on("click", ".receta-item", (e) => {
    e.preventDefault();

    const element = $(this)[0].activeElement.parentElement.parentElement; // Encuentra el elemento padre
    const id = $(element).attr("recetaId"); // Obtén el ID de la receta

    //console.log('ID del Receta:', id);

    $.post("./backend/receta-single.php", { id }, (response) => {
      //console.log('Respuesta del servidor:', response);
      // Convierte a objeto el JSON obtenido
      let receta = JSON.parse(response);
      //console.log('Receta:', receta);

      // Inserta los datos en los campos correspondientes
      $("#NombreReceta").val(receta.NombreReceta);
      $("#TiempoPreparacion").val(receta.TiempoPreparacion);

      // Configura el ID de la receta en un campo oculto para su uso posterior
      $("#recetaId").val(receta.ID_Receta);
      ///console.log('ID del receta guardado para actualización:', receta.ID_Receta); // Asegúrate de que este campo exista en tu HTML

      // Establece la bandera de edición en true
      edit = true;
      // console.log('Modo de edición activado:', edit);
    });
  });

  $(document).ready(function () {
    // Evento para abrir la página agregar-receta.html cuando se haga clic en el botón "Agregar Receta"
    $("#addRecipeBtn").click(function () {
      window.location.href = "agregar-receta.html";
    });
  });

  $("#filters-form").submit(function (e) {
    e.preventDefault(); // Evitar el envío normal del formulario

    let formData = $(this).serialize(); // Obtener datos del formulario
    console.log("Datos del formulario:", formData); // Mostrar datos del formulario en la consola

    $.ajax({
      url: "./backend/receta-filter.php", // Cambiar a la nueva ruta
      data: formData,
      type: "GET",
      success: function (response) {
        console.log("Respuesta del servidor:", response); // Mostrar respuesta en la consola
        const recetas = JSON.parse(response);

        if (Object.keys(recetas).length > 0) {
          let template = "";

          recetas.forEach((receta) => {
            template += `
                            <div class="card-recipe" data-id="${receta.ID_Receta}">
                                <img src="${receta.Imagen}" alt="Imagen de ${receta.NombreReceta}" class="card-img">
                                <div class="card-body">
                                    <h3 class="card-title">${receta.NombreReceta}</h3>
                                    <p class="card-text">Tiempo de preparación: ${receta.TiempoPreparacion} minutos</p>
                                    <p class="card-text">Categoría: ${receta.NombreCategoria}</p>
                                </div>
                            </div>
                        `;
          });

          $("#receta").html(template); // Actualizar la tabla de recetas filtradas
          $("#receta-result").show(); // Mostrar el resultado
        } else {
          $("#receta").html(
            "No se encontraron recetas que coincidan con los filtros."
          ); // Mensaje si no hay recetas
          $("#receta-result").show(); // Mostrar el resultado
        }
      },
      error: function (xhr, status, error) {
        console.error("Error en la solicitud:", status, error); // Manejo de errores
      },
    });
  });

  // Para manejar el evento del botón "Aplicar Filtros"
  $("#apply-filters").on("click", function () {
    $("#filters-form").submit(); // Disparar el evento de envío del formulario
  });

  $("#reset-filters").on("click", function () {
    $("#filters-form")[0].reset();
    listarRecetas();
  });
});

// usuarios
$(document).ready(function () {
  // Obtener el nombre de usuario al cargar la página
  $.ajax({
    url: "./backend/getUser.php",
    method: "GET",
    dataType: "json",
    success: function (data) {
      if (data.nombreUsuario) {
        $("#userMenuItems").append(
          `<span class="dropdown-item">${data.nombreUsuario}</span>`
        );
        $("#userMenuItems").append(
          '<button class="dropdown-item" id="logoutButton">Cerrar Sesión</button>'
        );
        $("#logoutButton").show();
      } else {
        $("#userMenuItems").append(
          '<a class="dropdown-item" href="#" id="openLogin">Iniciar Sesión</a>'
        );
        $("#userMenuItems").append(
          '<a class="dropdown-item" href="#" id="openRegister">Crear Cuenta</a>'
        );
      }
    },
    error: function () {
      console.error("Error al obtener el nombre de usuario");
    },
  });

  // Abrir modal de inicio de sesión al hacer clic en "Iniciar Sesión"
  $(document).on("click", "#openLogin", function () {
    $("#loginModal").show();
  });

  // Abrir modal de registro al hacer clic en "Crear Cuenta"
  $(document).on("click", "#openRegister", function () {
    $("#registerModal").show();
  });

  // Cerrar modal de inicio de sesión
  $(document).on("click", "#closeLogin", function () {
    $("#loginModal").hide();
  });

  // Cerrar modal de registro
  $(document).on("click", ".close", function () {
    $(this).closest(".modal").hide();
  });

  // Cerrar modal al hacer clic fuera de la ventana de contenido del modal
  $(window).click(function (event) {
    if (event.target.classList.contains("modal")) {
      $(event.target).hide();
    }
  });

  // Maneja el envío del formulario de Login
  $("#loginForm").submit(function (event) {
    event.preventDefault(); // Evita el envío normal del formulario

    const nombreUsuario = $("#loginUsername").val();
    const password = $("#loginPassword").val();

    $.ajax({
      url: "./backend/login.php",
      type: "POST",
      data: { nombreUsuario, password },
      dataType: "json",
      success: function (response) {
        if (response.success) {
          $("#userMenuItems").html(`
            <span class="dropdown-item">${response.message}</span>
            <button class="dropdown-item" id="logoutButton">Cerrar Sesión</button>
          `);
          $("#loginModal").hide(); // Cierra el modal de login al iniciar sesión exitosamente
        }
      },
      error: function (xhr, status, error) {
        console.log("Error:", error);
        alert("Error al iniciar sesión. Intenta nuevamente.");
      },
    });
  });

  // Maneja el envío del formulario de Registro
  $("#registerForm").submit(function (event) {
    event.preventDefault(); // Evita el envío normal del formulario

    $.ajax({
      url: "./backend/register.php",
      type: "POST",
      data: {
        nombreUsuario: $("#registerUsername").val(),
        password: $("#registerPassword").val(),
      },
      dataType: "json",
      success: function (response) {
        alert(response.message);
        if (response.success) {
          $("#registerModal").hide(); // Cierra el modal de registro si el registro es exitoso
        }
      },
      error: function (xhr, status, error) {
        console.log("Error:", error);
        alert("Error al registrarse. Intenta nuevamente.");
      },
    });
  });

  // Implementación del logout
  $(document).on("click", "#logoutButton", function (e) {
    e.preventDefault();
    $.ajax({
      url: "./backend/logout.php",
      method: "POST",
      success: function (data) {
        if (data) {
          location.reload(); // Recargar la página
        } /* else {
        //location.reload();
        //alert("session cerrada");
        //}*/
      },
      error: function () {
        alert("Error en la solicitud");
      },
    });
  });
});
