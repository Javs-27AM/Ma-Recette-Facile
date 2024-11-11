<?php
use BACKEND\API\Recetas;
require_once __DIR__.'/API/Recetas.php';

// Obtener el ID del usuario de los parámetros GET
$idUsuario = isset($_GET['idUsuario']) ? intval($_GET['idUsuario']) : 0;

// Verificar si se proporcionó un ID válido de usuario
if ($idUsuario > 0) {
    $recetas = new Recetas('recetario');  
    // Llamar al método que lista las recetas por usuario (debe estar implementado en la clase Recetas)
    echo $recetas->listarUser($idUsuario);
} else {
    echo json_encode(['error' => 'ID de usuario no válido']);
}
?>
