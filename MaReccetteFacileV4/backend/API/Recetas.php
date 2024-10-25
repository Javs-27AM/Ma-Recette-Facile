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

    if (is_string($jsonOBJ)) {
        $jsonOBJ = json_decode($jsonOBJ);
    }

    // Verificar si se proporciona el nombre de la receta y otros datos
    if (isset($_POST['NombreReceta'], $_POST['TiempoPreparacion'], $_POST['ID_Categoria'])) {
        $nombreReceta = $_POST['NombreReceta'];
        $tiempoPreparacion = $_POST['TiempoPreparacion'];
        $idCategoria = $_POST['ID_Categoria'];

        // Manejo de la imagen
        if (isset($_FILES['Imagen']) && $_FILES['Imagen']['error'] == UPLOAD_ERR_OK) {
            $targetDir = '../images/';
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
                    $idReceta = $this->conexion->insert_id;

                    // Procesar ingredientes
                    $ingredientes = json_decode($_POST['Ingredientes'], true); // Decodificar el JSON
                    if (!empty($ingredientes) && is_array($ingredientes)) {
                        foreach ($ingredientes as $ingrediente) {
                            // Verificar si el ingrediente ya existe
                            $nombreIngrediente = $ingrediente['ID_Ingrediente'];
                            $sqlCheck = "SELECT ID_Ingrediente FROM ingrediente WHERE NombreIngrediente = '$nombreIngrediente'";
                            $result = $this->conexion->query($sqlCheck);

                            if ($result->num_rows > 0) {
                                // Si existe, obtenemos el ID del ingrediente
                                $row = $result->fetch_assoc();
                                $idIngrediente = $row['ID_Ingrediente'];
                            } else {
                                // Si no existe, insertamos el nuevo ingrediente
                                $sqlIngrediente = "INSERT INTO ingrediente (NombreIngrediente) VALUES ('$nombreIngrediente')";
                                if ($this->conexion->query($sqlIngrediente)) {
                                    // Obtener el ID del ingrediente insertado
                                    $idIngrediente = $this->conexion->insert_id;
                                } else {
                                    $this->response['message'] = "ERROR: No se pudo insertar ingrediente.";
                                    return json_encode($this->response);
                                }
                            }

                            // Ahora, insertar en recetaIngrediente
                            $sqlRecetaIngrediente = "INSERT INTO recetaIngrediente (ID_Receta, ID_Ingrediente) VALUES ($idReceta, $idIngrediente)";
                            $this->conexion->query($sqlRecetaIngrediente);
                        }
                    }

                    // Procesar instrucciones
                    $instrucciones = json_decode($_POST['Instrucciones'], true); // Decodificar el JSON
                    if (!empty($instrucciones) && is_array($instrucciones)) {
                        $numeroPaso = 1; // Inicializar el número de paso
                        foreach ($instrucciones as $instruccion) {
                            // Escapar el contenido de la instrucción para evitar inyección SQL
                            $descripcion = $this->conexion->real_escape_string($instruccion['Instruccion']);
                            
                            if (!empty($descripcion)) { // Verificar que la instrucción no esté vacía
                                // Insertar la instrucción en la tabla instruccion
                                $sqlInstruccion = "INSERT INTO instruccion (NumeroPaso, Descripcion) VALUES ($numeroPaso, '$descripcion')";
                                if ($this->conexion->query($sqlInstruccion)) {
                                    // Obtener el ID de la instrucción insertada
                                    $idInstruccion = $this->conexion->insert_id;

                                    // Insertar en recetaInstruccion con el ID de la receta e instrucción
                                    $sqlRecetaInstruccion = "INSERT INTO recetaInstruccion (ID_Receta, ID_Instruccion) VALUES ($idReceta, $idInstruccion)";
                                    $this->conexion->query($sqlRecetaInstruccion);
                                } else {
                                    $this->response['message'] = "ERROR: No se pudo insertar instrucción.";
                                    return json_encode($this->response);
                                }
                            }

                            $numeroPaso++; // Incrementar el número de paso para la siguiente instrucción
                        }
                    }


                    // Respuesta de éxito
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
            $targetDir = '../images/';
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

        // Actualizar la receta
        $sql = "UPDATE receta SET 
            NombreReceta='{$jsonOBJ->NombreReceta}',
            Imagen='{$imagenActual}', 
            TiempoPreparacion={$jsonOBJ->TiempoPreparacion},
            ID_Categoria = {$jsonOBJ->ID_Categoria},
            FechaActualizacion=NOW()
            WHERE ID_Receta = {$jsonOBJ->id}";

        if ($this->conexion->query($sql)) {
            // Actualización de Ingredientes
            $ingredientes = json_decode($jsonOBJ->Ingredientes, true);
            $ingredientesExistentes = []; // Para llevar el control de los ingredientes procesados

            if (!empty($ingredientes) && is_array($ingredientes)) {
                foreach ($ingredientes as $ingrediente) {
                    $idIngrediente = $ingrediente['ID_Ingrediente'];
                    $nombreIngrediente = $this->conexion->real_escape_string($ingrediente['NombreIngrediente']);

                    // Si el ingrediente tiene ID, intentamos actualizarlo
                    if (!empty($idIngrediente)) {
                        $sqlUpdateIngrediente = "UPDATE ingrediente SET NombreIngrediente = '$nombreIngrediente' WHERE ID_Ingrediente = $idIngrediente";
                        $this->conexion->query($sqlUpdateIngrediente);
                        $ingredientesExistentes[] = $idIngrediente; // Añadirlo a la lista de existentes
                    } else {
                        // Si no tiene ID, es un nuevo ingrediente, lo insertamos
                        $sqlInsertIngrediente = "INSERT INTO ingrediente (NombreIngrediente) VALUES ('$nombreIngrediente')";
                        if ($this->conexion->query($sqlInsertIngrediente)) {
                            $idIngrediente = $this->conexion->insert_id;
                            $sqlRecetaIngrediente = "INSERT INTO recetaIngrediente (ID_Receta, ID_Ingrediente) VALUES ({$jsonOBJ->id}, $idIngrediente)";
                            $this->conexion->query($sqlRecetaIngrediente);
                        }
                    }
                }

                // Eliminar los ingredientes que no están en la lista de ingredientes actuales
                $ingredientesExistentesStr = implode(',', $ingredientesExistentes);
                $sqlDeleteIngredientes = "DELETE FROM recetaIngrediente WHERE ID_Receta = {$jsonOBJ->id} AND ID_Ingrediente NOT IN ($ingredientesExistentesStr)";
                $this->conexion->query($sqlDeleteIngredientes);
            }

            // Actualización de Instrucciones
            $instrucciones = json_decode($jsonOBJ->Instrucciones, true);
            $instruccionesExistentes = []; // Para llevar el control de las instrucciones procesadas

            if (!empty($instrucciones) && is_array($instrucciones)) {
                foreach ($instrucciones as $instruccion) {
                    $idInstruccion = $instruccion['ID_Instruccion'];
                    $numeroPaso = (int) $instruccion['NumeroPaso'];
                    $descripcion = $this->conexion->real_escape_string($instruccion['Descripcion']);

                    // Si la instrucción tiene ID, intentamos actualizarla
                    if (!empty($idInstruccion)) {
                        $sqlUpdateInstruccion = "UPDATE instruccion SET NumeroPaso = $numeroPaso, Descripcion = '$descripcion' WHERE ID_Instruccion = $idInstruccion";
                        $this->conexion->query($sqlUpdateInstruccion);
                        $instruccionesExistentes[] = $idInstruccion; // Añadirla a la lista de existentes
                    } else {
                        // Si no tiene ID, es una nueva instrucción, la insertamos
                        $sqlInsertInstruccion = "INSERT INTO instruccion (NumeroPaso, Descripcion) VALUES ($numeroPaso, '$descripcion')";
                        if ($this->conexion->query($sqlInsertInstruccion)) {
                            $idInstruccion = $this->conexion->insert_id;
                            $sqlRecetaInstruccion = "INSERT INTO recetaInstruccion (ID_Receta, ID_Instruccion) VALUES ({$jsonOBJ->id}, $idInstruccion)";
                            $this->conexion->query($sqlRecetaInstruccion);
                        }
                    }
                }

                // Eliminar las instrucciones que no están en la lista de instrucciones actuales
                $instruccionesExistentesStr = implode(',', $instruccionesExistentes);
                $sqlDeleteInstrucciones = "DELETE FROM recetaInstruccion WHERE ID_Receta = {$jsonOBJ->id} AND ID_Instruccion NOT IN ($instruccionesExistentesStr)";
                $this->conexion->query($sqlDeleteInstrucciones);
            }

            // Establecer el estado de éxito
            $this->response['status'] = "success";
            $this->response['message'] = "Receta actualizada con éxito";
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
