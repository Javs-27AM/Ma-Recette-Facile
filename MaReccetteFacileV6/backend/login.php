<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombreUsuario = $_POST['nombreUsuario'];
    $password = $_POST['password'];

    $usuario = new Usuario();

    if ($usuario->login($nombreUsuario, $password)) {
        session_start();
        $_SESSION['nombreUsuario'] = $nombreUsuario;
        echo json_encode(["success" => true, "message" => $nombreUsuario, "Inicio de sesión exitoso"]);

    } else {
        echo json_encode(["success" => false, "message" => "Usuario o contraseña incorrectos"]);
    }
}
?>
