<?php
require_once __DIR__ . '/API/Recetas.php';
use BACKEND\API\Usuario;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    session_start();
    error_log("Iniciando la función getPuntuacion."); // Mensaje de depuración

    // Verificar si el usuario está autenticado
    if (!isset($_SESSION['idUsuario'])) {
        error_log("ID de usuario no proporcionado.");
        echo json_encode(["success" => false, "message" => "ID de usuario no proporcionado"]);
        exit;
    }

    $idUsuario = $_SESSION['idUsuario'];
    error_log("ID de usuario: $idUsuario"); // Verifica el ID de usuario

    // Crear una instancia de la clase Usuario para obtener las puntuaciones
    $usuario = new Usuario();

    // Obtenemos todas las puntuaciones del usuario
    $puntuaciones = [];

    // Aquí asumimos que quieres todas las puntuaciones del usuario en diferentes recetas
    // Si solo necesitas la puntuación de una receta específica, ajusta la consulta
    $recetas = $usuario->obtenerPuntuacionesDeUsuario($idUsuario); // Debes definir este método para obtener todas las puntuaciones

    if ($recetas !== false) {
        error_log("Puntuaciones obtenidas con éxito.");
        echo json_encode(["success" => true, "puntuaciones" => $recetas]); // Devuelve las puntuaciones de las recetas
    } else {
        error_log("Error al obtener las puntuaciones.");
        echo json_encode(["success" => false, "message" => "No se pudieron obtener las puntuaciones"]);
    }
}
?>
