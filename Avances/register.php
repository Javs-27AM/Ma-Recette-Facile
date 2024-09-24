<?php
header('Content-Type: application/json');
require 'db.php';

$data = json_decode(file_get_contents("php://input"));

if (isset($data->nombreUsuario) && isset($data->password)) {
    $nombreUsuario = $data->nombreUsuario;
    $password = password_hash($data->password, PASSWORD_BCRYPT);
    
    $stmt = $conn->prepare("INSERT INTO usuario (NombreUsuario, Password, FechaRegistro) VALUES (?, ?, NOW())");
    $stmt->bind_param("ss", $nombreUsuario, $password);
    
    if ($stmt->execute()) {
        //echo json_encode(['success' => true, 'message' => 'Usuario registrado con éxito.']);
        echo json_encode(['success' => true, 'message' => 'Usuario registrado con éxito.', 'hashedPassword' => $password]); // Agrega esto para ver el hash
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al registrar el usuario.']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Datos incompletos.']);
}
$conn->close();
?>
