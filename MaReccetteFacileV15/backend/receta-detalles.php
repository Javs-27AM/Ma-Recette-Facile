<?php
    use BACKEND\API\Recetas;
    require_once __DIR__.'/API/Recetas.php';

    // Obtener el ID de la receta de los parámetros GET
    $id = isset($_GET['id']) ? intval($_GET['id']) : 0;

    // Verificar si se proporcionó un ID válido
    if ($id > 0) {
        $recetas = new Recetas('recetario');  
        // Llamar a listdetails con el ID de la receta
        echo $recetas->listdetails($id);
    } else {
        echo json_encode(['error' => 'ID de receta no válido']);
    }
?>
