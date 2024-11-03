<?php
use BACKEND\API\Recetas;
require_once __DIR__.'/API/Recetas.php';

// Inicializa las variables para la categoría y el tiempo
$filterCategory = isset($_GET['filter-category']) ? $_GET['filter-category'] : '';
$filterTime = isset($_GET['filter-time']) ? (int)$_GET['filter-time'] : 0;

$recetas = new Recetas('recetario');

// Filtra las recetas basadas en la categoría y el tiempo máximo
$recetas->filter($filterCategory, $filterTime);
echo $recetas->getResponse();
?>
