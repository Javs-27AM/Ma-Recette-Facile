<?php
namespace BACKEND\API;

abstract class DataBase {
    protected $conexion;

    public function __construct($database) {
        $this->conexion = @mysqli_connect(
            'localhost',
            'root',
<<<<<<< HEAD
            '12345678a',
=======
            '',
>>>>>>> e08e0c85825f0d6c732b20a89e5c1b73823a7667
            $database
        );
    
        /**
         * NOTA: si la conexión falló $conexion contendrá false
         **/
        if(!$this->conexion) {
            die('¡Base de datos NO conextada!');
        }
        /*else {
            echo 'Base de datos encontrada';
        }*/
    }
}
?>