// JSON BASE A MOSTRAR EN FORMULARIO
var baseJSON = {
    "NombreReceta": "Receta",
    "Imagen": "URL de la imagen",
    "TiempoPreparacion": 0  // Valor numérico para tiempo de preparación
};

$(document).ready(function(){
    let edit = false;

    let JsonString = JSON.stringify(baseJSON, null, 2);
    $('#description').val(JsonString);
    $('#receta-result').hide();
    listarRecetas();

    function listarRecetas() {
        $.ajax({
            url: './backend/receta-list.php',
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

                        template += `
                            <tr recetaId="${receta.ID_Receta}">
                                <td>${receta.ID_Receta}</td>
                                <td><a href="#" class="receta-item">${receta.NombreReceta}</a></td>
                                <td><ul>${descripcion}</ul></td>
                                <td>
                                    <button class="receta-edit btn btn-warning">
                                                Editar
                                            </button>
                                </td>
                                <td>
                                    <button class="receta-delete btn btn-danger">
                                        Eliminar
                                    </button>
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
        
                                template += `
                                    <tr recetaId="${receta.ID_Receta}">
                                        <td>${receta.ID_Receta}</td>
                                        <td><a href="#" class="receta-item">${receta.NombreReceta}</a></td>
                                        <td><ul>${descripcion}</ul></td>
                                        <td>
                                                 <button class="receta-edit btn btn-warning">
                                                Editar
                                            </button>
                                           </td>

                                        <td>
                                            <button class="receta-delete btn btn-danger">
                                                Eliminar
                                            </button>
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

        let postData = {
            NombreReceta: $('#NombreReceta').val(),  
            Imagen: $('#Imagen').val(),                
            TiempoPreparacion: $('#TiempoPreparacion').val(),
            id: $('#recetaId').val()
        };

        const url = postData.id ? './backend/receta-edit.php' : './backend/receta-add.php';

        $.post(url, postData, (response) => {
            console.log(response);
            let respuesta = JSON.parse(response);
            let template_bar = '';
            template_bar += `
                <li style="list-style: none;">status: ${respuesta.status}</li>
                <li style="list-style: none;">message: ${respuesta.message}</li>
            `;
            $('#NombreReceta').val('');
            $('#Imagen').val('');                     
            $('#TiempoPreparacion').val('');
            $('#recetaId').val('');
            $('#receta-result').show();
            $('#container').html(template_bar);
            listarRecetas();
        });
    });

        $(document).on('click', '.receta-edit', (e) => {
            if (confirm('¿Realmente deseas editar la receta?')) {
                const element = $(this)[0].activeElement.parentElement.parentElement;
                const id = $(element).attr('recetaId');
                $.post('./backend/receta-edit.php', {id}, (response) => {
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
        const element = $(this)[0].activeElement.parentElement.parentElement;
        const id = $(element).attr('recetaId');
        $.post('./backend/receta-single.php', {id}, (response) => {
            let receta = JSON.parse(response);
        $('#nombre').val(receta.nombre);
        $('#ingredientes').val(receta.ingredientes);
        $('#preparacion').val(receta.preparacion);
        $('#tipo').val(receta.tipo);
        $('#usuario_id').val(receta.usuario_id);
        $('#recetaId').val(receta.id);
        delete(receta.nombre);
        delete(receta.ingredientes);
        delete(receta.preparacion);
        delete(receta.tipo);
        delete(receta.usuario_id);
        delete(receta.id);
        let JsonString = JSON.stringify(receta, null, 2);
        $('#description').val(JsonString);
        edit = true;
        });
        e.preventDefault();
    });    
});
