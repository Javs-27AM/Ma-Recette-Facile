-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-11-2024 a las 21:14:51
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
(7, 9),
(7, 10),
(7, 11),
(7, 12);

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
(9, 'papa'),
(10, 'jgjk'),
(11, 'dfs'),
(12, 'mango'),
(13, 'alchohol'),
(14, '150 gr'),
(15, '110 ml.'),
(16, 'Sal'),
(17, 'pnaque'),
(18, '');

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
(7, 1, 'gaaf'),
(8, 2, 'asdsd'),
(9, 1, 'aire'),
(10, 2, 'pachuca');

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
(1, 'Ensalada Cesar', '../images/carbonara.jpg', 60, '2024-09-01 00:00:00', '2024-11-04 17:59:39', 0, 1, 3),
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
(14, 'Spaghetti Pesto', '../images/spaghettipesto.jpg', 20, '2024-09-23 00:02:43', '2024-09-23 00:02:43', 0, NULL, 1),
(15, 'Mousse de Chocolate', '../images/mousse.jpg', 15, '2024-09-23 00:04:44', '2024-09-23 00:04:44', 0, NULL, 1),
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
(40, 'fsdf', '../images/atole.jpeg', 12, '2024-11-04 15:57:19', '2024-11-04 15:57:19', 0, NULL, 5),
(41, 'mangada', '../images/ceviche.jpeg', 47, '2024-11-04 16:07:24', '2024-11-04 16:07:24', 0, 6, 5),
(42, 'mangada', '../images/cemita.png', 47, '2024-11-04 17:22:21', '2024-11-04 17:22:21', 0, 6, 5),
(43, 'Ensalada Cesar', '../images/ensaladaCesar.jpeg', 30, '2024-11-04 17:35:36', '2024-11-04 18:45:49', 0, 6, 3),
(44, 'Ensalada Cesar', '../images/ensaladaCesar.jpeg', 60, '2024-11-04 17:38:16', '2024-11-04 17:38:16', 0, 6, 3);

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
(40, 11, NULL),
(41, 12, NULL),
(41, 13, NULL),
(42, 12, NULL),
(42, 13, NULL),
(42, 14, NULL),
(42, 15, NULL),
(44, 17, NULL);

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
(40, 5),
(40, 6),
(41, 7),
(41, 8),
(42, 9),
(42, 10);

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
(7, 'toño', '2024-11-05 20:45:45', NULL, '$2y$10$WnfyfER0EVk4SPQf2i7BcuBjC9zXYN7URKzDb7QSLOKngxTarjy7C');

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
  MODIFY `ID_Ingrediente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `instruccion`
--
ALTER TABLE `instruccion`
  MODIFY `ID_Instruccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `receta`
--
ALTER TABLE `receta`
  MODIFY `ID_Receta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
