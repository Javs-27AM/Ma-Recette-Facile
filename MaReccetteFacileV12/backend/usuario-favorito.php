<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    session_start();
    error_log("Iniciando la función usuarioFavorito."); // Mensaje de depuración

    // Verificar si el usuario está autenticado
    if (!isset($_SESSION['idUsuario'])) {
        error_log("Usuario no autenticado. ID de usuario no encontrado en la sesión.");
        echo json_encode(["success" => false, "message" => "Usuario no autenticado"]);
        exit;
    }

    $idUsuario = $_SESSION['idUsuario'];
    $recetaId = $_POST['recetaId'];
    error_log("ID de usuario: $idUsuario, ID de receta: $recetaId"); // Verifica los IDs

    // Crear una instancia de la clase Favoritos y llamar a la función usuarioFavorito
    $usuario = new Usuario();
    $resultado = $usuario->usuarioFavorito($idUsuario, $recetaId); // Define esta función según tu lógica

    // Verificar si la acción fue exitosa
    if ($resultado) {
        error_log("Operación de favorito exitosa. Acción: " . ($resultado['action'] ?? 'unknown'));
        echo json_encode(["success" => true, "action" => $resultado['action']]); // o "removed" según corresponda
    } else {
        error_log("Error al procesar la solicitud.");
        echo json_encode(["success" => false, "message" => "No se pudo procesar la solicitud"]);
    }
}
?>
