<?php
session_start();  // Inicia la sesión

use BACKEND\API\Recetas;
require_once __DIR__.'/API/Recetas.php';

// Obtener el ID del usuario desde la sesión
if (isset($_SESSION['idUsuario'])) {
    $usuarioId = $_SESSION['idUsuario'];  // Asegúrate de que el ID esté en la sesión
    $recetas = new Recetas('recetario');
    $recetas->listUser($usuarioId);  // Llamar a listUser en lugar de list
    echo $recetas->getResponse();
} else {
    // Si no hay sesión, devolver un error o una respuesta vacía
    echo json_encode(["error" => "No session found"]);
    exit;
}
?>
