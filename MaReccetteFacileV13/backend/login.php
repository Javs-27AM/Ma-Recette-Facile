<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombreUsuario = $_POST['nombreUsuario'];
    $password = $_POST['password'];

    $usuario = new Usuario();

    if ($usuario->login($nombreUsuario, $password)) {
        // Supongamos que login() también establece un ID de usuario en la clase Usuario.
        session_start();
        $_SESSION['nombreUsuario'] = $nombreUsuario;
        $_SESSION['idUsuario'] = $usuario->getId(); // Asegúrate de tener este método en la clase Usuario
        
        echo json_encode(["success" => true, "message" => "Bienvenido, " . $nombreUsuario . "!"]);
    } else {
        echo json_encode(["success" => false, "message" => "Usuario o contraseña incorrectos"]);
    }
}
?>
