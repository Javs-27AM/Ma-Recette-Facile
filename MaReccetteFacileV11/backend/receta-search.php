<?php
    use BACKEND\API\Recetas;
    require_once __DIR__.'/API/Recetas.php';

    $recetas = new Recetas('recetario');  
    $recetas->search($_GET['search']);
    echo $recetas->getResponse();
?>
