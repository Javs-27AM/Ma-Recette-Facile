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
        'status' => 'error',
        'message' => 'La consulta falló'
    );

    // Asegúrate de que $jsonOBJ sea un objeto y no un string
    if (is_string($jsonOBJ)) {
        $jsonOBJ = json_decode($jsonOBJ);
    }

    // Verificar si se proporciona el nombre de la receta
    if (isset($_POST['NombreReceta']) && isset($_POST['TiempoPreparacion']) && isset($_POST['ID_Categoria'])) {
        $nombreReceta = $_POST['NombreReceta'];
        $tiempoPreparacion = $_POST['TiempoPreparacion'];
        $idCategoria = $_POST['ID_Categoria'];

        // Manejo de la imagen
        if (isset($_FILES['Imagen']) && $_FILES['Imagen']['error'] == UPLOAD_ERR_OK) {
            $targetDir = '../images/'; // Agrego la barra al final para evitar problemas con la ruta
            $targetFile = $targetDir . basename($_FILES['Imagen']['name']);
            $uploadOk = 1;
            $imageFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));

            // Verificar si la imagen es un formato válido
            $validImageTypes = ['jpg', 'png', 'jpeg', 'gif'];
            if (!in_array($imageFileType, $validImageTypes)) {
                $this->response['message'] = 'ERROR: Solo se permiten archivos JPG, JPEG, PNG y GIF.';
                return json_encode($this->response);
            }

            // Intentar mover el archivo subido a la carpeta de destino
            if (move_uploaded_file($_FILES['Imagen']['tmp_name'], $targetFile)) {
                // Si se carga correctamente, guardamos la ruta en la base de datos
                $sql = "INSERT INTO receta (NombreReceta, Imagen, TiempoPreparacion, FechaRegistro, FechaActualizacion, Eliminado, ID_Categoria) 
                        VALUES (
                            '$nombreReceta',
                            '$targetFile',
                            $tiempoPreparacion,
                            NOW(),
                            NOW(),
                            0,
                            $idCategoria
                        )";

                if ($this->conexion->query($sql)) {
                    $this->response['status'] = "success";
                    $this->response['message'] = "Receta agregada con éxito";
                } else {
                    $this->response['message'] = "ERROR: No se ejecutó $sql. " . mysqli_error($this->conexion);
                }
            } else {
                $this->response['message'] = 'ERROR: Hubo un problema al subir la imagen.';
            }
        } else {
            $this->response['message'] = 'ERROR: No se subió ninguna imagen o hubo un error en la carga.';
        }
    } else {
        $this->response['message'] = 'ERROR: Faltan valores en el formulario (NombreReceta, TiempoPreparacion o ID_Categoria).';
    }

    $this->conexion->close();
    return json_encode($this->response);
}




public function edit($jsonOBJ) {
    $this->response = array(
        'status'  => 'error',
        'message' => 'La consulta falló'
    );

    if (isset($jsonOBJ->id)) {
        // Obtener la receta existente para obtener la imagen actual
        $sqlSelect = "SELECT Imagen FROM receta WHERE ID_Receta = {$jsonOBJ->id}";
        $result = $this->conexion->query($sqlSelect);

        if ($result->num_rows > 0) {
            $receta = $result->fetch_assoc();
            $imagenActual = $receta['Imagen'];
        } else {
            $this->response['message'] = 'ERROR: No se encontró la receta.';
            return json_encode($this->response);
        }

        // Manejo de la nueva imagen
        if (isset($_FILES['Imagen']) && $_FILES['Imagen']['error'] == UPLOAD_ERR_OK) {
            $targetDir = '../images';
            $targetFile = $targetDir . basename($_FILES['Imagen']['name']);
            $uploadOk = 1;
            $imageFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));

            // Verificar si la imagen es un formato válido
            $validImageTypes = ['jpg', 'png', 'jpeg', 'gif'];
            if (!in_array($imageFileType, $validImageTypes)) {
                $this->response['message'] = 'ERROR: Solo se permiten archivos JPG, JPEG, PNG y GIF.';
                return json_encode($this->response);
            }

            // Intentar mover el archivo subido a la carpeta de destino
            if (move_uploaded_file($_FILES['Imagen']['tmp_name'], $targetFile)) {
                // Si se carga correctamente, usar la nueva imagen
                $imagenActual = $targetFile;
            } else {
                $this->response['message'] = 'ERROR: Hubo un problema al subir la nueva imagen. Manteniendo la imagen anterior.';
            }
        }

        // Preparar la consulta de actualización
        $sql = "UPDATE receta SET 
            NombreReceta='{$jsonOBJ->NombreReceta}',
            Imagen='{$imagenActual}', 
            TiempoPreparacion={$jsonOBJ->TiempoPreparacion},
            ID_Categoria = {$jsonOBJ->ID_Categoria},
            FechaActualizacion=NOW()
            WHERE ID_Receta = {$jsonOBJ->id}";

        // Ejecutar la consulta de actualización
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

    return json_encode($this->response);
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
        // Unir receta con categoria para obtener el nombre de la categoría
        $sql = "SELECT r.*, c.NombreCategoria 
                FROM receta r 
                JOIN categoria c ON r.ID_Categoria = c.ID_Categoria 
                WHERE r.Eliminado = 0
                ORDER BY r.ID_Receta ASC";
    
        if ($result = $this->conexion->query($sql)) {
            $rows = $result->fetch_all(MYSQLI_ASSOC);
    
            if (!is_null($rows)) {
                foreach ($rows as $num => $row) {
                    foreach ($row as $key => $value) {
                        // Si es la columna de la imagen, añadir el prefijo 'images/'
                        if ($key === 'Imagen') {
                            $this->response[$num][$key] = utf8_encode('images/' . $value);
                        } else {
                            $this->response[$num][$key] = utf8_encode($value);
                        }
                    }
                }
            }
    
            $result->free();
        } else {
            die('Query Error: ' . mysqli_error($this->conexion));
        }
    
        $this->conexion->close();
    }
    
    
    
   // Buscar receta basada en ID_Receta o por nombre (NombreReceta)
public function search($search) {
    if (isset($search)) {
        // Unir receta con categoria para obtener el nombre de la categoría
        $sql = "SELECT r.*, c.NombreCategoria 
        FROM receta r 
        JOIN categoria c ON r.ID_Categoria = c.ID_Categoria 
        WHERE (r.ID_Receta = '{$search}' OR r.NombreReceta LIKE '%{$search}%') 
        AND r.Eliminado = 0 
        ORDER BY r.ID_Receta ASC";


        if ($result = $this->conexion->query($sql)) {
            $rows = $result->fetch_all(MYSQLI_ASSOC);

            if (!is_null($rows)) {
                foreach ($rows as $num => $row) {
                    foreach ($row as $key => $value) {
                        // Si es la columna de la imagen, añade el prefijo 'images/' si no lo tiene ya
                        if ($key === 'Imagen') {
                            if (strpos($value, 'images/') === false) {
                                $this->response[$num][$key] = utf8_encode('images/' . $value);
                            } else {
                                $this->response[$num][$key] = utf8_encode($value);
                            }
                        } else {
                            $this->response[$num][$key] = utf8_encode($value);
                        }
                    }
                }
            }

            $result->free();
        } else {
            die('Query Error: ' . mysqli_error($this->conexion));
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

    public function filter($category, $maxTime) {
        // Unir receta con categoria para obtener el nombre de la categoría
        $sql = "SELECT r.*, c.NombreCategoria 
                FROM receta r 
                JOIN categoria c ON r.ID_Categoria = c.ID_Categoria 
                WHERE r.Eliminado = 0";
    
        // Aplicar filtro por categoría
        if (!empty($category)) {
            $sql .= " AND r.ID_Categoria = {$category}";
        }
    
        // Aplicar filtro por tiempo
        if ($maxTime > 0) {
            $sql .= " AND r.TiempoPreparacion <= {$maxTime}";
        }
    
        // Ejecutar la consulta
        if ($result = $this->conexion->query($sql)) {
            $rows = $result->fetch_all(MYSQLI_ASSOC);
    
            if (!is_null($rows)) {
                foreach ($rows as $num => $row) {
                    foreach ($row as $key => $value) {
                        // Si es la columna de la imagen, añade el prefijo 'images/'
                        if ($key === 'Imagen') {
                            $this->response[$num][$key] = utf8_encode('images/' . $value);
                        } else {
                            $this->response[$num][$key] = utf8_encode($value);
                        }
                    }
                }
            }
    
            $result->free();
        } else {
            die('Query Error: ' . mysqli_error($this->conexion));
        }
    
        $this->conexion->close();
    }
    
    

    // Obtener la respuesta en formato JSON
    public function getResponse() {
        
        return json_encode($this->response, JSON_PRETTY_PRINT);
    }
}


?>
