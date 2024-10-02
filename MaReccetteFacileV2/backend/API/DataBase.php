<?php
namespace BACKEND\API;

abstract class DataBase {
    protected $conexion;

    public function __construct($database) {
        $this->conexion = @mysqli_connect(
            'localhost',
            'root',
            '12345678a',
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