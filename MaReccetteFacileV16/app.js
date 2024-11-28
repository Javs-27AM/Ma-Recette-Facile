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
  setTimeout(cargarFavoritos, 500); 
  setTimeout(cargarPuntuacion, 500); 

  function listarRecetas() {
    $.ajax({
      url: "./backend/receta-list.php", // Asegúrate de que esta ruta sea correcta
      type: "GET",
      success: function (response) {
        const recetas = JSON.parse(response);
        //console.log(recetas);

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
                                
                                <!-- Contenedor de los íconos -->
                                <div class="icons-container" style="position: absolute; bottom: 15px; right: 15px;">
                                    <i class="far fa-heart favorito-icon" title="Favorito" style="cursor: pointer; color: #ff6b6b; font-size: 1.5em;" data-id="${receta.ID_Receta}"></i>
                                    <i class="fas fa-share" title="Compartir" style="cursor: pointer; color: #6c757d; font-size: 1.5em; margin-left: 10px;"></i>
                                </div>

                                <!-- Contenedor exclusivo para las estrellas -->
                                <div class="stars-container" style="margin-top: 15px;">
                                    <div class="rating-stars" data-id="${receta.ID_Receta}">
                                        <i class="far fa-star star-icon" data-rating="1" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="2" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="3" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="4" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="5" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                    </div>
                                </div>

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
      cancelBtn.text(options.cancelText || "Cancelar").hide();
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
  
  
  
  // Cerrar modal al hacer clic fuera del contenido
  $(window).on("click", function (e) {
    const modal = $("#generalModal");
    if ($(e.target).is(modal)) {
      modal.hide();
    }
  });
  

  // Capturar clic en la tarjeta de receta
  $(document).on("click", ".card-recipe", function () {
    const recipeId = $(this).data("id");

    const target = $(event.target);
    if (target.closest(".fa-heart, .fa-share, .fa-star").length) {
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
          receta = JSON.parse(response);
          console.log("Receta parseada:", receta); // Verificar el contenido parseado de la receta
        } catch (error) {
          console.error("Error al parsear la respuesta JSON:", error); // Error de JSON
          return;
        }

        // Generar el contenido del modal
        const modalContent = `
                    <h2>${receta.NombreReceta}</h2>
                    <img src="${receta.Imagen}" alt="Imagen de ${receta.NombreReceta}" style="width:300px; height:168px;" class="modal-img">
                    <p>Tiempo de preparación: ${receta.TiempoPreparacion} minutos</p>
                    <p>Categoría: ${receta.NombreCategoria}</p>
                    <p><strong>Puntuación promedio:</strong> ${receta.PromedioPuntuacion} / 5</p>
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
                      .map((instruccion) => {
                        return `<li>Paso ${instruccion.NumeroPaso}: ${instruccion.Descripcion}</li>`;
                      })
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


  $("#addRecipeBtn").click(function () {
    $.ajax({
      url: "./backend/getUser.php",
      method: "GET",
      dataType: "json",
      success: function (data) {
        if (data.nombreUsuario) {
          // Si el usuario está logueado, redirige a agregar-receta.html
          window.location.href = "agregar-receta.html";
        } else {
          // Mostrar el modal general para iniciar sesión
          openModal("Debes iniciar sesión para ver tus recetas.", {
            confirmText: "Iniciar sesión",
            cancelText: "Cancelar",
            onConfirm: function () {
              $("#loginModal").show();
            },
          });
        }
      },
      error: function () {
        console.error("Error al verificar el estado de inicio de sesión");
      },
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
                                
                                <!-- Contenedor de los íconos -->
                                <div class="icons-container" style="position: absolute; bottom: 15px; right: 15px;">
                                    <i class="far fa-heart favorito-icon" title="Favorito" style="cursor: pointer; color: #ff6b6b; font-size: 1.5em;" data-id="${receta.ID_Receta}"></i>
                                    <i class="fas fa-share" title="Compartir" style="cursor: pointer; color: #6c757d; font-size: 1.5em; margin-left: 10px;"></i>
                                </div>

                                <!-- Contenedor exclusivo para las estrellas -->
                                <div class="stars-container" style="margin-top: 15px;">
                                    <div class="rating-stars" data-id="${receta.ID_Receta}">
                                        <i class="far fa-star star-icon" data-rating="1" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="2" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="3" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="4" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                        <i class="far fa-star star-icon" data-rating="5" data-id="${receta.ID_Receta}" style="cursor: pointer; color: #f7d64b; font-size: 1.5em;"></i>
                                    </div>
                                </div>

                            </div>
                        </div>
                        `;
          });

          $("#receta").html(template); // Actualizar la tabla de recetas filtradas
          $("#receta-result").show(); 
          cargarFavoritos();
          cargarPuntuacion();  // Mostrar el resultado
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
    $("#receta-result").show(); 
    listarRecetas();
    cargarFavoritos();
    cargarPuntuacion(); 
  });

  function cargarFavoritos() {
    console.log("Iniciando la carga de favoritos...");

    $.ajax({
        url: "./backend/getFavoritos.php", // URL del archivo PHP para obtener los favoritos
        method: "GET",
        dataType: "json",
        success: function (data) {
            console.log("Respuesta de la API:", data); // Muestra los datos recibidos de la API

            if (data.success) {
                console.log("Favoritos obtenidos con éxito:", data.favoritos); // Muestra los IDs de las recetas favoritas

                // Marcar las recetas como favoritas (activo)
                data.favoritos.forEach(function (recetaId) {
                    console.log("Marcando como favorito la receta con ID:", recetaId); // Muestra el ID de la receta que se va a marcar

                    // Encuentra el ícono de favorito correspondiente y marca como activo
                    const $icono = $(`.favorito-icon[data-id="${recetaId}"]`);
                    console.log("Icono encontrado:", $icono); // Verifica si se encuentra el ícono

                    if ($icono.length) {
                      // Asegura que el ícono solo tenga la clase 'fas' para el estado marcado
                      $icono.removeClass("far").addClass("fas"); // Forzar el estado de favorito
                      console.log("Ícono forzado como favorito:", $icono); // Confirmar cambio de clase
                  } else {
                      console.warn(`No se encontró el ícono para la receta ID: ${recetaId}`);
                  }
                  
                });
            } else {
                console.error("Error al cargar los favoritos:", data.message); // Muestra el mensaje de error si la carga falla
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener los favoritos:", status, error); // Muestra el error en caso de falla en la solicitud AJAX
            openModal("Error al cargar los favoritos.", { hideButtons: true });
        }
    });
}

  function cargarPuntuacion() {
    console.log("Iniciando la carga de puntuación...");

    // Realiza una llamada AJAX para obtener las puntuaciones de las recetas del usuario logueado
    $.ajax({
        url: "./backend/getPuntuacion.php", // URL del archivo PHP para obtener las puntuaciones
        method: "GET",
        dataType: "json",
        success: function (data) {
            console.log("Respuesta de la API:", data); // Muestra los datos recibidos de la API

            if (data.success) {
                console.log("Puntuaciones obtenidas con éxito:", data.puntuaciones); // Muestra las puntuaciones de las recetas

                // Actualiza las estrellas de las recetas con las puntuaciones correspondientes
                data.puntuaciones.forEach(function (receta) {
                    const recetaId = receta.ID_Receta;
                    const puntuacion = receta.Puntuacion;  // Puntuación específica del usuario

                    console.log(`Actualizando la puntuación de la receta con ID: ${recetaId}, puntuación: ${puntuacion}`);

                    // Encuentra las estrellas correspondientes y las marca según la puntuación
                    const $estrellas = $(`.star-icon[data-id="${recetaId}"]`);
                    console.log("Iconos de estrellas encontrados:", $estrellas); // Verifica si se encuentran los iconos de estrellas

                    if ($estrellas.length) {
                        // Eliminar todas las clases de estrellas activas
                        $estrellas.removeClass("fas").addClass("far");

                        // Agregar las clases correspondientes según la puntuación
                        for (let i = 0; i < Math.floor(puntuacion); i++) {
                            $($estrellas[i]).removeClass("far").addClass("fas"); // Marca las estrellas completas
                        }
                        if (puntuacion % 1 !== 0) {
                            // Si hay una fracción, agregamos la estrella media
                            $($estrellas[Math.floor(puntuacion)]).removeClass("far").addClass("fas").addClass("half");
                        }
                        console.log(`Puntuación de la receta ${recetaId} actualizada a: ${puntuacion}`);
                    } else {
                        console.warn(`No se encontraron los iconos de estrellas para la receta ID: ${recetaId}`);
                    }
                });
            } else {
                console.error("Error al cargar la puntuación:", data.message); // Muestra el mensaje de error si la carga falla
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al obtener la puntuación:", status, error); // Muestra el error en caso de falla en la solicitud AJAX
            openModal("Error al cargar la puntuación de recetas.", { hideButtons: true });
        }
    });
  }





  
//USUARIOS
  
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
    event.preventDefault();
  
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
  
          $("#loginModal").hide();
  
          // Mostrar el modal sin botones
          openModal("Sesión iniciada correctamente.", { hideButtons: true });
          listarRecetas();
          setTimeout(cargarFavoritos, 500); 
          setTimeout(cargarPuntuacion, 500); 
        } else {
          // Mostrar el modal sin botones
          openModal("Contraseña o Usuario incorrecto.", { hideButtons: true });
        }
      },
      error: function () {
        console.error("Error al iniciar sesión.");
        openModal("Error al iniciar sesión. Intenta nuevamente.", { hideButtons: true });
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
        // Usar el modal general en lugar de alertas
        openModal(response.message, {
          hideButtons: true, // No mostrar botones en este caso
        });
  
        if (response.success) {
          $("#registerModal").hide(); // Cierra el modal de registro si el registro es exitoso
  
          // Cerrar automáticamente el modal después de 3 segundos
          setTimeout(() => {
            $("#generalModal").hide();
          }, 3000);
        }
      },
      error: function (xhr, status, error) {
        console.log("Error:", error);
  
        // Usar el modal general para errores del servidor
        openModal("Error al registrarse. Intenta nuevamente.", {
          hideButtons: true, // No mostrar botones en este caso
        });
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
            <span class="dropdown-item">Iniciar sesión</span>
            <button class="dropdown-item" id="loginButton">Iniciar Sesión</button>
          `);
          
          // Recargar la página inmediatamente
          location.reload();
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
  
  

  $(document).on("click", ".favorito-icon", function () {
    const recetaId = $(this).closest(".card-recipe").data("id"); // Obtiene el ID de la receta
    const $icono = $(this);
    console.log("ID de la receta:", recetaId); // Verifica el ID de la receta
  
    // Verificar el estado de inicio de sesión
    $.ajax({
      url: "./backend/getUser.php",
      method: "GET",
      dataType: "json",
      success: function (data) {
        console.log("Datos de usuario:", data); // Muestra los datos devueltos por la verificación de usuario
  
        if (data.nombreUsuario) {
          // Usuario está logueado, proceder a agregar o eliminar favorito
          $.ajax({
            url: "./backend/usuario-favorito.php", // Este es el archivo que se invoca
            method: "POST",
            data: {
              recetaId: recetaId,
            },
            dataType: "json",
            success: function (data) {
              console.log("Respuesta de agregar/eliminar favorito:", data); // Muestra la respuesta de la acción de favorito
  
              if (data.success) {
                // Cambiar el icono según el estado del favorito
                if (data.action === "added") {
                  $icono.removeClass("far").addClass("fas"); // Cambia a icono de favorito
                  
                  console.log("Receta añadida a favoritos.");
                } else {
                  $icono.removeClass("fas").addClass("far"); // Cambia a icono no favorito
                  
                  console.log("Receta eliminada de favoritos.");
                }
              } else {
                
                console.error("Error en la respuesta:", data.message); // Mensaje de error
              }
            },
            error: function (xhr, status, error) {
              console.error("Error en la petición AJAX:", status, error); // Mensaje de error de la petición
              openModal("Error al procesar la solicitud de favorito.", {
                hideButtons: true, // No mostrar botones
              });
            },
          });
        } else {
          // Si el usuario no está logueado, abre el modal de inicio de sesión
          console.log("Usuario no autenticado."); // Mensaje para usuario no autenticado
          openModal("Debes iniciar sesión para marcar esta receta como favorita. ¿Quieres iniciar sesión ahora?", {
            hideButtons: false, // Mostrar el botón para cerrar o iniciar sesión
            confirmText: "Iniciar sesión",
            onConfirm: function () {
              $("#loginModal").show();
            },
          });
        }
      },
      error: function (xhr, status, error) {
        console.error(
          "Error al verificar el estado de inicio de sesión:",
          status,
          error
        ); // Mensaje de error de la petición
        openModal("Error al verificar el estado de sesión.", {
          hideButtons: true, // No mostrar botones
        });
      },
    });
  });

  $(document).on("mouseenter", ".star-icon", function () {
    const $stars = $(this).closest(".rating-stars").find(".star-icon");
    const hoveredRating = $(this).data("rating");

    // Iluminar las estrellas hasta la puntuación seleccionada
    $stars.each(function () {
        $(this).toggleClass("fas", $(this).data("rating") <= hoveredRating); // Estrella llena
        $(this).toggleClass("far", $(this).data("rating") > hoveredRating); // Estrella vacía
    });
});

$(document).on("mouseleave", ".rating-stars", function () {
  const recetaId = $(this).data("id");
  cargarPuntuacion(recetaId); // Llamamos a cargarPuntuacion para restaurar la puntuación almacenada
});

$(document).on("click", ".star-icon", function () {
    const recetaId = $(this).closest(".rating-stars").data("id"); // ID de la receta
    const rating = $(this).data("rating"); // Puntuación seleccionada
    const $starsContainer = $(this).closest(".rating-stars"); // Contenedor de estrellas

    console.log("ID de la receta:", recetaId, "Puntuación seleccionada:", rating);

    // Verificar si el usuario está logueado
    $.ajax({
        url: "./backend/getUser.php",
        method: "GET",
        dataType: "json",
        success: function (data) {
            console.log("Datos de usuario:", data);

            if (data.nombreUsuario) {
                // Usuario está logueado, proceder a guardar la puntuación
                $.ajax({
                    url: "./backend/usuario-puntuacion.php",
                    method: "POST",
                    data: {
                        recetaId: recetaId,
                        rating: rating,
                    },
                    dataType: "json",
                    success: function (data) {
                        console.log("Respuesta al guardar puntuación:", data);

                        if (data.success) {
                            // Guardar la puntuación actual en el contenedor
                            $starsContainer.data("current-rating", rating);

                            // Actualizar visualmente las estrellas según la puntuación seleccionada
                            $starsContainer.find(".star-icon").each(function () {
                                $(this).toggleClass("fas", $(this).data("rating") <= rating); // Llena la estrella
                                $(this).toggleClass("far", $(this).data("rating") > rating); // Vacía la estrella
                            });
                            console.log("Puntuación guardada con éxito:", rating);
                        } else {
                            console.error("Error al guardar la puntuación:", data.message);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Error en la petición AJAX:", status, error);
                        openModal("Error al procesar la solicitud de puntuación.", {
                            hideButtons: true,
                        });
                    },
                });
            } else {
                // Si el usuario no está autenticado, mostrar modal para iniciar sesión
                console.log("Usuario no autenticado.");
                openModal("Debes iniciar sesión para puntuar esta receta. ¿Quieres iniciar sesión ahora?", {
                    hideButtons: false,
                    confirmText: "Iniciar sesión",
                    onConfirm: function () {
                        $("#loginModal").show();
                    },
                });
            }
        },
        error: function (xhr, status, error) {
            console.error("Error al verificar el estado de inicio de sesión:", status, error);
            openModal("Error al verificar el estado de sesión.", {
                hideButtons: true,
            });
        },
    });
});

  const feedbackModal = document.getElementById('feedbackModal');
  const openFeedbackButton = document.getElementById('openFeedback');
  const closeFeedbackButton = document.getElementById('closeFeedbackModal');
  const cancelFeedbackButton = document.getElementById('cancelFeedback');

  // Abrir el modal
  openFeedbackButton.addEventListener('click', () => {
    feedbackModal.style.display = 'block';
  });

  // Cerrar el modal (botón cerrar o cancelar)
  closeFeedbackButton.addEventListener('click', () => {
    feedbackModal.style.display = 'none';
  });

  cancelFeedbackButton.addEventListener('click', () => {
    feedbackModal.style.display = 'none';
  });

  // Cerrar al hacer clic fuera del modal
  window.addEventListener('click', (event) => {
    if (event.target === feedbackModal) {
      feedbackModal.style.display = 'none';
    }
  });

  document.getElementById('feedbackForm').addEventListener('submit', function (e) {
    e.preventDefault(); // Evitar la recarga de la página
    console.log('Formulario enviado. Procesando...');

    const formData = new FormData(this);

    // Mostrar datos del formulario en consola
    for (let [key, value] of formData.entries()) {
        console.log(`Campo: ${key}, Valor: ${value}`);
    }

    fetch('sendFeedback.php', {
      method: 'POST',
      body: formData,
    })
      .then((response) => {
        console.log('Respuesta del servidor (texto crudo):', response);
        return response.text(); // Procesar como texto para inspeccionar
      })
      .then((text) => {
        console.log('Texto crudo de la respuesta:', text);
        try {
          const data = JSON.parse(text); // Intentar convertir a JSON
          console.log('Datos procesados:', data);
          if (data.success) {
            openModal(data.message, { hideButtons: true });
            
            document.getElementById('feedbackForm').reset(); // Limpiar formulario
            document.getElementById('feedbackModal').style.display = 'none'; // Cerrar modal
          } else {
            openModal(data.message, { hideButtons: true });
            
          }
        } catch (error) {
          console.error('Error al convertir respuesta a JSON:', error);
        }
      })
      .catch((error) => {
        console.error('Error en la solicitud fetch:', error);
      });
    
});






  

});
