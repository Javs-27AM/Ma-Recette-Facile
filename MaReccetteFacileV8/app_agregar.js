// JSON BASE A MOSTRAR EN FORMULARIO
var baseJSON = {
  NombreReceta: "Receta",
  Imagen: "",
  TiempoPreparacion: 0, // Valor numérico para tiempo de preparación
  FechaActualizacion: 0,
  Categoria: 0,
  Ingredientes: [], // Array para los ingredientes
  Instrucciones: [], // Array para las instrucciones
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

        if (Object.keys(recetas).length > 0) {
          let template = "";

          recetas.forEach((receta) => {
            template += `
                            <div class="card-recipe" data-id="${receta.ID_Receta}" style="position: relative;">
                            <img src="${receta.Imagen}" alt="Imagen de ${receta.NombreReceta}" class="card-img">
                            <div class="card-body">
                                <h3 class="card-title">${receta.NombreReceta}</h3>
                                <p class="card-text">Tiempo de preparación: ${receta.TiempoPreparacion} minutos</p>
                                <p class="card-text">Categoría: ${receta.NombreCategoria}</p>
                                <button class="receta-edit btn btn-warning">Editar</button>
                                <button class="receta-delete btn btn-danger">Eliminar</button>

                                
                            </div>   
                        </div>

                        `;
          });

          $("#receta").html(template);
        }
      },
    });
  }

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
                            <div class="card-recipe" data-id="${receta.ID_Receta}" style="position: relative;">
                           <div class="card-body">
                                <h3 class="card-title">${receta.NombreReceta}</h3>
                                <p class="card-text">Tiempo de preparación: ${receta.TiempoPreparacion} minutos</p>
                                <p class="card-text">Categoría: ${receta.NombreCategoria}</p>
                                <button class="receta-edit btn btn-warning">Editar</button>
                                <button class="receta-delete btn btn-danger">Eliminar</button>

                                
                            </div>   
                        </div>
                        `;

                template_bar += `
                                    <li>${receta.NombreReceta}</li>
                                `;
              });

              $("#receta-result").show();
              $("#container").html(template_bar);
              $("#receta").html(template);
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
    console.log("ID de Usuario:", $("#usuarioId").val()); 
    

    let formData = new FormData();
    formData.append("id", $("#recetaId").val());
    formData.append("NombreReceta", $("#NombreReceta").val());
    formData.append("Imagen", $("#Imagen")[0].files[0]);
    formData.append("TiempoPreparacion", $("#TiempoPreparacion").val());
    formData.append("ID_Categoria", $("#Categoria").val());
    formData.append("ID_Usuario", $("#usuarioId").val()); // Agregar el ID del usuario
    console.log("ID de Receta:", $("#recetaId").val()); 
    // Obtener los ingredientes
    const ingredientes = [];
        $('#ingredientes-section .ingrediente-row input').each(function() {
            ingredientes.push({ ID_Ingrediente: $(this).val() });
        });
        formData.append('Ingredientes', JSON.stringify(ingredientes)); // Convertir a JSON
        
        console.log('Ingredientes:', ingredientes);// Log de los ingredientes

    // Obtener las instrucciones
    const instrucciones = [];
    $("#instrucciones-section .instruccion-row textarea").each(function () {
      instrucciones.push({ Instruccion: $(this).val() });
    });
    formData.append("Instrucciones", JSON.stringify(instrucciones)); // Convertir a JSON
    console.log("Instrucciones:", instrucciones);
    const url = edit === false ? "./backend/receta-add.php" : "./backend/receta-edit.php";

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      processData: false,
      contentType: false,
      success: (response) => {
        console.log(response);
        let respuesta = JSON.parse(response);
        let template_bar = "";
        template_bar += `
                    <li style="list-style: none;">status: ${respuesta.status}</li>
                    <li style="list-style: none;">message: ${respuesta.message}</li>
                `;
        // Limpiar el formulario
        $("#NombreReceta").val("");
        $("#Imagen").val("");
        $("#TiempoPreparacion").val("");
        $("#Categoria").val("0");
        $("#recetaId").val("");
        $("#usuarioId").val(""); // Limpiar el campo del ID del usuario
        // Reiniciar los ingredientes
        $("#ingredientes-section").empty(); // Eliminar todos los elementos de ingredientes
        // Reiniciar instrucciones
        $("#instrucciones-section").empty(); // Eliminar todos los elementos de instrucciones

        $("#receta-result").show();
        $("#container").html(template_bar);
        listarRecetas();
      },
    });
});


  $(document).on("click", ".receta-edit", function (e) {
    if (confirm("¿Realmente deseas editar la receta?")) {
      const element = $(this).closest(".card-recipe"); // Encuentra el elemento padre de la receta
      const recipeId = $(element).data("id"); // Obtiene el ID de la receta seleccionada
      $("#recetaId").val(recipeId);

      console.log("ID de la receta en campo oculto:", $("#recetaId").val()); // Verificación del ID

      $("#receta").hide(); // Oculta los mosaicos
      $(".col-md-5").show(); // Muestra el formulario
      $("#agregarRecetaBtn").text("Regresar");

      // Llamada AJAX para obtener los detalles de la receta para editar
      $.post("./backend/receta-single.php", { id: recipeId }, (response) => {
        console.log("Respuesta del servidor:", response);

        let receta;
        try {
          receta = JSON.parse(response); // Intenta parsear la respuesta JSON
          console.log("Receta parseada:", receta); // Log de la receta ya parseada
        } catch (error) {
          console.error("Error al parsear la respuesta JSON:", error); // Error de JSON
          return;
        }

        // Inserta los datos en los campos correspondientes
        $("#NombreReceta").val(receta.NombreReceta);
        $("#TiempoPreparacion").val(receta.TiempoPreparacion);
        //$("#recetaId").val(receta.ID_Receta);
        $("#Categoria").val(receta.ID_Categoria); // Configura el ID de la receta en un campo oculto

        // Verificar si hay una imagen asociada y mostrarla si existe
        if (receta.Imagen) {
          $("#ImagenPreview").attr("src", receta.Imagen).show();
        } else {
          $("#ImagenPreview").hide(); // Ocultar si no hay imagen
        }

        // Poblar ingredientes
        // Asegúrate de usar la clave correcta 'ingredientes' (con minúscula)
        $("#ingredientes-section").empty();
        if (receta.ingredientes && Array.isArray(receta.ingredientes)) {
          receta.ingredientes.forEach((ingrediente) => {
            // Ya no hay necesidad de una variable para cantidad
            $("#ingredientes-section").append(`
              <div class="ingrediente-row">
                  <input type="text" value="${ingrediente.Nombre}" placeholder="Ingrediente" class="form-control" required />
                  
              </div>
            `);
          });
        } else {
          console.warn("No hay ingredientes disponibles o no es un array.");
        }

        // Asegúrate de usar la clave correcta 'instrucciones' (con minúscula)
        $("#instrucciones-section").empty();
        if (receta.instrucciones && Array.isArray(receta.instrucciones)) {
          receta.instrucciones.forEach((instruccion) => {
            $("#instrucciones-section").append(`
            <div class="instruccion-row">
                <textarea class="form-control" placeholder="Instrucción" required>${instruccion.Descripcion}</textarea>
            </div>
        `);
          });
        } else {
          console.warn("No hay instrucciones disponibles o no es un array.");
        } 
        edit = true;
        $('button[type="submit"]').text('Editar Receta');
      });
    }
  });

  $(document).on("click", ".receta-delete", (e) => {
    if (confirm("¿Realmente deseas eliminar la receta?")) {
      const element = $(this)[0].activeElement.parentElement.parentElement;
      const id = $(element).attr("data-id");
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

    if (confirm("¿Realmente deseas editar la receta?")) {
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
        $("#Categoria").val(receta.ID_Categoria);

        // Configura el ID de la receta en un campo oculto para su uso posterior
        $("#recetaId").val(receta.ID_Receta);
        ///console.log('ID del receta guardado para actualización:', receta.ID_Receta); // Asegúrate de que este campo exista en tu HTML

        // Establece la bandera de edición en true
        edit = true;
        // console.log('Modo de edición activado:', edit);

        $('button[type="submit"]').text("Editar Receta");
      });
    }
  });

  document
    .getElementById("cancelarButton")
    .addEventListener("click", function () {
      // Aquí puedes añadir la lógica para cerrar el formulario o realizar otra acción
      $("#NombreReceta").val("");
      $("#Imagen").val("");
      $("#TiempoPreparacion").val("");
      $("#Categoria").val("0");
      $("#recetaId").val(""); // Reiniciar el select
      $("#ingredientes-section").val("");
      $("#instrucciones-section").val("");
      // O si estás usando un modal, podrías cerrarlo así:
      // $('#miModal').modal('hide');
    });

  $(document).ready(function () {
    // Evento para abrir la página agregar-receta.html cuando se haga clic en el botón "Agregar Receta"
    $("#addRecipeBtn").click(function () {
      window.location.href = "agregar-receta.html";
    });
  });

  // Agregar ingredientes
  document
    .getElementById("add-ingrediente-btn")
    .addEventListener("click", function () {
      const ingredientesSection = document.getElementById(
        "ingredientes-section"
      );
      const newIngredientRow = document.createElement("div");
      newIngredientRow.className = "form-group ingrediente-row";
      newIngredientRow.innerHTML =
        '<input class="form-control" type="text" name="Ingredientes[]" placeholder="Ingrediente" required>';
      ingredientesSection.appendChild(newIngredientRow);
    });

  // Agregar instrucciones
  document
    .getElementById("add-instruccion-btn")
    .addEventListener("click", function () {
      const instruccionesSection = document.getElementById(
        "instrucciones-section"
      );
      const newInstructionRow = document.createElement("div");
      newInstructionRow.className = "form-group instruccion-row";
      newInstructionRow.innerHTML =
        '<textarea class="form-control" name="Instrucciones[]" placeholder="Escriba la instrucción" required></textarea>';
      instruccionesSection.appendChild(newInstructionRow);
    });

    $("#agregarRecetaBtn").click(function () {
      if ($(this).text() === "Agregar Receta") {
        $("#receta").hide(); // Oculta los mosaicos de recetas
        $(".col-md-5").show(); // Muestra el contenedor del formulario
    
        // Obtener el ID del usuario y llenarlo en el campo oculto
        $.ajax({
          url: "./backend/getUser.php",
          method: "GET",
          dataType: "json",
          success: function (data) {
            console.log("Datos recibidos:", data); // Agrega esta línea para inspeccionar la respuesta
            if (data.idUsuario) {
              $("#usuarioId").val(data.idUsuario);
              console.log("ID del usuario llenado:", $("#usuarioId").val());
            } else {
              console.error("No se pudo obtener el ID del usuario.");
            }
          },
          error: function (jqXHR, textStatus, errorThrown) {
            console.error("Error al obtener el ID del usuario:", textStatus, errorThrown); // Detalle del error
          },
        });
    
        $(this).text("Regresar"); // Cambia el texto del botón a "Regresar"
      } else {
        $("#receta").show(); // Muestra los mosaicos de recetas
        $(".col-md-5").hide(); // Oculta el contenedor del formulario
        $(this).text("Agregar Receta"); // Cambia el texto del botón a "Agregar Receta"
      }
    });
    

  $(document).on("click", ".card-recipe", function () {
    const recipeId = $(this).data("id"); // Obtiene el ID de la receta seleccionada

    const target = $(event.target);
    if (
      target.closest(".receta-edit, .receta-delete, .fa-heart, .fa-share")
        .length
    ) {
      // Detiene la propagación si se hizo clic en los botones o iconos
      return;
    }

    // Llamada AJAX para obtener los detalles de la receta específica
    $.ajax({
      url: `./backend/receta-detalles.php?id=${recipeId}`,
      type: "GET",
      success: function (response) {
        console.log("Respuesta recibida del servidor:", response); // Verificar la respuesta del servidor

        let receta;
        try {
          receta = JSON.parse(response); // Intenta parsear la respuesta JSON
          console.log("Receta parseada:", receta); // Verificar el contenido parseado de la receta
        } catch (error) {
          console.error("Error al parsear la respuesta JSON:", error); // Error de JSON
          return;
        }

        // Generar el contenido del modal con la receta recibida
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
                            // Agrega la cantidad si está definida
                            const cantidad = ingrediente.Cantidad
                              ? ` - ${ingrediente.Cantidad}`
                              : "";
                            return `<li>${ingrediente.Nombre}${cantidad}</li>`;
                          })
                          .join("")}
                    </ul>
                    <h4>Instrucciones:</h4>
                    <ol>
                        ${receta.instrucciones
                          .map(
                            (instruccion, index) =>
                              `<li>Paso ${index + 1}: ${
                                instruccion.Descripcion
                              }</li>`
                          )
                          .join("")}
                    </ol>
                `;
        console.log("Contenido del modal generado:", modalContent); // Confirmar el HTML generado para el modal

        // Inserta el contenido en el modal y lo muestra
        $("#modalBody").html(modalContent);
        $("#recipeModal").css("display", "block"); // Muestra el modal
        console.log("Modal mostrado"); // Confirmación de visualización del modal
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error("Error en la llamada AJAX:", textStatus, errorThrown); // Error en la llamada AJAX
      },
    });
  });

  // Cerrar el modal al hacer clic en la "X" o fuera del modal
  $(".close").on("click", function () {
    $("#recipeModal").css("display", "none");
  });
  $(window).on("click", function (event) {
    if ($(event.target).is("#recipeModal")) {
      $("#recipeModal").css("display", "none");
    }
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

        $("#usuarioId").val(data.idUsuario);
        console.log("ID del usuario llenado:", $("#usuarioId").val());

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
