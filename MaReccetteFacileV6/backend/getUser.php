<?php
session_start();
header('Content-Type: application/json');

$nombreUsuario = isset($_SESSION['nombreUsuario']) ? $_SESSION['nombreUsuario'] : null;

echo json_encode(["nombreUsuario" => $nombreUsuario]);
?>
