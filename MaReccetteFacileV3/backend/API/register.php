<?php
namespace BACKEND\API;

require_once 'DataBase.php';

class Register extends DataBase {
    public function __construct($database) {
        parent::__construct($database);
    }

    public function createUser($username, $password) {
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
        $query = "INSERT INTO usuario (NombreUsuario, Password) VALUES (?, ?)";
        $stmt = $this->conexion->prepare($query);
        $stmt->bind_param("ss", $username, $hashedPassword);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }
}
