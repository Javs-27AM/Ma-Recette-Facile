<?php
    use BACKEND\API\Recetas; //estoy usando la clase Recetas que pertenece al espacio de nombres BACKEND\API
    require_once __DIR__.'/API/Recetas.php';

    $recetas = new Recetas('recetario');  
    $recetas->add(json_decode(json_encode($_POST)));
    echo $recetas->getResponse();
?>
