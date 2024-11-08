<?php
session_start();
session_unset();
session_destroy();

// Responder con JSON para que AJAX lo interprete
echo json_encode(["success" => true, "message" => "Sesión cerrada exitosamente"]);

?>