<?php
    use BACKEND\API\Recetas;
    require_once __DIR__.'/API/Recetas.php';

    $recetas = new Recetas('recetario');  
    $recetas->edit(json_decode(json_encode($_POST)));
    echo $recetas->getResponse();
?>