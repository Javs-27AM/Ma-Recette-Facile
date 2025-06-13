-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2025 a las 04:26:56
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `recetario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `ID_Categoria` int(11) NOT NULL,
  `NombreCategoria` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`ID_Categoria`, `NombreCategoria`) VALUES
(1, 'Postre'),
(2, 'Plato Principal'),
(3, 'Ensalada'),
(4, 'Aperitivo'),
(5, 'Bebida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `ID_Usuario` int(11) NOT NULL,
  `ID_Receta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `favoritos`
--

INSERT INTO `favoritos` (`ID_Usuario`, `ID_Receta`) VALUES
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 7),
(6, 9),
(6, 67),
(6, 68),
(6, 69),
(7, 9),
(7, 10),
(7, 11),
(7, 12),
(10, 1),
(10, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente`
--

CREATE TABLE `ingrediente` (
  `ID_Ingrediente` int(11) NOT NULL,
  `NombreIngrediente` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ingrediente`
--

INSERT INTO `ingrediente` (`ID_Ingrediente`, `NombreIngrediente`) VALUES
(1, 'et4tert'),
(2, 'Azúcar'),
(3, 'Leche'),
(4, 'arroz'),
(5, 'Mantequilla'),
(6, 'Cerdo'),
(7, 'Cafe'),
(8, 'Licor 43'),
(9, 'papa'),
(10, 'Atun'),
(11, 'aceituna'),
(12, 'mango'),
(13, 'chile'),
(14, '150 gr'),
(15, '110 ml.'),
(16, 'Sal'),
(17, 'pnaque'),
(18, ''),
(19, 'rabano'),
(20, 'longaniza'),
(21, 'ASD'),
(22, 'WWW'),
(23, 'SASD'),
(24, 'jicama'),
(25, 'Toño'),
(26, 'asdsad'),
(27, 'berejena'),
(28, 'dssdf'),
(29, 'rrrrrrrr'),
(30, 'ffffff'),
(31, 'kdjksdjs'),
(32, 'sss'),
(33, 'Fresa'),
(34, 'Torta'),
(35, 'Waffle'),
(36, 'bolillo'),
(37, 'Telera'),
(38, 'Leche'),
(39, 'Masa'),
(40, 'Katsup'),
(41, 'Pan'),
(42, 'jamon'),
(43, 'Lechuga'),
(44, 'Cabra'),
(45, 'Huevo'),
(46, 'ddd'),
(47, 'd'),
(48, 'fgfdg'),
(49, 'Jitomate'),
(50, 'Perejil'),
(51, 'Harina');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instruccion`
--

CREATE TABLE `instruccion` (
  `ID_Instruccion` int(11) NOT NULL,
  `NumeroPaso` int(11) NOT NULL,
  `Descripcion` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `instruccion`
--

INSERT INTO `instruccion` (`ID_Instruccion`, `NumeroPaso`, `Descripcion`) VALUES
(1, 1, 'pelar las papas'),
(2, 2, 'freir'),
(3, 0, ''),
(4, 0, ''),
(5, 1, 'sdf'),
(6, 2, 'sdf'),
(7, 1, 'Hervir'),
(8, 2, 'Complementarse'),
(9, 1, 'aire'),
(10, 2, 'pachuca'),
(11, 1, 'papas'),
(12, 2, 'sdfsdf'),
(13, 1, 'dsfsdf'),
(14, 1, 'jdhjkdhf'),
(15, 1, 'SDF'),
(16, 1, 'ASDSA'),
(17, 2, 'SSS'),
(18, 1, 'DFDF'),
(19, 1, 'sdfd'),
(20, 1, 'cxc'),
(21, 2, 'cxcxc'),
(22, 1, 'regi funeada'),
(23, 0, ''),
(24, 0, ''),
(25, 0, ''),
(26, 0, ''),
(27, 0, ''),
(28, 0, ''),
(29, 0, ''),
(30, 0, ''),
(31, 0, ''),
(32, 1, 'rezar'),
(33, 1, 'dasdsa'),
(34, 1, 'adsasd'),
(35, 1, 'dsd'),
(36, 1, 'sssss'),
(37, 0, ''),
(38, 1, 'dfsdf'),
(39, 1, 'ddd'),
(40, 1, 'eeee'),
(41, 2, 'aaa'),
(42, 3, 'cccc'),
(43, 0, ''),
(44, 0, ''),
(45, 0, ''),
(46, 0, ''),
(47, 0, ''),
(48, 0, ''),
(49, 0, ''),
(50, 4, 'Dibujar'),
(51, 3, 'Roncar'),
(52, 5, 'Trapeador'),
(53, 6, 'felicidad'),
(54, 1, 'fsdf'),
(55, 2, 'hhhhh'),
(56, 3, 'fdfd'),
(57, 7, 'volar'),
(58, 1, 'retrete'),
(59, 2, 'werre'),
(60, 3, 'werwer'),
(61, 1, 'dasd'),
(62, 2, 'dsad'),
(63, 3, 'asd'),
(64, 4, 'qqqqq'),
(65, 5, 'aaaaaaaaa'),
(66, 6, 'ccccc'),
(67, 1, 'ssd'),
(68, 2, 'sad'),
(69, 3, '1dfsdfd'),
(70, 1, 'OOO'),
(71, 1, 'q'),
(72, 1, 'dfg'),
(73, 1, 'Lavar el pescado'),
(74, 2, 'Picar las verduras'),
(75, 1, 'ddss'),
(76, 1, 'OJO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_compras`
--

CREATE TABLE `lista_compras` (
  `ID_Ingrediente` int(11) NOT NULL,
  `ID_Receta` int(11) NOT NULL,
  `Cantidad` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntuacion`
--

CREATE TABLE `puntuacion` (
  `ID_Usuario` int(11) NOT NULL,
  `ID_Receta` int(11) NOT NULL,
  `Puntuacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `puntuacion`
--

INSERT INTO `puntuacion` (`ID_Usuario`, `ID_Receta`, `Puntuacion`) VALUES
(6, 1, 5),
(6, 2, 2),
(6, 3, 2),
(6, 5, 5),
(6, 6, 3),
(6, 7, 1),
(6, 9, 1),
(7, 1, 2),
(7, 2, 1),
(7, 3, 2),
(7, 5, 1),
(7, 6, 3),
(7, 7, 5),
(10, 1, 3),
(10, 2, 5),
(10, 3, 2),
(10, 6, 1),
(10, 7, 1),
(10, 12, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receta`
--

CREATE TABLE `receta` (
  `ID_Receta` int(11) NOT NULL,
  `NombreReceta` varchar(168) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Imagen` varchar(1608) DEFAULT NULL,
  `TiempoPreparacion` int(11) DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL,
  `FechaActualizacion` datetime DEFAULT NULL,
  `Eliminado` tinyint(4) NOT NULL,
  `ID_Usuario` int(11) DEFAULT NULL,
  `ID_Categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `receta`
--

INSERT INTO `receta` (`ID_Receta`, `NombreReceta`, `Imagen`, `TiempoPreparacion`, `FechaRegistro`, `FechaActualizacion`, `Eliminado`, `ID_Usuario`, `ID_Categoria`) VALUES
(1, 'Ensalada Cesar', '../images/ensaladaCesar.jpeg', 75, '2024-09-01 00:00:00', '2024-11-06 00:22:17', 0, 1, 3),
(2, 'Spaghetti Bolognese', '../images/spaghettiBolognesa.jpg', 50, '2024-09-03 00:00:00', '2024-09-30 15:37:46', 0, 2, 2),
(3, 'Pollo al Curry', '../images/pollo_curry.jpeg', 15, '2024-09-05 00:00:00', '2024-09-30 15:38:14', 0, 3, 2),
(4, 'Tacos al Pastor', '../images/tacosPastor.jpeg', 30, '2024-09-07 00:00:00', '2024-10-06 20:23:03', 0, 4, 4),
(5, 'Cheesecake', '../images/cheesecake.jpg', 90, '2024-09-09 00:00:00', '2024-09-14 00:00:00', 0, 5, 1),
(6, 'Sushi', '../images/sushi.jpg', 25, '2024-09-22 19:45:50', '2024-09-22 19:45:50', 0, NULL, 1),
(7, 'Atole', '../images/atole.jpeg', 30, '2024-09-22 19:48:10', '2024-09-22 19:48:10', 0, NULL, 1),
(8, 'Lasagna', '../images/Lasagna.jpg', 50, '2024-09-22 23:29:46', '2024-09-22 23:29:46', 0, NULL, 1),
(9, 'Cheesecake', '../images/Cheesecake.jpg', 90, '2024-09-22 23:32:49', '2024-09-22 23:32:49', 0, NULL, 1),
(10, 'Pozole', '../images/pozole.jpg', 60, '2024-09-22 23:36:04', '2024-09-22 23:36:04', 0, NULL, 1),
(11, 'Poutine', '../images/poutine.jpg', 45, '2024-09-22 23:39:00', '2024-09-22 23:39:00', 0, NULL, 1),
(12, 'Pasta Carbonara', '../images/carbonara.jpg', 30, '2024-09-22 23:46:02', '2024-09-22 23:46:02', 0, NULL, 1),
(13, 'Pollo a la Naranja', '../images/pollonaranja.jpg', 35, '2024-09-22 23:58:04', '2024-09-22 23:58:04', 0, NULL, 1),
(14, 'Spaghetti Pesto', '../images/spaghettipesto.jpg', 20, '2024-09-23 00:02:43', '2024-09-23 00:02:43', 1, NULL, 1),
(15, 'Mousse de Chocolate', '../images/mousse.jpg', 15, '2024-09-23 00:04:44', '2024-09-23 00:04:44', 1, NULL, 1),
(16, 'Sopa de espinaca', '../images/sopaespinaca.jpg', 46, '2024-09-23 00:18:24', '2024-09-23 18:13:11', 0, NULL, 1),
(17, 'Arepas', '../images/arepa.jpg', 25, '2024-09-23 00:19:35', '2024-09-23 00:19:35', 0, NULL, 1),
(18, 'Ratatouille', '../images/ratatouille.jpg', 45, '2024-09-23 00:26:04', '2024-09-23 00:26:04', 0, NULL, 1),
(19, 'Pastel tres leches', '../images/pasteltresleches.jpg', 35, '2024-09-23 00:27:43', '2024-09-23 00:27:43', 0, NULL, 1),
(20, 'Fettuccine Alfredo', '../images/FettuccineAlfredo.jpg', 25, '2024-09-23 00:52:51', '2024-09-23 00:52:51', 0, NULL, 1),
(21, 'Carlota de Limon', '../images/carlotadelimon.jpg', 20, '2024-09-23 01:05:05', '2024-09-23 01:05:05', 0, NULL, 1),
(22, 'Hamburguesa', '../images/hamburguesa.jpeg', 20, '2024-09-23 18:10:53', '2024-09-23 18:10:53', 0, NULL, 1),
(23, 'Pizza', '../images/pizza.jpg', 40, '2024-09-23 18:28:02', '2024-09-23 18:28:02', 0, NULL, 1),
(28, 'Dulce de calabaza', '../images/dulce de calabaza.jpg', 60, '2024-09-30 14:04:14', '2024-09-30 14:04:14', 0, NULL, 2),
(29, 'Ensalada de fruta', '../images/ensaladadefruta.jpg', 10, '2024-10-02 12:05:17', '2024-10-02 12:05:17', 0, NULL, 3),
(30, 'Clericot', '../images/clericot.jpeg', 10, '2024-10-06 14:02:23', '2024-10-06 14:02:23', 0, NULL, 5),
(31, 'Cemita', '../images/cemita.png', 180, '2024-10-06 22:36:51', '2024-10-06 22:36:51', 0, NULL, 1),
(32, 'Alfredo', '../images/spaghettialfredo.jpeg', 20, '2024-10-06 22:49:43', '2024-10-06 22:49:43', 0, NULL, 3),
(33, 'Ceviche', '../images/ceviche.jpeg', 1, '2024-10-06 22:54:15', '2024-10-06 22:54:15', 0, NULL, 5),
(34, 'Mojito', '../images/mojito.jpg', 10, '2024-10-06 23:02:09', '2024-10-06 23:02:09', 0, NULL, 5),
(35, 'sddfsdf', '../images/pollo_curry.jpeg', 111, '2024-10-06 23:04:38', '2024-10-06 23:04:38', 0, NULL, 4),
(36, 'Mole Poblano', '../images/mole.jpeg', 222, '2024-10-06 23:15:23', '2024-10-24 11:24:34', 0, NULL, 2),
(37, 'Carajillo', '../images/hamburguesa.jpeg', 5, '2024-10-24 10:24:23', '2024-10-24 11:16:50', 0, NULL, 5),
(38, 'Papas French', '../images/spaghettiBolognesa.jpg', 15, '2024-10-24 10:35:28', '2024-10-24 10:35:28', 0, NULL, 4),
(39, 'Papas French', '../images/mouse.jpeg', 15, '2024-10-30 14:41:44', '2024-10-30 14:41:44', 0, NULL, 4),
(40, 'hhhh', '../images/ceviche.jpeg', 12, '2024-11-04 15:57:19', '2024-11-11 10:54:58', 0, NULL, 5),
(41, 'Alberjones', '../images/ceviche.jpeg', 47, '2024-11-04 16:07:24', '2024-11-22 01:04:39', 1, 6, 5),
(42, 'mangada', '../images/carbonara.jpg', 47, '2024-11-04 17:22:21', '2024-11-22 01:18:01', 0, 6, 5),
(43, 'Ensalada Cesar', '../images/carajillo.jpg', 30, '2024-11-04 17:35:36', '2024-11-11 16:48:02', 0, 6, 3),
(44, 'Ensalada Cesar', '../images/ensaladaCesar.jpeg', 60, '2024-11-04 17:38:16', '2024-11-04 17:38:16', 0, 6, 3),
(45, 'receta 1', '../images/Cheesecake.jpg', 12, '2024-11-05 16:29:24', '2024-11-05 16:29:24', 0, 6, 4),
(46, 'lechuga', '../images/mousse.jpeg', 20, '2024-11-05 16:36:41', '2024-11-05 16:36:41', 0, 6, 1),
(47, 'Mole', '../images/cemita.png', 20, '2024-11-05 16:58:32', '2024-11-05 16:58:32', 0, NULL, 3),
(48, 'pANZA', '../images/atole.jpeg', 10, '2024-11-05 17:07:23', '2024-11-05 17:07:23', 0, 6, 3),
(49, 'ensalada', '../images/ceviche.jpeg', 11, '2024-11-05 17:08:51', '2024-11-07 15:35:29', 0, NULL, 4),
(50, 'FDF', '../images/atole.jpeg', 15, '2024-11-05 17:11:37', '2024-11-05 17:11:37', 0, 6, 2),
(51, 'PLATILLO', '../images/Cheesecake.jpg', 20, '2024-11-05 17:15:35', '2024-11-05 17:15:35', 0, 6, 4),
(52, 'jis', '../images/carajillo.jpg', 14, '2024-11-05 17:17:20', '2024-11-06 00:45:26', 0, 6, 3),
(53, 'Moricion', '../images/ceviche.jpeg', 120, '2024-11-05 17:35:43', '2024-11-06 00:40:52', 0, 6, 2),
(54, 'kjsdkjs', '../images/atole.jpeg', 10, '2024-11-07 15:59:34', '2024-11-07 15:59:34', 0, 6, 3),
(55, 'dsg', '../images/atole.jpeg', 654, '2024-11-07 17:16:17', '2024-11-07 17:16:17', 0, 6, 2),
(56, 'dfsdf', '../images/arepa.jpg', 41, '2024-11-07 17:23:51', '2024-11-07 17:23:51', 0, 6, 3),
(57, 'gggggg', '../images/carbonara.jpg', 4, '2024-11-07 17:27:45', '2024-11-07 17:27:45', 0, 6, 2),
(58, 'qqqqqqqqq', '../images/arepa.jpg', 10, '2024-11-07 17:33:22', '2024-11-07 18:09:15', 0, 6, 4),
(59, 'qqqqqqwwerervddfd', '../images/atole.jpeg', 20, '2024-11-07 18:15:32', '2024-11-07 18:15:32', 0, 6, 2),
(60, 'asdasd', '../images/carajillo.jpg', 10, '2024-11-07 18:42:32', '2024-11-07 18:42:32', 0, 6, 1),
(61, 'oooo', '../images/carlotadelimon.jpg', 45, '2024-11-07 18:43:33', '2024-11-08 00:00:05', 0, 6, 2),
(62, 'pizza al horno', '../images/Cheesecake.jpg', 111, '2024-11-11 15:59:54', '2024-11-11 16:04:00', 0, 7, 3),
(63, 'dfsf', '../images/cemita.png', 41, '2024-11-11 16:16:14', '2024-11-12 11:10:09', 0, 7, 2),
(64, 'francia', '../images/atole.jpeg', 15, '2024-11-11 16:25:33', '2024-11-11 16:25:33', 0, 7, 4),
(65, 'quesopladon', '../images/Cheesecake.jpg', 7, '2024-11-11 16:31:52', '2024-11-11 16:35:40', 0, 7, 3),
(66, 'SDSDDS', '../images/arepa.jpg', 10, '2024-11-11 16:42:20', '2024-11-11 17:22:34', 0, 7, 2),
(67, 'weqwewqe', '../images/ceviche.jpeg', 4, '2024-11-11 17:11:35', '2024-11-11 17:11:35', 0, 7, 4),
(68, 'rr', '../images/carajillo.jpg', 444, '2024-11-11 17:11:54', '2024-11-11 17:11:54', 0, 7, 1),
(69, 'Cevichini', '../images/ceviche.jpeg', 20, '2024-11-18 10:26:14', '2024-11-18 10:26:14', 0, 6, 1),
(70, 'Ensalada Cesar', '../images/atole.jpeg', 1566564, '2024-11-21 17:44:20', '2024-11-21 17:44:20', 0, 10, 3),
(71, 'lLAVERO', '../images/carbonara.jpg', 45, '2024-11-22 01:19:27', '2024-11-22 01:19:27', 0, 10, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recetaingrediente`
--

CREATE TABLE `recetaingrediente` (
  `ID_Receta` int(11) NOT NULL,
  `ID_Ingrediente` int(11) NOT NULL,
  `Cantidad` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recetaingrediente`
--

INSERT INTO `recetaingrediente` (`ID_Receta`, `ID_Ingrediente`, `Cantidad`) VALUES
(36, 4, NULL),
(36, 6, NULL),
(37, 7, NULL),
(37, 8, NULL),
(38, 9, NULL),
(40, 10, NULL),
(41, 1, NULL),
(41, 7, NULL),
(41, 12, NULL),
(41, 13, NULL),
(41, 36, NULL),
(41, 37, NULL),
(41, 38, NULL),
(42, 12, NULL),
(42, 13, NULL),
(42, 14, NULL),
(42, 15, NULL),
(43, 16, NULL),
(44, 17, NULL),
(45, 18, NULL),
(46, 18, NULL),
(47, 7, NULL),
(47, 19, NULL),
(47, 20, NULL),
(48, 18, NULL),
(49, 21, NULL),
(49, 22, NULL),
(49, 23, NULL),
(50, 18, NULL),
(51, 18, NULL),
(54, 4, NULL),
(54, 20, NULL),
(55, 18, NULL),
(56, 18, NULL),
(57, 4, NULL),
(57, 27, NULL),
(57, 28, NULL),
(58, 4, NULL),
(58, 27, NULL),
(58, 29, NULL),
(59, 1, NULL),
(59, 31, NULL),
(60, 32, NULL),
(61, 3, NULL),
(61, 33, NULL),
(61, 34, NULL),
(62, 7, NULL),
(62, 38, NULL),
(62, 39, NULL),
(62, 40, NULL),
(63, 1, NULL),
(63, 7, NULL),
(63, 41, NULL),
(63, 42, NULL),
(64, 7, NULL),
(64, 43, NULL),
(64, 44, NULL),
(65, 45, NULL),
(65, 46, NULL),
(66, 41, NULL),
(67, 47, NULL),
(68, 48, NULL),
(69, 1, NULL),
(69, 49, NULL),
(70, 16, NULL),
(70, 50, NULL),
(71, 51, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recetainstruccion`
--

CREATE TABLE `recetainstruccion` (
  `ID_Receta` int(11) NOT NULL,
  `ID_Instruccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recetainstruccion`
--

INSERT INTO `recetainstruccion` (`ID_Receta`, `ID_Instruccion`) VALUES
(36, 4),
(37, 3),
(38, 1),
(38, 2),
(41, 7),
(41, 8),
(41, 50),
(41, 51),
(41, 52),
(41, 53),
(41, 57),
(43, 70),
(45, 11),
(45, 12),
(46, 13),
(47, 14),
(48, 15),
(50, 18),
(51, 19),
(54, 32),
(55, 33),
(56, 34),
(57, 35),
(59, 38),
(60, 39),
(62, 54),
(62, 55),
(62, 56),
(63, 58),
(63, 59),
(63, 60),
(65, 61),
(65, 62),
(65, 63),
(65, 64),
(65, 65),
(65, 66),
(66, 67),
(66, 68),
(66, 69),
(67, 71),
(68, 72),
(69, 73),
(69, 74),
(70, 75),
(71, 76);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID_Usuario` int(11) NOT NULL,
  `NombreUsuario` varchar(188) NOT NULL,
  `FechaRegistro` datetime NOT NULL,
  `FechaActualizacion` datetime DEFAULT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID_Usuario`, `NombreUsuario`, `FechaRegistro`, `FechaActualizacion`, `Password`) VALUES
(1, 'juanperez', '2024-09-03 02:14:33', NULL, 'password123'),
(2, 'mariahernandez', '2024-09-04 20:13:23', NULL, 'securepassword'),
(3, 'luisgarcia', '2024-09-06 10:10:05', NULL, 'mypassword'),
(4, 'carlalopez', '2024-09-08 13:58:23', NULL, 'pass1234'),
(5, 'andreamartinez', '2024-09-10 06:58:31', NULL, 'password987'),
(6, 'javs', '2024-11-04 19:06:55', NULL, '$2y$10$QBCS1wYMk07qjngiorru0OWQ4izc7cJjOf938MuDtY87rM.YfTZsm'),
(7, 'toño', '2024-11-05 20:45:45', NULL, '$2y$10$WnfyfER0EVk4SPQf2i7BcuBjC9zXYN7URKzDb7QSLOKngxTarjy7C'),
(8, 'papu', '2024-11-19 04:36:45', NULL, '$2y$10$k.ajfR.fbIICghiZ/cdPV.vYnG5vFnnELZuGr4iscYN1qTSVoHW0S'),
(9, 'leon', '2024-11-19 05:03:43', NULL, '$2y$10$UC4SreiEnBWZ/cyLRVyEE.CpSTTCIeDJYuqrYYWXhIccqtyU0ryO6'),
(10, 'ferna', '2024-11-22 00:42:43', NULL, '$2y$10$yo9/T42l2n1o2MeciDyPQuENr09qYq5AAYy0hJ4gkTp360T0Zw8te');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`ID_Categoria`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`ID_Usuario`,`ID_Receta`),
  ADD KEY `ID_Receta` (`ID_Receta`);

--
-- Indices de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
  ADD PRIMARY KEY (`ID_Ingrediente`);

--
-- Indices de la tabla `instruccion`
--
ALTER TABLE `instruccion`
  ADD PRIMARY KEY (`ID_Instruccion`);

--
-- Indices de la tabla `lista_compras`
--
ALTER TABLE `lista_compras`
  ADD PRIMARY KEY (`ID_Ingrediente`,`ID_Receta`),
  ADD KEY `ID_Receta` (`ID_Receta`);

--
-- Indices de la tabla `puntuacion`
--
ALTER TABLE `puntuacion`
  ADD PRIMARY KEY (`ID_Usuario`,`ID_Receta`),
  ADD KEY `ID_Receta` (`ID_Receta`);

--
-- Indices de la tabla `receta`
--
ALTER TABLE `receta`
  ADD PRIMARY KEY (`ID_Receta`),
  ADD KEY `ID_Usuario` (`ID_Usuario`),
  ADD KEY `FK_Receta_Categoria` (`ID_Categoria`);

--
-- Indices de la tabla `recetaingrediente`
--
ALTER TABLE `recetaingrediente`
  ADD PRIMARY KEY (`ID_Receta`,`ID_Ingrediente`),
  ADD KEY `ID_Ingrediente` (`ID_Ingrediente`);

--
-- Indices de la tabla `recetainstruccion`
--
ALTER TABLE `recetainstruccion`
  ADD PRIMARY KEY (`ID_Receta`,`ID_Instruccion`),
  ADD KEY `ID_Instruccion` (`ID_Instruccion`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID_Usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `ID_Categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
  MODIFY `ID_Ingrediente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `instruccion`
--
ALTER TABLE `instruccion`
  MODIFY `ID_Instruccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `receta`
--
ALTER TABLE `receta`
  MODIFY `ID_Receta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`ID_Receta`) REFERENCES `receta` (`ID_Receta`) ON DELETE CASCADE;

--
-- Filtros para la tabla `lista_compras`
--
ALTER TABLE `lista_compras`
  ADD CONSTRAINT `lista_compras_ibfk_1` FOREIGN KEY (`ID_Ingrediente`) REFERENCES `ingrediente` (`ID_Ingrediente`),
  ADD CONSTRAINT `lista_compras_ibfk_2` FOREIGN KEY (`ID_Receta`) REFERENCES `receta` (`ID_Receta`);

--
-- Filtros para la tabla `puntuacion`
--
ALTER TABLE `puntuacion`
  ADD CONSTRAINT `puntuacion_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `puntuacion_ibfk_2` FOREIGN KEY (`ID_Receta`) REFERENCES `receta` (`ID_Receta`) ON DELETE CASCADE;

--
-- Filtros para la tabla `receta`
--
ALTER TABLE `receta`
  ADD CONSTRAINT `FK_Receta_Categoria` FOREIGN KEY (`ID_Categoria`) REFERENCES `categoria` (`ID_Categoria`),
  ADD CONSTRAINT `receta_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`);

--
-- Filtros para la tabla `recetaingrediente`
--
ALTER TABLE `recetaingrediente`
  ADD CONSTRAINT `recetaingrediente_ibfk_1` FOREIGN KEY (`ID_Receta`) REFERENCES `receta` (`ID_Receta`) ON DELETE CASCADE,
  ADD CONSTRAINT `recetaingrediente_ibfk_2` FOREIGN KEY (`ID_Ingrediente`) REFERENCES `ingrediente` (`ID_Ingrediente`) ON DELETE CASCADE;

--
-- Filtros para la tabla `recetainstruccion`
--
ALTER TABLE `recetainstruccion`
  ADD CONSTRAINT `recetainstruccion_ibfk_1` FOREIGN KEY (`ID_Receta`) REFERENCES `receta` (`ID_Receta`) ON DELETE CASCADE,
  ADD CONSTRAINT `recetainstruccion_ibfk_2` FOREIGN KEY (`ID_Instruccion`) REFERENCES `instruccion` (`ID_Instruccion`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
