<?php
namespace BACKEND\API;

use BACKEND\API\DataBase;
require_once __DIR__ . '/DataBase.php';
class Usuario extends DataBase {
    public function __construct() {
        parent::__construct('recetario');
    }
    public function getId() {
        return $this->id; // Suponiendo que $this->id contiene el ID del usuario después de una autenticación exitosa
    }
    

    public function registrar($nombreUsuario, $password) {
        // Verificar si el usuario ya existe
        $queryVerificar = "SELECT ID_Usuario FROM usuario WHERE NombreUsuario = ?";
        $stmtVerificar = $this->conexion->prepare($queryVerificar);
        $stmtVerificar->bind_param('s', $nombreUsuario);
        $stmtVerificar->execute();
        $stmtVerificar->store_result();

        if ($stmtVerificar->num_rows > 0) {
            // Nombre de usuario ya existe
            $stmtVerificar->close();
            return ["success" => false, "message" => "Nombre de usuario ya existe"];
        }
        $stmtVerificar->close();

        // Continuar con el registro si el nombre de usuario no existe
        $hashPassword = password_hash($password, PASSWORD_BCRYPT);
        $fechaRegistro = date('Y-m-d H:i:s');
        $queryInsertar = "INSERT INTO usuario (NombreUsuario, Password, FechaRegistro) VALUES (?, ?, ?)";
        $stmtInsertar = $this->conexion->prepare($queryInsertar);
        $stmtInsertar->bind_param('sss', $nombreUsuario, $hashPassword, $fechaRegistro);

        if ($stmtInsertar->execute()) {
            $stmtInsertar->close();
            return ["success" => true, "message" => "Registro exitoso"];
        } else {
            $stmtInsertar->close();
            return ["success" => false, "message" => "Error en el registro"];
        }
    }

    public function login($nombreUsuario, $password) {
        // Consulta para obtener la contraseña y el ID del usuario
        $query = "SELECT ID_Usuario, Password FROM usuario WHERE NombreUsuario = ?";
        $stmt = $this->conexion->prepare($query);
        $stmt->bind_param('s', $nombreUsuario);
        $stmt->execute();
        $stmt->bind_result($idUsuario, $hashPassword); // Obtener el ID y el hash de la contraseña
    
        // Verificar si se obtuvo un resultado
        if ($stmt->fetch()) {
            // Verificar la contraseña
            if (password_verify($password, $hashPassword)) {
                // Almacenar el ID del usuario en la propiedad de la clase si es necesario
                $this->id = $idUsuario; // Asignar el ID a la variable de instancia
    
                // Cerrar el statement
                $stmt->close();
                return true; // Inicio de sesión exitoso
            }
        }
    
        // Cerrar el statement y devolver false si falla
        $stmt->close();
        return false; // Usuario o contraseña incorrectos
    }
    public function usuarioFavorito($usuarioId, $recetaId) {
        // Verificar si ya existe el favorito
        $queryVerificar = "SELECT ID_Usuario FROM favoritos WHERE ID_Usuario = ? AND ID_Receta = ?";
        $stmtVerificar = $this->conexion->prepare($queryVerificar);
        $stmtVerificar->bind_param('ii', $usuarioId, $recetaId); // Usamos 'ii' porque ambos IDs son enteros
        $stmtVerificar->execute();
        $stmtVerificar->store_result();
    
        if ($stmtVerificar->num_rows > 0) {
            // Si ya es favorito, eliminarlo
            $stmtVerificar->close();
            
            $queryEliminar = "DELETE FROM favoritos WHERE ID_Usuario = ? AND ID_Receta = ?";
            $stmtEliminar = $this->conexion->prepare($queryEliminar);
            $stmtEliminar->bind_param('ii', $usuarioId, $recetaId);
            
            if ($stmtEliminar->execute()) {
                $stmtEliminar->close();
                return ["success" => true, "action" => "removed"]; // Indica que se ha eliminado
            } else {
                $stmtEliminar->close();
                return ["success" => false, "message" => "Error al eliminar el favorito"];
            }
        } else {
            // Si no es favorito, agregarlo
            $stmtVerificar->close();
            
            $queryInsertar = "INSERT INTO favoritos (ID_Usuario, ID_Receta) VALUES (?, ?)";
            $stmtInsertar = $this->conexion->prepare($queryInsertar);
            $stmtInsertar->bind_param('ii', $usuarioId, $recetaId);
            
            if ($stmtInsertar->execute()) {
                $stmtInsertar->close();
                return ["success" => true, "action" => "added"]; // Indica que se ha agregado
            } else {
                $stmtInsertar->close();
                return ["success" => false, "message" => "Error al agregar el favorito"];
            }
        }
    }

    public function esFavorito($usuarioId, $recetaId) {
        $query = $this->pdo->prepare("SELECT * FROM favoritos WHERE ID_Usuario = ? AND ID_Receta = ?");
        $query->execute([$usuarioId, $recetaId]);
        return $query->fetch() !== false; // Retorna true si es favorito, false en caso contrario
    }
    public function obtenerFavoritos($idUsuario) {
        // Consulta corregida para coincidir con las funciones anteriores
        $query = "SELECT ID_Receta FROM favoritos WHERE ID_Usuario = ?";
        
        // Prepara la consulta y la ejecuta
        $stmt = $this->conexion->prepare($query);
        $stmt->bind_param('i', $idUsuario); // Vincula el parámetro como entero
        $stmt->execute();
        
        // Obtiene todos los IDs de las recetas favoritas
        $result = $stmt->get_result();
        $favoritos = [];
        while ($row = $result->fetch_assoc()) {
            $favoritos[] = $row['ID_Receta'];
        }
    
        $stmt->close();
        
        // Devuelve los favoritos o false si no se encontraron
        return !empty($favoritos) ? $favoritos : false;
    }

    public function usuarioPuntuacion($usuarioId, $recetaId, $puntuacion) {
        // Verificar si ya existe una puntuación para esta receta y usuario
        $queryVerificar = "SELECT ID_Usuario FROM puntuacion WHERE ID_Usuario = ? AND ID_Receta = ?";
        $stmtVerificar = $this->conexion->prepare($queryVerificar);
        $stmtVerificar->bind_param('ii', $usuarioId, $recetaId); // Ambos son enteros
        $stmtVerificar->execute();
        $stmtVerificar->store_result();
        
        if ($stmtVerificar->num_rows > 0) {
            // Si ya existe la puntuación, actualizarla
            $stmtVerificar->close();
            
            $queryActualizar = "UPDATE puntuacion SET Puntuacion = ? WHERE ID_Usuario = ? AND ID_Receta = ?";
            $stmtActualizar = $this->conexion->prepare($queryActualizar);
            $stmtActualizar->bind_param('iii', $puntuacion, $usuarioId, $recetaId);
            
            if ($stmtActualizar->execute()) {
                $stmtActualizar->close();
                return ["success" => true, "action" => "updated"]; // Indica que se ha actualizado
            } else {
                $stmtActualizar->close();
                return ["success" => false, "message" => "Error al actualizar la puntuación"];
            }
        } else {
            // Si no existe puntuación, agregarla
            $stmtVerificar->close();
            
            $queryInsertar = "INSERT INTO puntuacion (ID_Usuario, ID_Receta, Puntuacion) VALUES (?, ?, ?)";
            $stmtInsertar = $this->conexion->prepare($queryInsertar);
            $stmtInsertar->bind_param('iii', $usuarioId, $recetaId, $puntuacion);
            
            if ($stmtInsertar->execute()) {
                $stmtInsertar->close();
                return ["success" => true, "action" => "added"]; // Indica que se ha agregado
            } else {
                $stmtInsertar->close();
                return ["success" => false, "message" => "Error al agregar la puntuación"];
            }
        }
    }

    public function haPuntuado($usuarioId, $recetaId) {
        $query = $this->conexion->prepare("SELECT * FROM puntuacion WHERE ID_Usuario = ? AND ID_Receta = ?");
        $query->bind_param('ii', $usuarioId, $recetaId);
        $query->execute();
        return $query->fetch() !== false; // Retorna true si existe la puntuación, false en caso contrario
    }

    public function obtenerPuntuacionesDeUsuario($usuarioId) {
        $query = $this->conexion->prepare("SELECT r.ID_Receta, p.Puntuacion
                                           FROM puntuacion p
                                           JOIN receta r ON p.ID_Receta = r.ID_Receta
                                           WHERE p.ID_Usuario = ?");
        $query->bind_param('i', $usuarioId);
        $query->execute();
        $resultado = $query->get_result();
    
        $puntuaciones = [];
        while ($row = $resultado->fetch_assoc()) {
            $puntuaciones[] = [
                'ID_Receta' => $row['ID_Receta'],
                'Puntuacion' => $row['Puntuacion']
            ];
        }
    
        return $puntuaciones;
    }
    
    
    
    
    

 
    
}
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
        
        // Obtener el ID del usuario de la sesión
        session_start(); // Asegúrate de que la sesión esté iniciada
        $idUsuario = isset($_SESSION['idUsuario']) ? $_SESSION['idUsuario'] : null;

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
                // Modificación: añadir ID_Usuario a la consulta de inserción
                $sql = "INSERT INTO receta (NombreReceta, Imagen, TiempoPreparacion, FechaRegistro, FechaActualizacion, Eliminado, ID_Categoria, ID_Usuario) 
                        VALUES (
                            '$nombreReceta',
                            '$targetFile',
                            $tiempoPreparacion,
                            NOW(),
                            NOW(),
                            0,
                            $idCategoria,
                            $idUsuario
                        )";

                if ($this->conexion->query($sql)) {
                    $idReceta = $this->conexion->insert_id;

                   // Procesar ingredientes
                $ingredientes = json_decode($_POST['Ingredientes'], true); // Decodificar el JSON
                if (!empty($ingredientes) && is_array($ingredientes)) {
                    foreach ($ingredientes as $ingrediente) {
                        // Verificar si el ingrediente tiene un ID
                        if (isset($ingrediente['ID_Ingrediente']) && !empty($ingrediente['ID_Ingrediente'])) {
                            $idIngrediente = $ingrediente['ID_Ingrediente'];
                            // Si el ingrediente tiene un ID, verificamos si existe en la base de datos
                            $sqlCheck = "SELECT ID_Ingrediente FROM ingrediente WHERE ID_Ingrediente = $idIngrediente";
                            $result = $this->conexion->query($sqlCheck);

                            if ($result->num_rows > 0) {
                                // Si existe, obtenemos el ID del ingrediente
                                $row = $result->fetch_assoc();
                                $idIngrediente = $row['ID_Ingrediente'];
                            } else {
                                // Si no existe, es un caso de error
                                $this->response['message'] = "ERROR: Ingrediente con ID $idIngrediente no encontrado.";
                                return json_encode($this->response);
                            }
                        } else {
                            // Si el ingrediente no tiene ID, es nuevo, lo insertamos
                            $nombreIngrediente = $ingrediente['Nombre']; // Usamos el nombre
                            $sqlCheck = "SELECT ID_Ingrediente FROM ingrediente WHERE NombreIngrediente = '$nombreIngrediente'";
                            $result = $this->conexion->query($sqlCheck);

                            if ($result->num_rows > 0) {
                                // Si el ingrediente ya existe por nombre, obtenemos el ID
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
            error_log(print_r($ingredientes, true)); 
            $ingredientesExistentes = []; // Para llevar el control de los ingredientes procesados

            if (!empty($ingredientes) && is_array($ingredientes)) {
                foreach ($ingredientes as $ingrediente) {
                    $idIngrediente = isset($ingrediente['ID_Ingrediente']) ? $ingrediente['ID_Ingrediente'] : null;
                    $nombreIngrediente = $this->conexion->real_escape_string($ingrediente['Nombre']);

                    // Si el ingrediente tiene ID, intentamos actualizarlo
                    if (!empty($idIngrediente)) {
                        $sqlUpdateIngrediente = "UPDATE ingrediente SET NombreIngrediente = '$nombreIngrediente' WHERE ID_Ingrediente = $idIngrediente";
                        $this->conexion->query($sqlUpdateIngrediente);
                        $ingredientesExistentes[] = $idIngrediente; // Añadirlo a la lista de existentes
                    } else {
                        // Verificar si el nombre del ingrediente ya existe en la base de datos
                        $sqlCheckIngrediente = "SELECT ID_Ingrediente FROM ingrediente WHERE NombreIngrediente = '$nombreIngrediente'";
                        $resultCheck = $this->conexion->query($sqlCheckIngrediente);

                        if ($resultCheck && $resultCheck->num_rows > 0) {
                            // Si el ingrediente ya existe, obtener su ID
                            $row = $resultCheck->fetch_assoc();
                            $idIngrediente = $row['ID_Ingrediente'];
                        } else {
                            // Si no existe, insertar el nuevo ingrediente
                            $sqlInsertIngrediente = "INSERT INTO ingrediente (NombreIngrediente) VALUES ('$nombreIngrediente')";
                            if ($this->conexion->query($sqlInsertIngrediente)) {
                                $idIngrediente = $this->conexion->insert_id;
                            }
                        }

                        // Insertar en la tabla recetaIngrediente
                        if (!empty($idIngrediente)) {
                            $sqlRecetaIngrediente = "INSERT INTO recetaIngrediente (ID_Receta, ID_Ingrediente) VALUES ({$jsonOBJ->id}, $idIngrediente)";
                            $this->conexion->query($sqlRecetaIngrediente);
                        }

                    }
                }

    
            }

           // Actualización de Instrucciones
            $instrucciones = json_decode($jsonOBJ->Instrucciones, true);
            $instruccionesExistentes = []; // Para llevar el control de las instrucciones procesadas

            if (!empty($instrucciones) && is_array($instrucciones)) {
                foreach ($instrucciones as $instruccion) {
                    $idInstruccion = isset($instruccion['ID_Instruccion']) ? $instruccion['ID_Instruccion'] : null;
                    $descripcion = $this->conexion->real_escape_string($instruccion['Descripcion']);

                    // Si la instrucción tiene ID, intentamos actualizarla
                    if (!empty($idInstruccion)) {
                        $sqlUpdateInstruccion = "UPDATE instruccion SET Descripcion = '$descripcion' WHERE ID_Instruccion = $idInstruccion";
                        $this->conexion->query($sqlUpdateInstruccion);
                        $instruccionesExistentes[] = $idInstruccion; // Añadirla a la lista de existentes
                    } else {
                        // Si no tiene ID, es una nueva instrucción, la insertamos
                        // Obtener el número de paso más alto actual en la receta
                        $sqlMaxPaso = "SELECT MAX(instr.NumeroPaso) AS maxPaso 
                        FROM recetaInstruccion ri 
                        JOIN instruccion instr ON ri.ID_Instruccion = instr.ID_Instruccion 
                        WHERE ri.ID_Receta = {$jsonOBJ->id}";
                        $resultMaxPaso = $this->conexion->query($sqlMaxPaso);
                        $maxPaso = ($resultMaxPaso && $row = $resultMaxPaso->fetch_assoc()) ? (int)$row['maxPaso'] : 0;

                        // Incrementar el número de paso para la nueva instrucción
                        $maxPaso++;

                        // Insertar la nueva instrucción con el número de paso
                        $sqlInsertInstruccion = "INSERT INTO instruccion (NumeroPaso, Descripcion) VALUES ($maxPaso, '$descripcion')";
                        if ($this->conexion->query($sqlInsertInstruccion)) {
                        $idInstruccion = $this->conexion->insert_id;
                        $sqlRecetaInstruccion = "INSERT INTO recetaInstruccion (ID_Receta, ID_Instruccion) VALUES ({$jsonOBJ->id}, $idInstruccion)";
                        $this->conexion->query($sqlRecetaInstruccion);
                        }

                    }
                }
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

    public function listUser($usuarioId) {
    // Unir receta con categoria para obtener el nombre de la categoría
    $sql = "SELECT r.*, c.NombreCategoria 
            FROM receta r 
            JOIN categoria c ON r.ID_Categoria = c.ID_Categoria 
            WHERE r.Eliminado = 0 AND r.ID_Usuario = ? 
            ORDER BY r.ID_Receta ASC";

    if ($stmt = $this->conexion->prepare($sql)) {
        $stmt->bind_param("i", $usuarioId); // Se asume que ID_Usuario es un entero
        $stmt->execute();
        $result = $stmt->get_result();

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
        $stmt->close();
    } else {
        die('Query Error: ' . mysqli_error($this->conexion));
    }

    $this->conexion->close();
}

    // Listar recetas que no estén eliminadas
    public function listdetails($id) {
        // Unir receta con categoria, ingredientes, instrucciones y calcular la puntuación promedio
        $sql = "SELECT 
                    r.ID_Receta, 
                    r.NombreReceta, 
                    r.Imagen, 
                    r.TiempoPreparacion, 
                    c.NombreCategoria, 
                    i.NombreIngrediente, 
                    ri.Cantidad, 
                    instr.NumeroPaso AS NumeroPaso, 
                    instr.Descripcion AS Descripcion,
                    -- Calcular el promedio de puntuación
                    (SELECT AVG(Puntuacion) FROM puntuacion WHERE ID_Receta = r.ID_Receta) AS PromedioPuntuacion
                FROM 
                    receta r 
                JOIN 
                    categoria c ON r.ID_Categoria = c.ID_Categoria 
                LEFT JOIN 
                    recetaIngrediente ri ON r.ID_Receta = ri.ID_Receta 
                LEFT JOIN 
                    ingrediente i ON ri.ID_Ingrediente = i.ID_Ingrediente 
                LEFT JOIN 
                    recetaInstruccion ri2 ON r.ID_Receta = ri2.ID_Receta 
                LEFT JOIN 
                    instruccion instr ON ri2.ID_Instruccion = instr.ID_Instruccion 
                WHERE 
                    r.Eliminado = 0 AND r.ID_Receta = ? 
                ORDER BY 
                    instr.NumeroPaso ASC";
    
        // Preparar la consulta para evitar inyección SQL
        if ($stmt = $this->conexion->prepare($sql)) {
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result();
    
            $rows = $result->fetch_all(MYSQLI_ASSOC);
            $receta = null;
    
            foreach ($rows as $row) {
                if (!$receta) {
                    $receta = [
                        'ID_Receta' => $row['ID_Receta'],
                        'NombreReceta' => $row['NombreReceta'],
                        'Imagen' => 'images/' . $row['Imagen'],
                        'TiempoPreparacion' => $row['TiempoPreparacion'],
                        'NombreCategoria' => $row['NombreCategoria'],
                        'ingredientes' => [],
                        'instrucciones' => [],
                        'PromedioPuntuacion' => $row['PromedioPuntuacion'] ? round($row['PromedioPuntuacion'], 1) : 0 // Puntuación promedio, redondeada a 1 decimal
                    ];
                }
    
                // Agregar ingredientes si están definidos
                if (!empty($row['NombreIngrediente']) && !in_array($row['NombreIngrediente'], array_column($receta['ingredientes'], 'Nombre'))) {
                    $receta['ingredientes'][] = [
                        'Nombre' => $row['NombreIngrediente']
                    ];
                }
    
                // Agregar instrucciones si están definidas
                if (!empty($row['Descripcion']) && !in_array($row['Descripcion'], array_column($receta['instrucciones'], 'Descripcion'))) {
                    $receta['instrucciones'][] = [
                        'NumeroPaso' => $row['NumeroPaso'],  // Incluye el número de paso
                        'Descripcion' => $row['Descripcion'] // Incluye la descripción
                    ];
                }
            }
    
            $this->response = $receta;
            $stmt->close();
        } else {
            die('Query Error: ' . mysqli_error($this->conexion));
        }
    
        $this->conexion->close();
        return json_encode($this->response);
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
        if (isset($id)) {
            // Consulta principal para obtener los detalles de la receta
            $sql = "SELECT * FROM receta WHERE ID_Receta = {$id}";
    
            if ($result = $this->conexion->query($sql)) {
                $row = $result->fetch_assoc();
    
                if (!is_null($row)) {
                    // Agregar los detalles principales de la receta a la respuesta
                    foreach ($row as $key => $value) {
                        $this->response[$key] = utf8_encode($value);
                    }
    
                    // Consulta adicional para obtener los ingredientes
                    $sql_ingredientes = "SELECT i.ID_Ingrediente, i.NombreIngrediente 
                                         FROM recetaIngrediente ri 
                                         JOIN ingrediente i ON ri.ID_Ingrediente = i.ID_Ingrediente 
                                         WHERE ri.ID_Receta = {$id}";
                    $result_ingredientes = $this->conexion->query($sql_ingredientes);
                    $ingredientes = [];
                    while ($row_ingrediente = $result_ingredientes->fetch_assoc()) {
                        $ingredientes[] = [
                            'ID_Ingrediente' => $row_ingrediente['ID_Ingrediente'], // Agregar ID_Ingrediente
                            'Nombre' => utf8_encode($row_ingrediente['NombreIngrediente']) // Mantener Nombre
                        ];
                    }
                    $this->response['ingredientes'] = $ingredientes;
    
                    // Consulta adicional para obtener las instrucciones
                    $sql_instrucciones = "SELECT instr.ID_Instruccion, instr.Descripcion 
                                        FROM recetaInstruccion ri 
                                        JOIN instruccion instr ON ri.ID_Instruccion = instr.ID_Instruccion 
                                        WHERE ri.ID_Receta = {$id} 
                                        ORDER BY instr.ID_Instruccion ASC";
                    $result_instrucciones = $this->conexion->query($sql_instrucciones);
                    $instrucciones = [];
                    while ($row_instruccion = $result_instrucciones->fetch_assoc()) {
                        $instrucciones[] = [
                            'ID_Instruccion' => $row_instruccion['ID_Instruccion'],
                            'Descripcion' => utf8_encode($row_instruccion['Descripcion'])
                        ];
                    }
                    $this->response['instrucciones'] = $instrucciones;

    
                    // Liberar resultados
                    $result_ingredientes->free();
                    $result_instrucciones->free();
                }
    
                $result->free();
            } else {
                die('Query Error: ' . mysqli_error($this->conexion));
            }
    
            $this->conexion->close();
        }
    
        return json_encode($this->response);
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