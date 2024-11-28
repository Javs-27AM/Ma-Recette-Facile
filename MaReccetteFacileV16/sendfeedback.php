<?php
header('Content-Type: application/json');

// Incluir PHPMailer desde la ruta correcta
require 'PHPMailer-6.9.3/src/PHPMailer.php';
require 'PHPMailer-6.9.3/src/SMTP.php';
require 'PHPMailer-6.9.3/src/Exception.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

try {
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $comment = $_POST['comment'] ?? '';

    // Validar los datos
    if (empty($name) || empty($email) || empty($comment)) {
        echo json_encode(['success' => false, 'message' => 'Todos los campos son obligatorios.']);
        exit;
    }

    // Configuración de PHPMailer
    $mail = new PHPMailer(true);
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'aguilarmaciasjavier11@gmail.com'; // Cambia por tu email
    $mail->Password = 'xjqm mukp nsoy utmq'; // Usa contraseña de aplicación si usas Gmail
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    // Configuración del correo
    $mail->setFrom($email, $name);
    $mail->addAddress('jcyam_coffee@outlook.com'); // Cambia por el destinatario //aguilarmaciasjavier11@gmail.com
    $mail->isHTML(true);
    $mail->Subject = 'Nuevo feedback recibido';
    $mail->Body    = "<p><strong>Nombre:</strong> $name</p>
                      <p><strong>Email:</strong> $email</p>
                      <p><strong>Comentario:</strong> $comment</p>";

    // Enviar el correo
    $mail->send();
    echo json_encode(['success' => true, 'message' => 'Gracias por tu feedback.']);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'No se pudo enviar el correo. Error: ' . $e->getMessage()]);
}
?>
