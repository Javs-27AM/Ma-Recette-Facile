<?php
    use BACKEND\API\Recetas;
    header('Content-Type: application/json');
    require_once __DIR__.'/API/Recetas.php';

    $recetas = new Recetas('recetario');  
    $recetas->delete($_POST['id']);
    echo $recetas->getResponse();
?>
