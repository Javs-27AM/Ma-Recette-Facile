<?php
header('Content-Type: application/json');
require 'db.php';

$data = json_decode(file_get_contents("php://input"));

if (isset($data->nombreUsuario) && isset($data->password)) {
    $nombreUsuario = $data->nombreUsuario;
    //$password = $data->password;
    $password = trim($data->password);


    $stmt = $conn->prepare("SELECT Password FROM usuario WHERE NombreUsuario = ?");
    $stmt->bind_param("s", $nombreUsuario);
    $stmt->execute();
    $stmt->bind_result($hashedPassword);
    $stmt->fetch();

    if (password_verify($password, $hashedPassword)) {
        echo json_encode(['success' => true, 'message' => 'Inicio de sesión exitoso.']);
    } else {
        //echo json_encode(['success' => false, 'message' => 'Contraseña incorrecta.']);
        echo json_encode(['success' => false, 'message' => 'Contraseña incorrecta.', 'hashedPassword' => $hashedPassword]); // Agrega esto para depurar

    }
    
    $stmt->close(); 
    
} else {
    echo json_encode(['success' => false, 'message' => 'Datos incompletos.']);
}
$conn->close();
?>
