<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    session_start();
    error_log("Iniciando la función getFavoritos."); // Mensaje de depuración

    // Verificar si el usuario está autenticado
    if (!isset($_SESSION['idUsuario'])) {
        error_log("Usuario no autenticado. ID de usuario no encontrado en la sesión.");
        echo json_encode(["success" => false, "message" => "Usuario no autenticado"]);
        exit;
    }

    $idUsuario = $_SESSION['idUsuario'];
    error_log("ID de usuario: $idUsuario"); // Verifica el ID de usuario

    // Crear una instancia de la clase Usuario para obtener los favoritos
    $usuario = new Usuario();
    $favoritos = $usuario->obtenerFavoritos($idUsuario); // Llama a la función que obtiene los favoritos

    // Verificar si la obtención de favoritos fue exitosa
    if ($favoritos !== false) {
        error_log("Recetas favoritas obtenidas con éxito.");
        echo json_encode(["success" => true, "favoritos" => $favoritos]); // Devuelve los IDs de las recetas favoritas
    } else {
        error_log("Error al obtener los favoritos.");
        echo json_encode(["success" => false, "message" => "No se pudo obtener los favoritos"]);
    }
}
?>
