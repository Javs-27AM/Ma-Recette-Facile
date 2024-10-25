// JSON BASE A MOSTRAR EN FORMULARIO
var baseJSON = {
    "NombreReceta": "Receta",
    "Imagen": "",
    "TiempoPreparacion": 0,  // Valor numérico para tiempo de preparación
    "FechaActualizacion" :0,
    "Categoria" : 0,
    "Ingredientes": [],        // Array para los ingredientes
    "Instrucciones": []        // Array para las instrucciones
};

$(document).ready(function(){
    let edit = false;

    let JsonString = JSON.stringify(baseJSON, null, 2);
    $('#description').val(JsonString);
    $('#receta-result').hide();
    listarRecetas();

    function listarRecetas() {
        $.ajax({
            url: './backend/receta-list.php',  // Asegúrate de que esta ruta sea correcta
            type: 'GET',
            success: function(response) {
                const recetas = JSON.parse(response);
    
                if (Object.keys(recetas).length > 0) {
                    let template = '';
    
                    recetas.forEach(receta => {
                        let descripcion = '';
                        descripcion += '<li>Nombre: ' + receta.NombreReceta + '</li>';
                        descripcion += '<li>Imagen: <img src="' + receta.Imagen + '" alt="Imagen de ' + receta.NombreReceta + '" /></li>';
                        descripcion += '<li>Tiempo de Preparación: ' + receta.TiempoPreparacion + ' minutos</li>';
                        descripcion += '<li>Categoria: ' + receta.NombreCategoria + '</li>';
    
                        template += `
                            <tr recetaId="${receta.ID_Receta}">
                                <td>${receta.ID_Receta}</td>
                                <td><a href="#" class="receta-item">${receta.NombreReceta}</a></td>
                                <td><ul>${descripcion}</ul></td>
                                <td>
                                    <button class="receta-edit btn btn-warning">Editar</button>
                                </td>
                                <td>
                                    <button class="receta-delete btn btn-danger">Eliminar</button>
                                </td>
                            </tr>
                        `;
                    });
    
                    $('#receta').html(template);
                }
            }
        });
    }
    

    $('#search').keyup(function() {
        if($('#search').val()) {
            let search = $('#search').val();
            $.ajax({
                url: './backend/receta-search.php?search='+$('#search').val(),
                data: {search},
                type: 'GET',
                success: function (response) {
                    if(!response.error) {
                        const recetas = JSON.parse(response);

                        if (Object.keys(recetas).length > 0) {
                            let template = '';
                            let template_bar = '';

                            recetas.forEach(receta => {
                                let descripcion = '';
                        descripcion += '<li>Nombre: ' + receta.NombreReceta + '</li>';
                        descripcion += '<li>Imagen: <img src="' + receta.Imagen + '" alt="Imagen de ' + receta.NombreReceta + '" /></li>';
                        descripcion += '<li>Tiempo de Preparación: ' + receta.TiempoPreparacion + ' minutos</li>';
                        descripcion += '<li>Categoria: ' + receta.NombreCategoria  + '</li>';

                        template += `
                            <tr recetaId="${receta.ID_Receta}">
                               <td>${receta.ID_Receta}</td>
                                <td><a href="#" class="receta-item">${receta.NombreReceta}</a></td>
                                <td><ul>${descripcion}</ul></td>
                                <td>
                                    <button class="receta-edit btn btn-warning">Editar</button>
                                </td>
                                <td>
                                    <button class="receta-delete btn btn-danger">Eliminar</button>
                                </td>
                            </tr>
                        `;

                                template_bar += `
                                    <li>${receta.NombreReceta}</li>
                                `;
                            });

                            $('#receta-result').show();
                            $('#container').html(template_bar);
                            $('#receta').html(template);    
                        }
                    }
                }
            });
        }
        else {
            $('#receta-result').hide();
        }
    });

    
    $('#receta-form').submit(e => {
        e.preventDefault();
    
        let formData = new FormData();
        formData.append('id', $('#recetaId').val());
        formData.append('NombreReceta', $('#NombreReceta').val());
        formData.append('Imagen', $('#Imagen')[0].files[0]);
        formData.append('TiempoPreparacion', $('#TiempoPreparacion').val());
        formData.append('ID_Categoria', $('#Categoria').val());
    
        // Obtener los ingredientes
        const ingredientes = [];
        $('#ingredientes-section .ingrediente-row input').each(function() {
            ingredientes.push({ ID_Ingrediente: $(this).val() });
        });
        formData.append('Ingredientes', JSON.stringify(ingredientes)); // Convertir a JSON
        
        console.log('Ingredientes:', ingredientes); // Log de los ingredientes


        // Obtener las instrucciones
        const instrucciones = [];
        $('#instrucciones-section .instruccion-row textarea').each(function() {
            instrucciones.push({ Instruccion: $(this).val() });
        });
        formData.append('Instrucciones', JSON.stringify(instrucciones)); // Convertir a JSON
        console.log('Instrucciones:', instrucciones);
        const url = edit === false ? './backend/receta-add.php' : './backend/receta-edit.php';
    
        $.ajax({
            url: url,
            type: 'POST',
            data: formData,
            processData: false,  
            contentType: false,   
            success: (response) => {
                console.log(response);
                let respuesta = JSON.parse(response);
                let template_bar = '';
                template_bar += `
                    <li style="list-style: none;">status: ${respuesta.status}</li>
                    <li style="list-style: none;">message: ${respuesta.message}</li>
                `;
                // Limpiar el formulario
                $('#NombreReceta').val('');
                $('#Imagen').val('');                     
                $('#TiempoPreparacion').val('');
                $('#Categoria').val('0');
                $('#recetaId').val('');
                // Reiniciar los ingredientes
                $('#ingredientes-section').empty(); // Eliminar todos los elementos de ingredientes
                // Reiniciar instrucciones
                $('#instrucciones-section').empty(); // Eliminar todos los elementos de instrucciones

                $('#receta-result').show();
                $('#container').html(template_bar);
                listarRecetas();
            }
        });
    });
    
    

    $(document).on('click', '.receta-edit', (e) => {
        if (confirm('¿Realmente deseas editar la receta?')) {
            const element = $(this)[0].activeElement.parentElement.parentElement; // Encuentra el elemento padre
            const id = $(element).attr('recetaId'); // Obtén el ID de la receta
        
            // Solicitar los detalles de la receta para editar
            $.post('./backend/receta-single.php', { id }, (response) => {
                // Log de la respuesta recibida del servidor
                console.log('Respuesta del servidor:', response);
                
                let receta = JSON.parse(response);
                console.log('Receta parseada:', receta); // Log de la receta ya parseada
    
                // Inserta los datos en los campos correspondientes
                $('#NombreReceta').val(receta.NombreReceta);
                $('#TiempoPreparacion').val(receta.TiempoPreparacion);
                $('#recetaId').val(receta.ID_Receta);
                $('#Categoria').val(receta.ID_Categoria); // Configura el ID de la receta en un campo oculto
    
                // Verificar si hay una imagen asociada y mostrarla si existe
                if (receta.Imagen) {
                    $('#Imagen').attr('src', receta.Imagen); // Muestra la imagen en un elemento <img>
                }
    
                // Limpiar los ingredientes y poblarlos
                $('#ingredientes-section').empty();
                receta.Ingredientes.forEach(ingrediente => {
                    $('#ingredientes-section').append(`
                        <div class="ingrediente-row">
                            <input type="text" value="${ingrediente.NombreIngrediente}" />
                        </div>
                    `);
                });
    
                // Limpiar las instrucciones y poblarlas
                $('#instrucciones-section').empty();
                receta.Instrucciones.forEach(instruccion => {
                    $('#instrucciones-section').append(`
                        <div class="instruccion-row">
                            <textarea>${instruccion.Instruccion}</textarea>
                        </div>
                    `);
                });
    
                // Log para ver qué se está enviando cuando se haga la edición
                $('#receta-form').submit(function (e) {
                    e.preventDefault(); // Evita el envío normal del formulario
    
                    let formData = new FormData();
                    formData.append('id', $('#recetaId').val());
                    formData.append('NombreReceta', $('#NombreReceta').val());
                    formData.append('Imagen', $('#Imagen')[0].files[0]);
                    formData.append('TiempoPreparacion', $('#TiempoPreparacion').val());
                    formData.append('ID_Categoria', $('#Categoria').val());
    
                    // Obtener los ingredientes
                    const ingredientes = [];
                    $('#ingredientes-section .ingrediente-row input').each(function() {
                        ingredientes.push({ ID_Ingrediente: $(this).val() });
                    });
                    formData.append('Ingredientes', JSON.stringify(ingredientes));
    
                    // Obtener las instrucciones
                    const instrucciones = [];
                    $('#instrucciones-section .instruccion-row textarea').each(function() {
                        instrucciones.push({ Instruccion: $(this).val() });
                    });
                    formData.append('Instrucciones', JSON.stringify(instrucciones));
    
                    // Log de lo que se va a enviar
                    console.log('Datos a enviar:', {
                        id: $('#recetaId').val(),
                        NombreReceta: $('#NombreReceta').val(),
                        Imagen: $('#Imagen')[0].files[0],
                        TiempoPreparacion: $('#TiempoPreparacion').val(),
                        ID_Categoria: $('#Categoria').val(),
                        Ingredientes: ingredientes,
                        Instrucciones: instrucciones
                    });
    
                    // Hacer el envío por AJAX
                    const url = edit === false ? './backend/receta-add.php' : './backend/receta-edit.php';
                    $.ajax({
                        url: url,
                        type: 'POST',
                        data: formData,
                        processData: false,  
                        contentType: false,   
                        success: (response) => {
                            console.log('Respuesta del servidor tras envío:', response);
                            // Procesar la respuesta y limpiar el formulario si es necesario...
                        }
                    });
                });
    
                // Establece la bandera de edición en true
                edit = true;
                $('button[type="submit"]').text('Editar Receta');
            });
        }
    });
    
    

    $(document).on('click', '.receta-delete', (e) => {
        if (confirm('¿Realmente deseas eliminar la receta?')) {
            const element = $(this)[0].activeElement.parentElement.parentElement;
            const id = $(element).attr('recetaId');
            $.post('./backend/receta-delete.php', {id}, (response) => {
                console.log(response);
            let respuesta = JSON.parse(response);
            let template_bar = '';
            template_bar += `
                        <li style="list-style: none;">status: ${respuesta.status}</li>
                        <li style="list-style: none;">message: ${respuesta.message}</li>
                    `;
                $('#receta-result').show();
                $('#container').html(template_bar);
                listarRecetas();
            });
        }
    });

    $(document).on('click', '.receta-item', (e) => {
        e.preventDefault();
    
        if (confirm('¿Realmente deseas editar la receta?')) {
            const element = $(this)[0].activeElement.parentElement.parentElement; // Encuentra el elemento padre
            const id = $(element).attr('recetaId'); // Obtén el ID de la receta

        //console.log('ID del Receta:', id);
    
        $.post('./backend/receta-single.php', { id }, (response) => {
            //console.log('Respuesta del servidor:', response);
            // Convierte a objeto el JSON obtenido
            let receta = JSON.parse(response);
            //console.log('Receta:', receta);
    
            // Inserta los datos en los campos correspondientes
            $('#NombreReceta').val(receta.NombreReceta);
            $('#TiempoPreparacion').val(receta.TiempoPreparacion);
            $('#Categoria').val(receta.ID_Categoria);
    
            // Configura el ID de la receta en un campo oculto para su uso posterior
            $('#recetaId').val(receta.ID_Receta);
            ///console.log('ID del receta guardado para actualización:', receta.ID_Receta); // Asegúrate de que este campo exista en tu HTML
    
            // Establece la bandera de edición en true
            edit = true;
           // console.log('Modo de edición activado:', edit);
            
           $('button[type="submit"]').text('Editar Receta');

        });
    }
    });

    document.getElementById('cancelarButton').addEventListener('click', function() {
        // Aquí puedes añadir la lógica para cerrar el formulario o realizar otra acción
        $('#NombreReceta').val('');
        $('#Imagen').val('');                     
        $('#TiempoPreparacion').val('');
        $('#Categoria').val('0');
        $('#recetaId').val('');// Reiniciar el select
        $('#ingredientes-section').val('');
        $('#instrucciones-section').val('');
        // O si estás usando un modal, podrías cerrarlo así:
        // $('#miModal').modal('hide');
    });
    
    $(document).ready(function() {
        // Evento para abrir la página agregar-receta.html cuando se haga clic en el botón "Agregar Receta"
        $('#addRecipeBtn').click(function() {
            window.location.href = 'agregar-receta.html';
        });
    
    });

    // Agregar ingredientes
    document.getElementById('add-ingrediente-btn').addEventListener('click', function() {
        const ingredientesSection = document.getElementById('ingredientes-section');
        const newIngredientRow = document.createElement('div');
        newIngredientRow.className = 'form-group ingrediente-row';
        newIngredientRow.innerHTML = '<input class="form-control" type="text" name="Ingredientes[]" placeholder="Ingrediente" required>';
        ingredientesSection.appendChild(newIngredientRow);
    });

    // Agregar instrucciones
    document.getElementById('add-instruccion-btn').addEventListener('click', function() {
        const instruccionesSection = document.getElementById('instrucciones-section');
        const newInstructionRow = document.createElement('div');
        newInstructionRow.className = 'form-group instruccion-row';
        newInstructionRow.innerHTML = '<textarea class="form-control" name="Instrucciones[]" placeholder="Escriba la instrucción" required></textarea>';
        instruccionesSection.appendChild(newInstructionRow);
    });

});
