<?php
namespace BACKEND\API;

use BACKEND\API\DataBase;
require_once __DIR__ . '/DataBase.php';

class Recetas extends DataBase {
    private $response;

    public function __construct($database='recetario') {
        $this->response = array();
        parent::__construct($database);
        $this->conexion->set_charset("utf8mb4");
    }

   // Agregar receta
public function add($jsonOBJ) {
    $this->response = array(
        'status'  => 'error',
        'message' => 'La consulta falló'
    );

    // Verificar si se proporciona el nombre de la receta
    if (isset($jsonOBJ->NombreReceta)) {
        $sql = "INSERT INTO receta (NombreReceta, Imagen, TiempoPreparacion, FechaRegistro, FechaActualizacion, Eliminado) VALUES (
            '{$jsonOBJ->NombreReceta}',
            '{$jsonOBJ->Imagen}',
            {$jsonOBJ->TiempoPreparacion},
            NOW(),
            NOW(),
            0
        )";

        if ($this->conexion->query($sql)) {
            $this->response['status'] = "success";
            $this->response['message'] = "Receta agregada con éxito";
        } else {
            $this->response['message'] = "ERROR: No se ejecutó $sql. " . mysqli_error($this->conexion);
        }

        $this->conexion->close();
    } else {
        $this->response['message'] = 'ERROR: Falta el valor de NombreReceta en el JSON.';
    }
}


    // Editar receta basada en ID_Receta
    public function edit($jsonOBJ) {
        $this->response = array(
            'status'  => 'error',
            'message' => 'La consulta falló'
        );
    
        if (isset($jsonOBJ->ID_Receta)) {
            $sql = "UPDATE receta SET 
                NombreReceta='{$jsonOBJ->NombreReceta}',
                Imagen='{$jsonOBJ->Imagen}', 
                TiempoPreparacion={$jsonOBJ->TiempoPreparacion},
                FechaActualizacion=NOW()
                WHERE ID_Receta = {$jsonOBJ->ID_Receta}";
    
            if ($this->conexion->query($sql)) {
                $this->response['status'] = "success";
                $this->response['message'] = "Receta actualizada";
            } else {
                $this->response['message'] = "ERROR: No se ejecutó $sql. " . mysqli_error($this->conexion);
            }
    
            $this->conexion->close();
        } else {
            $this->response['message'] = 'ERROR: Falta el valor de ID_Receta en el JSON.';
        }
    
        echo json_encode($this->response);
    }

    // Eliminar receta basada en ID_Receta
    public function delete($id) {
        $this->response = array(
            'status'  => 'error',
            'message' => 'La consulta falló'
        );

        if(isset($id)) {
            $sql = "UPDATE receta SET Eliminado=1 WHERE ID_Receta = {$id}";

            if ($this->conexion->query($sql)) {
                $this->response['status'] =  "success";
                $this->response['message'] =  "Receta eliminada";
            } else {
                $this->response['message'] = "ERROR: No se ejecutó $sql. " . mysqli_error($this->conexion);
            }

            $this->conexion->close();
        }
    }

    // Listar recetas que no estén eliminadas
    public function list() {
        if ($result = $this->conexion->query("SELECT * FROM receta WHERE Eliminado = 0")) {
            $rows = $result->fetch_all(MYSQLI_ASSOC);

            if(!is_null($rows)) {
                foreach($rows as $num => $row) {
                    foreach($row as $key => $value) {
                        $this->response[$num][$key] = utf8_encode($value);
                    }
                }
            }

            $result->free();
        } else {
            die('Query Error: '.mysqli_error($this->conexion));
        }

        $this->conexion->close();
    }

    // Buscar receta basada en ID_Receta o por nombre (NombreReceta)
    public function search($search) {
        if(isset($search)) {
            $sql = "SELECT * FROM receta WHERE (ID_Receta = '{$search}' OR NombreReceta LIKE '%{$search}%') AND Eliminado = 0";

            if ($result = $this->conexion->query($sql)) {
                $rows = $result->fetch_all(MYSQLI_ASSOC);

                if(!is_null($rows)) {
                    foreach($rows as $num => $row) {
                        foreach($row as $key => $value) {
                            $this->response[$num][$key] = utf8_encode($value);
                        }
                    }
                }

                $result->free();
            } else {
                die('Query Error: '.mysqli_error($this->conexion));
            }

            $this->conexion->close();
        }
    }

    // Obtener una receta por ID_Receta
    public function single($id) {
        if(isset($id)) {
            if ($result = $this->conexion->query("SELECT * FROM receta WHERE ID_Receta = {$id}")) {
                $row = $result->fetch_assoc();

                if(!is_null($row)) {
                    foreach($row as $key => $value) {
                        $this->response[$key] = utf8_encode($value);
                    }
                }

                $result->free();
            } else {
                die('Query Error: '.mysqli_error($this->conexion));
            }

            $this->conexion->close();
        }
    }

    // Obtener la respuesta en formato JSON
    public function getResponse() {
        
        return json_encode($this->response, JSON_PRETTY_PRINT);
    }
}

?>
