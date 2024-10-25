<?php
namespace BACKEND\API;

require_once 'DataBase.php';

class Login extends DataBase {
    public function __construct($database) {
        parent::__construct($database);
    }

    public function authenticateUser($username, $password) {
        $query = "SELECT * FROM usuario WHERE NombreUsuario = ?";
        $stmt = $this->conexion->prepare($query);
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user && password_verify($password, $user['Password'])) {
            return true;
        }
        return false;
    }
}
