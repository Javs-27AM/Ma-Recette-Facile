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
  //listarRecetas();
  listarRecetasUser();

  function listarRecetasUser() {
    $.ajax({
      url: "./backend/receta-listUser.php", // Ruta al nuevo archivo PHP
      type: "GET",
      success: function (response) {
        console.log(response);
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
        } else {
          $("#receta").html("<p>No tienes recetas.</p>");
        }
      },
      error: function (error) {
        console.error("Error al obtener las recetas:", error);
      },
    });
  }

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

  function openModal(message, options = {}) {
    const modal = $("#generalModal");
    const modalMessage = $("#modalMessage");
    const confirmBtn = $("#modalConfirmBtn");
    const cancelBtn = $("#modalCancelBtn");
  
    // Configura el mensaje del modal
    modalMessage.text(message);
  
    // Mostrar/Ocultar los botones según las opciones
    if (options.hideButtons) {
      confirmBtn.hide();
      cancelBtn.hide();
    } else {
      confirmBtn.text(options.confirmText || "Aceptar").show();
      cancelBtn.text(options.cancelText || "Cancelar").show();
      confirmBtn.off("click").on("click", function () {
        modal.hide();
        if (options.onConfirm) options.onConfirm();
      });
      cancelBtn.off("click").on("click", function () {
        modal.hide();
        if (options.onCancel) options.onCancel();
      });
    }
  
    // Habilitar el botón de cerrar (X)
    $(".close-btn").off("click").on("click", function () {
      modal.hide();
      if (options.onClose) options.onClose(); // Callback opcional al cerrar con X
    });
  
    // Mostrar el modal
    modal.show();
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
    $("#ingredientes-section .ingrediente-row").each(function () {
      const nombreIngrediente = $(this).find("input").val(); // Obtener el nombre del ingrediente
      const idIngrediente = $(this).data("id"); // Obtener el ID del ingrediente, si existe

      // Verificar si el ingrediente tiene un ID (es decir, es un ingrediente editado)
      if (idIngrediente) {
        // Si existe el ID, agregamos el ID y el Nombre
        ingredientes.push({
          ID_Ingrediente: idIngrediente,
          Nombre: nombreIngrediente,
        });
      } else {
        // Si no existe el ID, es un ingrediente nuevo, solo se agrega el nombre
        ingredientes.push({ Nombre: nombreIngrediente });
      }
    });
    formData.append("Ingredientes", JSON.stringify(ingredientes)); // Convertir a JSON

    console.log("Ingredientes:", ingredientes); // Log de los ingredientes

    // Obtener las instrucciones
    const instrucciones = [];

    if (edit) {
      // Código para "EDIT TRUE"
      $("#instrucciones-section .instruccion-row").each(function () {
        const descripcionInstruccion = $(this).find("textarea").val(); // Obtener la descripción de la instrucción
        const idInstruccion = $(this).data("id"); // Obtener el ID de la instrucción, si existe

        // Verificar si la instrucción tiene un ID (es decir, es una instrucción editada)
        if (idInstruccion) {
          // Si existe el ID, agregamos el ID y la Descripción
          instrucciones.push({
            ID_Instruccion: idInstruccion,
            Descripcion: descripcionInstruccion,
          });
        } else {
          // Si no existe el ID, es una instrucción nueva, solo se agrega la descripción
          instrucciones.push({ Descripcion: descripcionInstruccion });
        }
      });
    } else {
      // Código para "EDIT FALSE"
      $("#instrucciones-section .instruccion-row textarea").each(function () {
        instrucciones.push({ Instruccion: $(this).val() });
      });
    }

    // Aquí puedes usar la variable `instrucciones` según sea necesario
    console.log(instrucciones);

    formData.append("Instrucciones", JSON.stringify(instrucciones)); // Convertir a JSON
    console.log("Instrucciones:", instrucciones);
    const url =
      edit === false ? "./backend/receta-add.php" : "./backend/receta-edit.php";

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      processData: false,
      contentType: false,
      success: (response) => {
        console.log(response);
        let respuesta = JSON.parse(response);

        openModal(respuesta.message, {
          hideButtons: false, // Mostrar los botones de Aceptar y Cancelar
          onConfirm: function () {
            // Al confirmar, recargar la página (si es necesario)
            window.location.reload();
          }
        });
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
        $("#ingredientes-section .ingrediente-row").each(function (index) {
          if (index > 0) {
            // Eliminar filas de ingredientes adicionales
            $(this).remove();
          } else {
            $(this).find("input").val("");
            $(this).css("margin-bottom", "10px"); // Vaciar el primer campo de ingrediente
          }
        });

        // Vaciar las instrucciones y dejar solo una
        $("#instrucciones-section .instruccion-row").each(function (index) {
          if (index > 0) {
            // Eliminar filas de instrucciones adicionales
            $(this).remove();
          } else {
            $(this).find("textarea").val(""); // Vaciar el primer campo de instrucción
            $(this).css("margin-bottom", "10px");
          }
        }); // Eliminar todos los elementos de instrucciones

        $("#receta-result").show();
        $("#container").html(template_bar);
        listarRecetasUser();
      },
    });
  });

  $(document).on("click", ".receta-edit", function (e) {
    e.preventDefault();

    // Confirmación de edición usando el modal
    openModal("¿Realmente deseas editar la receta?", {
        confirmText: "Sí, editar",
        cancelText: "Cancelar",
        onConfirm: function () {
            const element = $(e.target).closest(".card-recipe"); // Encuentra el elemento padre de la receta
            const recipeId = $(element).data("id"); // Obtiene el ID de la receta seleccionada
            $("#recetaId").val(recipeId);

            console.log("ID de la receta en campo oculto:", $("#recetaId").val()); // Verificación del ID

            $("#receta").hide(); // Oculta los mosaicos
            $(".col-md-5").show(); // Muestra el formulario
            $("#agregarRecetaBtn").text("Cancelar"); // Cambia el texto del botón a "Cancelar"

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
                $("#Categoria").val(receta.ID_Categoria); // Configura el ID de la receta en un campo oculto

                // Verificar si hay una imagen asociada y mostrarla si existe
                if (receta.Imagen) {
                    $("#ImagenPreview").attr("src", receta.Imagen).show();
                } else {
                    $("#ImagenPreview").hide(); // Ocultar si no hay imagen
                }

                // Poblar ingredientes
                console.log("Instrucciones:", receta.instrucciones);
                $("#ingredientes-section").empty();
                if (receta.ingredientes && Array.isArray(receta.ingredientes)) {
                    receta.ingredientes.forEach((ingrediente) => {
                        $("#ingredientes-section").append(`
                          <div class="ingrediente-row" data-id="${ingrediente.ID_Ingrediente}">
                              <input type="text" value="${ingrediente.Nombre}" placeholder="Ingrediente" class="form-control" required />
                          </div>
                        `);
                        $("#ingredientes-section .ingrediente-row").last().css("margin-bottom", "10px");
                    });
                } else {
                    console.warn("No hay ingredientes disponibles o no es un array.");
                }

                // Asegúrate de usar la clave correcta 'instrucciones' (con minúscula)
                $("#instrucciones-section").empty();
                if (receta.instrucciones && Array.isArray(receta.instrucciones)) {
                    receta.instrucciones.forEach((instruccion) => {
                        $("#instrucciones-section").append(`
                          <div class="instruccion-row" data-id="${instruccion.ID_Instruccion}">
                            <textarea class="form-control" placeholder="Instrucción" required>${instruccion.Descripcion}</textarea>
                          </div>
                        `);
                        $("#instrucciones-section .instruccion-row").last().css("margin-bottom", "10px");
                    });
                } else {
                    console.warn("No hay instrucciones disponibles o no es un array.");
                }

                edit = true;
                $('button[type="submit"]').text("Editar Receta");
            });
        },
        onCancel: function () {
            console.log("Edición cancelada por el usuario.");
        }
    });
});


  $(document).on("click", ".receta-delete", (e) => {
    e.preventDefault();

    // Confirmación de eliminación usando el modal
    openModal("¿Realmente deseas eliminar la receta?", {
        confirmText: "Sí, eliminar",
        cancelText: "Cancelar",
        onConfirm: function () {
            // Obtener el ID de la receta
            const element = $(e.target).closest(".card-recipe");  // Encontrar el contenedor más cercano con la clase 'card-recipe'
            const id = $(element).attr("data-id");

            console.log("Enviando solicitud de eliminación con ID:", id);

            // Enviar solicitud para eliminar la receta
            $.post("./backend/receta-delete.php", { id }, (response) => {
                console.log("Respuesta recibida del servidor:", response);

                try {
                    // Verificar si la respuesta ya es un objeto
                    let respuesta;
                    if (typeof response === 'string') {
                        respuesta = JSON.parse(response); // Si la respuesta es una cadena, la parseamos
                    } else {
                        respuesta = response; // Si es un objeto, lo usamos directamente
                    }

                    console.log("Respuesta parseada:", respuesta);

                    // Mostrar mensaje del servidor en el modal
                    openModal(`${respuesta.message}`, {
                        hideButtons: true, // No mostrar botones
                    });

                    // Actualizar la lista de recetas después de la eliminación
                    listarRecetasUser();
                } catch (e) {
                    // Si ocurre un error al parsear la respuesta
                    console.error("Error al parsear la respuesta JSON:", e);
                    openModal("Respuesta inválida del servidor.", {
                        hideButtons: true, // No mostrar botones
                    });
                }
            }).fail(function (jqXHR, textStatus, errorThrown) {
                // Mostrar mensaje de error en el modal si la solicitud falla
                console.error("Error al enviar la solicitud:", textStatus, errorThrown);
                openModal("Error al intentar eliminar la receta.", {
                    hideButtons: true, // No mostrar botones
                });
            });
        },
        onCancel: function () {
            // Mensaje cuando el usuario cancela la eliminación
            console.log("Eliminación cancelada por el usuario.");
        },
    });
});


  document.getElementById("cancelarButton").addEventListener("click", function () {
      // Limpiar el formulario
      edit = false;
      $("#NombreReceta").val("");
      $("#Imagen").val("");
      $("#TiempoPreparacion").val("");
      $("#Categoria").val("0"); // Limpiar el campo del ID del usuario
      // Reiniciar los ingredientes
      $("#ingredientes-section .ingrediente-row").each(function (index) {
        if (index > 0) {
          // Eliminar filas de ingredientes adicionales
          $(this).remove();
        } else {
          $(this).find("input").val("");
          $(this).css("margin-bottom", "10px"); // Vaciar el primer campo de ingrediente
        }
      });

      // Vaciar las instrucciones y dejar solo una
      $("#instrucciones-section .instruccion-row").each(function (index) {
        if (index > 0) {
          // Eliminar filas de instrucciones adicionales
          $(this).remove();
        } else {
          $(this).find("textarea").val(""); // Vaciar el primer campo de instrucción
          $(this).css("margin-bottom", "10px");
        }
      }); // Eliminar todos los elementos de instrucciones

      // Restaurar el estado del botón "Agregar Receta"
      let agregarRecetaBtn = $("#receta-form button[type='submit']");
      agregarRecetaBtn.prop("disabled", false); // Asegurarse de que esté habilitado
      agregarRecetaBtn.text("Agregar Receta"); // Restaurar el texto del botón
    });

  // Agregar ingredientes
  document.getElementById("add-ingrediente-btn").addEventListener("click", function () {
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
  document.getElementById("add-instruccion-btn").addEventListener("click", function () {
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
          console.error(
            "Error al obtener el ID del usuario:",
            textStatus,
            errorThrown
          ); // Detalle del error
        },
      });

      $(this).text("Regresar"); // Cambia el texto del botón a "Regresar"
      //$(this).hide(); // Oculta el botón "Agregar Receta"
    } else {
      //listarRecetasUser();
      $("#receta").show(); // Muestra los mosaicos de recetas
      $(".col-md-5").hide(); // Oculta el contenedor del formulario
      $("#cancelarButton").trigger("click");
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
        console.log("Instrucciones originales:", receta.instrucciones);
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
                    <ul>
                    
                    ${receta.instrucciones
                      .map((instruccion) => {
                        return `<li>Paso ${instruccion.NumeroPaso}: ${instruccion.Descripcion}</li>`;
                      })
                      .join("")}
                    
                    </ul>
                `;
        console.log("Instrucciones originales saliendo:", receta.instrucciones);
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

  $(document).on("click", "#openLogin", function () {
    window.location.href = "index.html";
  });

  $(document).on("click", "#openRegister", function () {
    window.location.href = "index.html";
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
                // Usamos el modal para mostrar mensaje de sesión cerrada
                openModal("Sesión cerrada exitosamente.", {
                    hideButtons: true, // No mostrar botones
                });

                // Cambiar el menú para reflejar que la sesión ha sido cerrada
                $("#userMenuItems").html(`
                    <button class="dropdown-item" id="loginButton">Iniciar Sesión</button>
                `);

                // Redirigir al index después de un breve retraso para que el usuario vea el mensaje
                setTimeout(function () {
                    window.location.href = "index.html";
                }, 2000); // 2 segundos de espera antes de redirigir
            }
        },
        error: function () {
            // Usamos el modal para mostrar error en la solicitud
            openModal("Error en la solicitud de cierre de sesión.", {
                hideButtons: true, // No mostrar botones
            });
        },
    });
});

});
