-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2024 a las 21:31:19
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
(1, 'Harina'),
(2, 'Azúcar'),
(3, 'Leche'),
(4, 'Huevo'),
(5, 'Mantequilla'),
(6, 'Cerdo'),
(7, 'Cafe'),
(8, 'Licor 43'),
(9, 'papa');

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
(4, 0, '');

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
(1, 'Ensalada Cesar', '../imagesensaladaCesar.jpeg', 60, '2024-09-01 00:00:00', '2024-09-30 14:30:03', 1, 1, 3),
(2, 'Spaghetti Bolognese', '../imagesspaghettiBolognesa.jpg', 50, '2024-09-03 00:00:00', '2024-09-30 15:37:46', 1, 2, 2),
(3, 'Pollo al Curry', '../imagespollo_curry.jpeg', 15, '2024-09-05 00:00:00', '2024-09-30 15:38:14', 1, 3, 2),
(4, 'Tacos al Pastor', '../imagestacosPastor.jpeg', 30, '2024-09-07 00:00:00', '2024-10-06 20:23:03', 1, 4, 4),
(5, 'Cheesecake', 'cheesecake.jpg', 90, '2024-09-09 00:00:00', '2024-09-14 00:00:00', 1, 5, 1),
(6, 'Sushi', 'sushi.jpg', 25, '2024-09-22 19:45:50', '2024-09-22 19:45:50', 1, NULL, 1),
(7, 'Tacos al Pastor', 'tacos_al_pastor.jpg', 30, '2024-09-22 19:48:10', '2024-09-22 19:48:10', 1, NULL, 1),
(8, 'Lasagna', 'lasagna.jpg', 50, '2024-09-22 23:29:46', '2024-09-22 23:29:46', 1, NULL, 1),
(9, 'Cheesecake', 'cheesecake.jpg', 90, '2024-09-22 23:32:49', '2024-09-22 23:32:49', 1, NULL, 1),
(10, 'Pozole', 'pozole.jpg', 60, '2024-09-22 23:36:04', '2024-09-22 23:36:04', 1, NULL, 1),
(11, 'Pollo al Curry', 'pollo_al_curry.jpg', 45, '2024-09-22 23:39:00', '2024-09-22 23:39:00', 1, NULL, 1),
(12, 'Pasta Carbonara', 'carbonara.jpg', 30, '2024-09-22 23:46:02', '2024-09-22 23:46:02', 1, NULL, 1),
(13, 'Pollo a la Naranja', 'pollo_naranja.jpg', 35, '2024-09-22 23:58:04', '2024-09-22 23:58:04', 1, NULL, 1),
(14, 'Spaghetti Pesto', 'spaghetti_pesto.jpg', 20, '2024-09-23 00:02:43', '2024-09-23 00:02:43', 1, NULL, 1),
(15, 'Mousse de Chocolate', 'mousse_chocolate.jpg', 15, '2024-09-23 00:04:44', '2024-09-23 00:04:44', 1, NULL, 1),
(16, 'Peso de espinaca', 'C:fakepathpollo_curry.jpeg', 46, '2024-09-23 00:18:24', '2024-09-23 18:13:11', 1, NULL, 1),
(17, 'Arepas', 'arepas.jpg', 25, '2024-09-23 00:19:35', '2024-09-23 00:19:35', 1, NULL, 1),
(18, 'Ratatouille', 'ratatouille.jpg', 45, '2024-09-23 00:26:04', '2024-09-23 00:26:04', 1, NULL, 1),
(19, 'Sushi', 'sushi_roll.jpg', 35, '2024-09-23 00:27:43', '2024-09-23 00:27:43', 1, NULL, 1),
(20, 'Fettuccine Alfredo', 'fettuccine_alfredo.jpg', 25, '2024-09-23 00:52:51', '2024-09-23 00:52:51', 1, NULL, 1),
(21, 'Carlota de Limon', 'carlota_limon.jpg', 20, '2024-09-23 01:05:05', '2024-09-23 01:05:05', 1, NULL, 1),
(22, 'Hamburguesa', 'hamburguesa.jpeg', 20, '2024-09-23 18:10:53', '2024-09-23 18:10:53', 1, NULL, 1),
(23, 'Pizza', '../imagespollo_curry.jpeg', 40, '2024-09-23 18:28:02', '2024-09-23 18:28:02', 1, NULL, 1),
(28, 'Mole', '../images/mole.jpeg', 60, '2024-09-30 14:04:14', '2024-09-30 14:04:14', 1, NULL, 2),
(29, 'Ensalada Azafata', '../images/ensaladaCesar.jpeg', 10, '2024-10-02 12:05:17', '2024-10-02 12:05:17', 1, NULL, 3),
(30, 'Clericot', 'clericot.jpeg', 10, '2024-10-06 14:02:23', '2024-10-06 14:02:23', 1, NULL, 5),
(31, 'Mouse de Chocolate', '../images/mouse.jpeg', 180, '2024-10-06 22:36:51', '2024-10-06 22:36:51', 1, NULL, 1),
(32, 'Alfredo', '../images/tacosPastor.jpeg', 20, '2024-10-06 22:49:43', '2024-10-06 22:49:43', 1, NULL, 3),
(33, 'Atun', '../images/mouse.jpeg', 1, '2024-10-06 22:54:15', '2024-10-06 22:54:15', 1, NULL, 5),
(34, 'assa', '../images/pollo_curry.jpeg', 10, '2024-10-06 23:02:09', '2024-10-06 23:02:09', 1, NULL, 2),
(35, 'sddfsdf', '../images/pollo_curry.jpeg', 111, '2024-10-06 23:04:38', '2024-10-06 23:04:38', 1, NULL, 4),
(36, 'Mole Poblano', '../images/mole.jpeg', 222, '2024-10-06 23:15:23', '2024-10-24 11:24:34', 0, NULL, 2),
(37, 'Carajillo', '../images/hamburguesa.jpeg', 5, '2024-10-24 10:24:23', '2024-10-24 11:16:50', 0, NULL, 5),
(38, 'Papas French', '../images/spaghettiBolognesa.jpg', 15, '2024-10-24 10:35:28', '2024-10-24 10:35:28', 0, NULL, 4);

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
(38, 9, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recetainstruccion`
--

CREATE TABLE `recetainstruccion` (
  `ID_Receta` int(11) NOT NULL,
  `ID_Instruccion` int(11) NOT NULL,
  `Orden` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recetainstruccion`
--

INSERT INTO `recetainstruccion` (`ID_Receta`, `ID_Instruccion`, `Orden`) VALUES
(36, 4, NULL),
(37, 3, NULL),
(38, 1, NULL),
(38, 2, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID_Usuario` int(11) NOT NULL,
  `NombreUsuario` varchar(188) NOT NULL,
  `FechaRegistro` datetime NOT NULL,
  `FechaActualizacion` datetime DEFAULT NULL,
  `Password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID_Usuario`, `NombreUsuario`, `FechaRegistro`, `FechaActualizacion`, `Password`) VALUES
(1, 'juanperez', '2024-09-03 02:14:33', NULL, 'password123'),
(2, 'mariahernandez', '2024-09-04 20:13:23', NULL, 'securepassword'),
(3, 'luisgarcia', '2024-09-06 10:10:05', NULL, 'mypassword'),
(4, 'carlalopez', '2024-09-08 13:58:23', NULL, 'pass1234'),
(5, 'andreamartinez', '2024-09-10 06:58:31', NULL, 'password987');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`ID_Categoria`);

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
  MODIFY `ID_Ingrediente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `instruccion`
--
ALTER TABLE `instruccion`
  MODIFY `ID_Instruccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `receta`
--
ALTER TABLE `receta`
  MODIFY `ID_Receta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `lista_compras`
--
ALTER TABLE `lista_compras`
  ADD CONSTRAINT `lista_compras_ibfk_1` FOREIGN KEY (`ID_Ingrediente`) REFERENCES `ingrediente` (`ID_Ingrediente`),
  ADD CONSTRAINT `lista_compras_ibfk_2` FOREIGN KEY (`ID_Receta`) REFERENCES `receta` (`ID_Receta`);

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
