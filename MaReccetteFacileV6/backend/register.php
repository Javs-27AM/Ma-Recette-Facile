<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombreUsuario = $_POST['nombreUsuario'];
    $password = $_POST['password'];

    $usuario = new Usuario();
    $resultado = $usuario->registrar($nombreUsuario, $password);

    if ($resultado['success']) {
        echo json_encode($resultado);
    } else {
        echo json_encode(["success" => false, "message" => $resultado['message']]);
    }
}

?>