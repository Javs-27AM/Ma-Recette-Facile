<?php
session_start();
header('Content-Type: application/json');

// Verificar si el nombre de usuario y el ID del usuario están establecidos en la sesión
$nombreUsuario = isset($_SESSION['nombreUsuario']) ? $_SESSION['nombreUsuario'] : null;
$idUsuario = isset($_SESSION['idUsuario']) ? $_SESSION['idUsuario'] : null;

// Devolver los datos en formato JSON
echo json_encode([
    "nombreUsuario" => $nombreUsuario,
    "idUsuario" => $idUsuario // Incluyendo el ID del usuario en la respuesta
]);
?>
