<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    session_start();
    error_log("Iniciando la función usuarioPuntuacion."); // Mensaje de depuración

    // Verificar si el usuario está autenticado
    if (!isset($_SESSION['idUsuario'])) {
        error_log("Usuario no autenticado. ID de usuario no encontrado en la sesión.");
        echo json_encode(["success" => false, "message" => "Usuario no autenticado"]);
        exit;
    }

    $idUsuario = $_SESSION['idUsuario'];
    $recetaId = $_POST['recetaId'];
    $rating = $_POST['rating']; // Puntuación recibida
    error_log("ID de usuario: $idUsuario, ID de receta: $recetaId, Puntuación: $rating");

    // Crear una instancia de la clase Usuario y llamar a la función usuarioPuntuacion
    $usuario = new Usuario();
    $resultado = $usuario->usuarioPuntuacion($idUsuario, $recetaId, $rating); // Procesa la puntuación

    // Verificar si la acción fue exitosa
    if ($resultado['success']) {
        error_log("Operación de puntuación exitosa.");
        echo json_encode(["success" => true, "action" => $resultado['action']]); // Agregado o actualizado
    } else {
        error_log("Error al procesar la puntuación.");
        echo json_encode(["success" => false, "message" => $resultado['message'] ?? "Error al procesar la puntuación"]);
    }
}
?>
