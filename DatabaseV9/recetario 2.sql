-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-11-2024 a las 03:30:07
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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
(1, 'Lechuga Romana'),
(2, 'Spaghetti'),
(3, 'Pechuga de pollo'),
(4, 'Carne de cerdo'),
(5, 'Queso crema'),
(6, 'Arroz'),
(7, 'Harina de maíz'),
(8, 'Carne de res molida'),
(9, 'Hojaldre'),
(10, 'Papa'),
(11, 'Chocolate'),
(12, 'Berenjena'),
(13, 'Harina de trigo'),
(14, 'Pasta Fettuccini'),
(15, 'Galletas María'),
(16, 'Carne molida'),
(17, 'Calabaza Castilla'),
(18, 'Melón'),
(19, 'Vino tinto joven'),
(20, 'Queso parmesano'),
(21, 'Pescado mero'),
(22, 'Menta'),
(23, 'Chile ancho limpio'),
(24, 'Licor'),
(25, 'Maíz pozolero'),
(26, 'Espinaca'),
(27, 'Vinagre de manzana'),
(28, 'Salsa Perrins'),
(29, 'Aceite de oliva'),
(30, 'Zumo de limón'),
(31, 'Picatostes'),
(32, 'Yema de huevo'),
(33, 'Ajo'),
(34, 'Pasta de tomate'),
(35, 'azúcar'),
(36, 'Albahaca'),
(37, 'Perejil'),
(38, 'Sal'),
(39, 'Cebolla morada'),
(40, 'Limón'),
(41, 'Orégano'),
(42, 'Cebolleta'),
(43, 'Jengibre'),
(44, 'Guindilla pequeña'),
(45, 'Curry molido'),
(46, 'Cúrcuma molida'),
(47, 'Comino molida'),
(48, 'Tomate triturado'),
(49, 'Pimienta negra molida'),
(50, 'Leche de coco'),
(51, 'Aguja de cerdo'),
(52, 'Zumo de piña'),
(53, 'Cayena molida'),
(54, 'Pasta de achiote'),
(55, 'Vinagre de vino blanco'),
(56, 'Cebolla blanca'),
(57, 'Piña'),
(58, 'Lima'),
(59, 'Cilantro'),
(60, 'Tortillas de maíz'),
(61, 'Mantequilla'),
(62, 'Leche condensada'),
(63, 'Media crema'),
(64, 'Grenetina'),
(65, 'Fresas'),
(66, 'Alga nori'),
(67, 'Salmón'),
(68, 'Aguacate'),
(69, 'Pepino'),
(70, 'Arroz para sushi'),
(71, 'Agua'),
(72, 'Canela'),
(73, 'Masa de maíz'),
(74, 'Leche evaporada'),
(75, 'Hierbas finas'),
(76, 'Concentrado de tomate con pollo'),
(77, 'Jugo Maggi'),
(78, 'Salsa inglesa'),
(79, 'Sal con cebolla en polvo'),
(80, 'Laminas de pasta para lasagna'),
(81, 'Queso manchego'),
(82, 'Aceite vegetal'),
(83, 'huevo'),
(84, 'Esencia de vainilla'),
(85, 'Azucar glass'),
(87, 'Fécula de maíz'),
(88, 'Queso cheddar'),
(89, 'Caldo de carne'),
(90, 'Careta de cerdo'),
(91, 'Pimienta'),
(92, 'Pimienta blanca'),
(93, 'Aceite de maíz'),
(94, 'Hojuelas de chile'),
(95, 'Azúcar mascabado'),
(96, 'Vinagre de arroz'),
(97, 'Jugo de naranja'),
(98, 'Salsa de soya'),
(99, 'Ajonjolí blanco'),
(100, 'Ajonjolí negro'),
(101, 'Aceite de ajonjolí'),
(102, 'Sal con ajo'),
(103, 'Cebollín'),
(104, 'Consóme de pollo'),
(105, 'Nuez'),
(106, 'Crema para batir'),
(107, 'Pimienta negra'),
(108, 'Queso mozzarella'),
(109, 'Leche'),
(110, 'Jitomate'),
(111, 'Calabacita'),
(112, 'Brandy'),
(113, 'Polvo para hornear'),
(114, 'Crema de leche'),
(115, 'Mostaza'),
(116, 'Ají'),
(117, 'Levadura'),
(118, 'Salsa marinara'),
(119, 'Manzana verde'),
(120, 'Refresco de limón'),
(121, 'Durazno'),
(122, 'Uva'),
(123, 'Hielo'),
(124, 'Agua mineral'),
(125, 'Piloncillo'),
(126, 'Clavos de olor'),
(127, 'Anís'),
(128, 'Naranja'),
(129, 'Plátano'),
(130, 'Mango'),
(131, 'Queso Oaxaca'),
(132, 'Papalo'),
(133, 'Chipotle'),
(134, 'Salsa picante'),
(135, 'Tostadas'),
(136, 'Ron blanco'),
(137, 'Esencia de azahar'),
(138, 'Manteca de cerdo'),
(139, 'Chile mulato'),
(140, 'Chile pasilla'),
(141, 'Caldo de pollo'),
(142, 'Almendras'),
(143, 'Cacahuates'),
(144, 'Pepitas de calabaza'),
(145, 'Nuez pecana'),
(146, 'Tomate verde'),
(147, 'Plátano macho'),
(148, 'Clavo'),
(149, 'Comino'),
(150, 'Tomillo'),
(151, 'Bolillo frito'),
(152, 'Pasitas'),
(153, 'Piezas de pollo'),
(154, 'Café'),
(155, 'Laurel'),
(156, 'Mejorana'),
(157, 'Pierna de puerco'),
(158, 'Maciza de puerco'),
(159, 'Espinazo de puerco'),
(160, 'Manita de puerco'),
(161, 'Rabáno'),
(162, 'Chile piquín'),
(163, 'Tostadas de maíz');

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
(1, 1, 'Prepararamos primero los picatostes caseros. Para ello precalentamos el horno a 180°c.'),
(2, 2, 'Frotamos el pan con un diente de ajo y lo cortamos en dados.'),
(3, 3, 'Aderezamos el pan con un poco de aceite de oliva y los horneamos durante 5 minutos hasta que estén dorados.'),
(4, 4, 'Para el aderezo, hacemos puré el diente de ajo que habíamos usado para frotar el pan y lo mezclamos con el aceite,la salsa Perrins, el zumo de limón, una cucharada de vinagre y la yema de huevo. Batimos bien hasta emulsionar y lo reservamos.'),
(5, 5, 'Con la verdura desinfectada echamos el aliño o salsa César por encima de las barcas u hojas de lechuga romana. Completamos rellenando las hojas con algunos picatostes y rallamos en el momento el queso parmesano por encima'),
(6, 1, 'Para preparar la salsa boloñesa necesitamos colocar una cacerola en el fuego y calentar en ella un chorro generoso de aceite de oliva virgen extra. Cuando lo tengamos listo, echamos el diente de ajo, previamente pelado y laminado, hasta que coja calor. Entonces, echamos la cebolla, bien picadita, y dejamos que se poche.'),
(7, 2, 'Cuando la cebolla ha cogido color, echamos el tomate triturado y bajamos el fuego para que se haga sin poner la cocina patas arriba. Pasados un par de minutos, echamos la sal al gusto juntos con una cucharada de azúcar para quitar la acidez del tomate, y un poquito de orégano y perejil. Removemos bien todo y dejamos que el tomate se cueza unos 15 minutos con el fuego bajo.'),
(8, 3, 'En un bol aparte mezclamos la carne picada con el zumo de medio limón, y lo aderezamos con un poquito de perejil y sal al gusto. Ponemos aceite de oliva virgen extra en una sartén y, cuando esté caliente, echamos la carne en ella y la dejamos hasta que esté doradita pero no hecha del todo.'),
(9, 4, 'Entonces, echamos la carne en la cacerola con la salsa de tomate y dejamos que termine de hacerse a fuego lento.'),
(10, 5, 'Mientras, vamos cociendo los espaguetis en una cacerola con agua abundante y un poquito de sal al gusto. Cuando estén al dente, los escurrimos y los echamos en la cacerola de salsa boloñesa para que cojan todo el sabor de la carne y del tomate.'),
(11, 1, 'Lo primero es tener preparados todos los ingredientes. Cortar el pollo en piezas de un bocado. Picar la cebolleta y muy fino el diente de ajo, el jengibre y \r\n			la guindilla sin las semillas, si la usamos. Si usamos cebolla troceada congelada ahorraremos aún más tiempo.'),
(12, 2, 'Calentar un poco de aceite en una sartén o cazuela y freír la cebolleta 2 minutos. Agregar el ajo, el jengibre y la guindilla, dar unas vueltas e incorporar el tomate. \r\n			Pasado 1 minuto, agregar todas las especias y remover bien.'),
(13, 3, 'Incorporar el pollo, salpimentar y mezclar. Cocinar a fuego fuerte unos pocos minutos, hasta que esté dorado por todas partes. Cubrir con la leche de coco o nata y dejar reducir ligeramente. \r\n			Servir con perejil o cilantro fresco picado.'),
(14, 1, 'Cortamos la carne de cerdo en trozos de unos 2 cm. En un recipiente hondo mezclamos la cayena molida, la pasta de achiote, el ajo en polvo, el orégano, el comino, el vinagre, \r\n			el zumo de piña y una pizca de sal y pimienta.  Añadimos la carne y removemos bien para que se impregne del adobo. Marinamos, en la nevera, durante un par de horas.'),
(15, 2, 'Precalentamos el horno a 180º C para que coja temperatura mientras montamos una brochetas. Cortamos la piña en dados de un tamaño similar a los trozos de carne. Ensartamos la piña y el cerdo, \r\n			alternando ambos, en varias brochetas de madera. Colocamos sobre una bandeja de horno cubierta con papel de horno y cocemos durante 10-15 minutos o hasta que la carne esté dorada.'),
(16, 3, 'Cuando la carne esté lista, la sacamos del horno y dejamos reposar unos minutos. Mientras tanto cortamos la cebolla en pequeños trozos y calentamos las tortillas en una sartén. Retiramos las brochetas y \r\n			cortamos la carne y la piña en trozos pequeños. Servimos sobre las tortillas, con unos trozos de cebolla, un poco de cilantro fresco y unos gajos de lima.'),
(17, 1, 'Para la base, mezcla la mantequilla con las galletas; vacía en un molde para pay y cubre el fondo con la mezcla de galleta.'),
(18, 2, 'Para el relleno, bate el queso crema hasta que esté suave, agrega la Leche Condensada, la Media Crema, la ralladura y el jugo de limón; con la batidora encendida \r\n		agrega la grenetina poco a poco. Vierte sobre la base y refrigera durante 2 horas o hasta que esté firme.'),
(19, 3, 'Decora con las fresas y refrigera por 30 minutos más.'),
(20, 1, 'Coceremos el arroz (tipo glutinoso o especial para sushi) y después enfriarlo con un abanico tras aliñarlo con vinagre, azúcar y sal.'),
(21, 2, 'Prepararamos una juliana de aguacate y haremos lo mismo con el pepino para tenerlo listo cuando vayamos a formar los makis.'),
(22, 3, 'Cortamos el salmón eligiendo la zona de la ventresca para darle unos cortes en tiras.'),
(23, 4, 'Cortamos la hoja de alga nori en dos, la ponemos sobre una esterilla o makisu forrada de film transparente de cocina dejando el lado rugoso arriba, \r\n		y sobre ella extendemos el arroz presionando un poco para que se adhiera.En el centro del arroz, colocamos las tiras de pescado, el pepino y el aguacate y opcionalmente, un poco de wasabi, si nos gusta el toque picante de este condimento.'),
(24, 5, 'Ya solo falta enrollar el alga ayudados con la esterilla y formar un cilindro. A la hora de servirlo hay que cortarlo en 8 porciones, ayudados de un cuchillo humedecido para que no se nos quede pegado el arroz.'),
(25, 1, 'Calienta el agua con la canela; al hervor agrega la masa previamente disuelta y el Chocolate Granulado. Mueve constantemente hasta que se disuelva el chocolate.'),
(26, 2, 'Agrega la Leche Condensada y la Leche Evaporada; deja hervir por 10 minutos, retira del fuego y cuela. Sirve caliente en jarritos de barro.'),
(27, 1, 'Para la salsa, licúa el puré de tomate con las hierbas finas, el agua y el Concentrado de Tomate con Pollo; cocina hasta que espese ligeramente.'),
(28, 2, 'Para el relleno, calienta 2 cucharadas de aceite, fríe la cebolla con el ajo hasta que cambien de color, agrega la carne, el Jugo, la Salsa Tipo Inglesa \r\n		y la sal con cebolla; cocina por 8 minutos o hasta que la carne esté cocida.'),
(29, 3, 'En una sartén, unta el aceite restante, vierte un poco de la salsa, añade una capa de 3 láminas de pasta, una de relleno, otra de salsa y una más de queso; \r\n		repite el procedimiento hasta terminar con el resto de los ingredientes. Tapa y cocina a fuego bajo por 17 minutos. Decora con el perejil y ofrece.'),
(30, 1, 'Horno precalentado a 180 °C.'),
(31, 2, 'Extiende la pasta hojaldre sobre una mesa enharinada con ayuda de un rodillo, forma 3 rectángulos de 20 cm x 15 cm, coloca cada rectángulo sobre una charola \r\n		engrasada y enharinada, barniza con el huevo, espolvorea un poco de azúcar y hornea a 180 °C de 20 a 25 minutos, deja enfriar.'),
(32, 3, 'Para la crema pastelera, calienta el agua con la Leche Condensada hasta que suelte el primer hervor. Aparte, mezcla las yemas con la esencia de vainilla y \r\n		la fécula de maíz. Vierte poco a poco sin dejar de mover a la mezcla anterior y cocina hasta que espese ligeramente moviendo constantemente para evitar que se pegue; \r\n		deja enfriar y refrigera por 1 hora. Para el glaseado, mezcla el azúcar glass con el jugo de limón y 2 cucharadas de agua hasta integrar por completo.'),
(33, 4, 'Forma el pastel colocando una capa de pasta hojaldre, unta con un poco de crema pastelera y repite el procedimiento hasta terminar con una capa de pasta. \r\n		Cubre la superficie del pastel con el glaseado y decora con líneas de chocolate, ofrece.'),
(34, 1, 'Corta las papas en tiras.'),
(35, 2, 'Calienta una olla con aceite para freír a fuego alto. Una vez que el aceite esté listo, sumerge una porción de las tiras de papa en la olla. Mantenlas friéndose de 2 a 4 minutos.'),
(36, 3, 'Saca las papas de la olla y colócalas sobre papel de cocina.'),
(37, 4, 'Repite los últimos pasos hasta que todas las papas cortadas estén fritas. Reserva.'),
(38, 5, 'Derrite mantequilla en un sartén a fuego medio-alto.'),
(39, 6, 'Antes de que la mantequilla esté totalmente derretida, agrega la harina y mezcla los ingredientes hasta que se forme una preparación dorada.'),
(40, 7, 'Vierte el caldo de carne poco a poco. No dejes de revolver la mezcla para evitar que se formen grumos.'),
(41, 8, 'Cocina la salsa gravy a fuego medio-bajo hasta que se espese. Sazona con sal y pimienta.'),
(42, 9, 'Sirve las papas fritas de acuerdo a las porciones deseadas. Añade sal y pedazos de queso cheddar al gusto.'),
(43, 10, 'Vierte la salsa gravy, mientras sigue caliente, sobre las papas.'),
(44, 1, 'Bata las yemas en un bol con una pizca de sal y 1/3 del queso Manchego.'),
(45, 2, 'Ponga a calentar una sartén con aceite a fuego medio y en cuanto esté caliente incorpore la careta de cerdo (o panceta) cortada a tiras; cuézala durante unos minutos, hasta que se dore.'),
(46, 3, 'Mientras tanto, cueza la pasta en abundante agua hirviendo y salada y, una vez transcurrido el tiempo de cocción indicado en el paquete, cuele la pasta, \r\n		viértala en la sartén con la careta de cerdo (o panceta), mézclelo bien y, con el fuego apagado, añada las yemas batidas con un par de cucharadas del agua de cocción de la pasta; mézclelo durante unos 30 segundos.'),
(47, 4, 'Añada el queso Manchego (o Pecorino) que queda, mézclelo y sírvalo inmediatamente con abundante pimienta negra molida.'),
(48, 1, 'Para el pollo, mezcla la sal con ajo, la pimienta, 1 taza de fécula, la harina, los huevos y la Leche Evaporada, bate perfectamente hasta integrar por completo. \r\n		Añade el pollo y mezcla; refrigera por 1 hora. Fríe el pollo en el aceite caliente y coloca en papel absorbente para retirar el exceso de grasa.'),
(49, 2, 'Para la salsa de naranja, calienta el aceite, fríe ligeramente el jengibre, el ajo y las hojuelas de chile. Añade el azúcar, el vinagre, el jugo de naranja y la Salsa de Soya; \r\n		calienta hasta que hierva, agrega la fécula de maíz previamente disuelta y el aceite de ajonjolí; cocina hasta que espese ligeramente.'),
(50, 3, 'Sirve el pollo con la salsa, decora con el ajonjolí y el cebollín, ofrece.'),
(51, 1, 'Para el pesto, licúa las hojas de albahaca con el perejil, el consomé de pollo, la sal con ajo, el aceite de oliva y las nueces. Añade la Media Crema y mezcla perfectamente.'),
(52, 2, 'En una sartén, calienta la mantequilla con el espagueti previamente cocido y escurrido; agrega lo que licuaste y cocina durante 5 minutos a fuego medio moviendo ocasionalmente.'),
(53, 3, '.Sirve, decora con nueces y hojas de albahaca. Ofrece.'),
(54, 1, 'Mezcla el Chocolate para Mesa con la Media Crema y funde a baño María hasta que se disuelva por completo.'),
(55, 2, 'Bate la crema hasta que se formen picos; añade la preparación anterior y la grenetina previamente disuelta y mezcla con movimientos envolvente.'),
(56, 3, 'Vierte la mezcla en copas y refrigera; decora con Chocolate en Polvo Granulado.'),
(57, 1, 'Calienta la mantequilla y fríe la cebolla hasta que este ligeramente transparente. Agrega las espinacas y cocina por 5 minutos.'),
(58, 2, 'Licúa las espinacas con la Leche Evaporada, la Media Crema, el agua, la sal, la pimienta y la fécula disuelta. Cocina por 8 minutos \r\n		a fuego bajo o hasta que espese ligeramente.'),
(59, 1, 'Combine la harina de maíz, el agua, el queso, la leche y la sal, mezclando minuciosamente. Deje reposar la mezcla aproximadamente 5 minutos.'),
(60, 2, 'Prepare las arepas para 18 disco, cada una de aproximadamente 3 pulgadas de diámetro y 1/4 pulgada de gruesa.'),
(61, 3, 'Caliente levemente engrasada con mantequilla. Fría las arepas en grupos hasta que estén crujientes y doradas por ambos lados.'),
(62, 1, 'Con ayuda de un cuchillo, corta la berenjena en rodajas de grosor mediano. Coloca las rodajas en un recipiente amplio, vierte el agua y la sal de grano.'),
(63, 2, 'Deja reposar por 20 minutos. Durante este tiempo notarás que la berenjena comenzará a soltar un jugo de color obscuro; esta acción se conoce cómo desflemar y ayuda a \r\n		que la consistencia del vegetal se vuelva más suave y su sabor se vuelva menos fuerte. Escurre, enjuaga y reserva.'),
(64, 3, 'Corta el jitomate y la calabaza en rodajas de grosor mediano y reserva.'),
(65, 4, 'Precalienta el horno a 180 °C.'),
(66, 5, 'En un molde circular vierte y distribuye el aceite de oliva, la salsa de tomate preparada y la albahaca. Acomoda una rodaja de berenjena, una de \r\n		tomate y una de calabaza una tras otra alternadamente hasta llenar el molde; comienza de afuera hacia adentro, esto ayudará a darle la forma deseada. Sazona con sal y pimienta.'),
(67, 6, 'Hornea por 35 minutos, a 190 °C. La idea principal es dejar que la verdura comience a rostizarse'),
(68, 7, 'Decora con albahaca y disfruta.'),
(69, 1, 'Horno precalentado a 180 °C.'),
(70, 2, 'Para el bizcocho, bate las claras a punto de turrón, añade el azúcar, la esencia de vainilla y las yemas una a una. Añade de forma envolvente la harina de trigo, \r\n		el polvo para hornear y mezcla hasta integrar. Vierte sobre un molde de 22 cm engrasado y enharinado; hornea a 180 °C de 30 a 35 minutos o hasta que al introducir un palillo este salga limpio.'),
(71, 3, 'Para las 3 leches, mezcla la Leche Condensada con la Media Crema, la Leche Evaporada y el brandy. Desmolda el bizcocho, pica la superficie con un palillo y baña con la mezcla de tres leches'),
(72, 4, 'Para la cobertura, bate la crema con el azúcar glass hasta que doble su volumen. Cubre el pastel con la preparación anterior y refrigera por 2 horas. Decora con frutos.'),
(73, 1, 'Coloca suficiente agua en una olla para cocinar los fideos, agrega sal y lleva a hervir.'),
(74, 2, 'Una vez hirviendo añade la pasta, cocínala siguiendo las indicaciones del empaque. Prepara una sartén grande en otra hornilla a fuego medio.'),
(75, 3, 'Derrite la mantequilla en la sartén caliente, añade la Crema de Leche y baja el fuego. Deja hervir hasta que la crema se reduzca ligeramente y añade el queso parmesano.'),
(76, 4, 'Con una espátula remueve derritiendo el queso, sazona con perejil picado y Pimienta Negra recién molida'),
(77, 5, 'Una vez lista la pasta, drénala y colócala sobre la salsa. Mezcla bien hasta que la salsa cubra la pasta y sirve enseguida. Decora con perejil y queso parmesano adicional.'),
(78, 1, 'Licúa la Leche Condensada LA LECHERA® con la Leche Evaporada y sin dejar de licuar, agrega poco a poco el jugo de limón.'),
(79, 2, 'En un refractario cuadrado, coloca una capa de galletas, un poco de la mezcla de limón y repite hasta terminar con el resto de los ingredientes. Cubre con plástico adherente y refrigera por 1 hora o hasta que esté firme.'),
(80, 3, 'Decora con las rodajas de limón, las galletas troceadas, las hojas de menta y la ralladura de limón. Ofrece.'),
(81, 1, 'En un sartén, calentar la mitad el aceite. Una vez que esté listo, agregar la cebolla picada y el ajo granulado. Cocinar hasta que la cebolla esté blanda y transparente.'),
(82, 2, 'En un bol, juntar todos los ingredientes (incluyendo el sofrito) y con la mano integrar, amasando levemente la carne.'),
(83, 3, 'Dividir la mezcla en 6 porciones y luego darles la forma de hamburguesa del diámetro que cada uno estime conveniente. Refrigerar por 30 minutos.'),
(84, 4, 'Volver a calentar aceite en el sartén y colocar las hamburguesas. Cocinar a fuego medio hasta que estén doradas por ambos lados y su interior esté cocido.'),
(85, 1, 'Precaliente el horno a 375 ºF.'),
(86, 2, 'Reúna, ralle y mida todos los ingredientes antes de comenzar a preparar la receta.'),
(87, 3, 'En un tazón mediano, mezcle 1 taza de harina, la levadura, el azúcar y el agua usando una cuchara.'),
(88, 4, 'Incorpore gradualmente la otra taza de harina hasta formar una bola de masa.'),
(89, 5, 'Enharine una tabla de cortar o una superficie limpia. Coloque la bola de masa sobre la superficie, y luego, con las manos limpias, amase durante unos 5 minutos.'),
(90, 6, 'Rocíe un tazón con aceite antiadherente en aerosol. Ponga la masa en el tazón y cúbrala con un paño limpio. Coloque el tazón sobre la estufa mientras esté \r\n		precalentando el horno (pero no en una hornilla encendida) y deje reposar durante 10 a 15 minutos; precalentar el horno hará que la estufa esté ligeramente caliente y ayudará a que la masa crezca.'),
(91, 7, 'Rocíe una bandeja para hornear de 12 x 16 pulgadas con aceite antiadherente en aerosol. Extienda la masa en una capa uniforme sobre la bandeja para hornear. Extienda la masa en una capa uniforme sobre \r\n		la bandeja. Para una corteza más gruesa, use una bandeja más pequeña.'),
(92, 8, 'Añada una capa fina de salsa marinara, dejando descubierta 1/2 pulgada de la orilla.'),
(93, 9, 'Añada el queso rallado y los ingredientes para pizza. Tenga cuidado de no poner demasiados ingredientes, o se reblandecerá.'),
(94, 10, 'Hornee aproximadamente durante 15 minutos, hasta que la orilla dore , y el queso se derrita y esté ligeramente tostado en algunas partes.'),
(95, 11, 'Refrigere lo que sobre antes de 2 horas. Consuma en un plazo de 3 a 5 días.'),
(96, 1, 'Calienta el agua con el piloncillo, la canela, el clavo, el anís y la naranja hasta que hierva.'),
(97, 2, 'Añade la calabaza y cocina a fuego alto durante 20 minutos; termina la cocción a fuego bajo por 10 minutos más o hasta que la calabaza esté cocina y la miel haya espesado ligeramente.'),
(98, 1, 'En un tazón mezcla la LECHE CONDENSADA, la CREMA DE LECHE hasta integrar bien y reserva dos cucharadas de la salsa en un tazón aparte, por que la vas a necesitar para decorar.'),
(99, 2, 'En el fondo de 4 copas o recipientes, pon la mezcla cremosa en partes iguales, encima de esta crema coloca el melón, seguido del kiwi, el mango, las rodajas de banano y las fresas todo en partes iguales.'),
(100, 3, 'Por último, baña con la mezcla cremosa que reservaste y sirve.'),
(101, 1, 'Servir suficiente hielo en una jarra, seguido de todas las frutas ya cortadas y sin piel ni semillas.'),
(102, 2, 'Incorporar el vino y dejar macerar el mayor tiempo posible (se recomienda por lo menos 15 minutos)'),
(103, 3, 'Terminar con el refresco y el agua mineral.'),
(104, 4, 'Servir en copas con hielo y frutas.'),
(105, 1, 'En un bol grande, mezclar la harina, levadura, sal y azúcar. Agregar el agua tibia y el huevo. Mezclar bien. Amasar en una superficie enharinada unos 10 minutos, hasta que esté suave y elástica.'),
(106, 2, 'Colocar la masa en un bol engrasado, cubrir con un paño húmedo y dejar reposar en lugar cálido durante 1 hora o hasta que duplique su tamaño. Mientras precalentar el horno a 200°C.'),
(107, 3, 'Dividir la masa en porciones del tamaño deseado y darles forma redonda y plana, similar a un pan de hamburguesa. Espolvorear semillas de ajonjolí por encima de cada pan y colocarlos en una bandeja para hornear.'),
(108, 4, 'Hornear los panes durante unos 15-20 minutos o hasta que estén dorados y cocidos por dentro.'),
(109, 5, 'En una sartén grande calentar el aceite vegetal a fuego medio, agregar la cebolla y el ajo y sofreír hasta que estén tiernos y ligeramente dorados.'),
(110, 6, 'Agregar la carne de cerdo o pollo a la sartén y cocinar hasta que esté bien cocida y dorada. Salpimentar a gusto y retirar de la sartén. Dejarla reposar.'),
(111, 7, 'Cortar los panes de cemita por la mitad y retirar un poco del centro para hacer espacio para el relleno.'),
(112, 8, 'Colocar una capa de queso rallado en la parte inferior del pan. Añadir una porción de carne de cerdo o pollo, luego rodajas de aguacate y hojas de pápalo'),
(113, 9, 'Opcionalmente, agregar salsa de chipotle para darle un toque picante. Cubrir con la parte superior del pan.'),
(114, 1, 'Funde la mantequilla en una sartén.'),
(115, 2, 'Añade el queso, la Leche Evaporada, la sal con cebolla y cocina hasta que espese ligeramente.'),
(116, 3, 'Agrega el fetuccine cocido y escurrido, mezcla hasta integrar por completo y ofrece.'),
(117, 1, 'Mezcla perfectamente el jugo de limón, la sal con ajo en polvo, el aceite de oliva, el sazonador Maggie, la salsa picante, el jitomate y el cilantro.'),
(118, 2, 'Agrega el pescado y mezcla con mucho cuidado para evitar que se deshaga.'),
(119, 3, 'Ofrece el ceviche en frío con las tostaditas.'),
(120, 1, 'En un vaso, mezclar las hojitas de menta con el jugo de limón y el azúcar. Agregar el ron junto con los cubos de hielo. Luego, echar el agua mineral y revolver. Decorar con una ramita de menta y una rodaja de limón'),
(121, 1, 'Precalienta el horno 200 grados. Incorpora todo en la batidora hasta obtener una mezcla homogénea; sabrás que está lista la masa cuando al tocarla no se pegue en tu mano. Sácala de la batidora y la dejas reposar 20 minutos en un recipiente para que aumente su volumen.'),
(122, 2, 'Enseguida divide la masa, una tercera parte será para hacer los huesos y las bolas de las hojaldras. Cada tira de huesos la harás con ayuda de tus dedos.'),
(123, 3, 'La otra parte será para hacer la base de las hojaldras. La divides en las 50 porciones y boleas cada una, en forma redonda sin dejar huecos ni grietas para que la hojaldra salga pareja.'),
(124, 4, 'Les colocas los huesos y las dejas reposar otros 15 minutos para que fermenten y aumenten nuevamente su volumen.'),
(125, 5, 'Después las barnizas con huevo, las espolvoreas con ajonjolí blanco tostado y las horneas a 180°C (se baja la temperatura del horno) por 12 minutos. Al sacarlas del horno debes dejarlas enfriar sobre una rejilla.'),
(126, 1, 'Caliente 1 taza de manteca de cerdo y fría los chiles uno por uno (reserve la manteca restante para freír la salsa). Póngalos en una cazuela con 2 litros de caldo de pollo y hiérvalos hasta que los chiles estén muy suaves y casi deshaciéndose (20 minutos aproximadamente). Retírelos del fuego y deje enfriar.'),
(127, 2, 'Licue la cuarta parte de los chiles con 2 tazas de caldo de pollo hasta obtener una textura muy tersa, de tal manera que al colarlo no quede nada atrapado en el colador. Repita este paso con las otras tres porciones de los chiles restantes, aumentando 2 tazas de caldo de pollo cada vez.'),
(128, 3, 'Caliente, en la olla en la que se hará el mole, la manteca reservada. Deje que humee ligeramente y fría el licuado de los chiles, deberá quedar bien frito e incluso espeso. Espere hasta poder ver el fondo de la olla al mover la salsa con una cuchara (½ hora aproximadamente). Deje sobre el fuego.'),
(129, 4, 'En un sartén a fuego medio, caliente 2 cucharadas de manteca y fría las almendras hasta que se doren ligeramente. Añada los cacahuates y la nuez, y cuando éstos se doren agregue las pepitas de calabaza. Baje el fuego y mueva constantemente. Cuando la pepita se haya inflado integre el ajonjolí y continúe friendo \r\n		hasta que todos los ingredientes estén dorados. Retire del fuego y deje enfriar. Licue todos los ingredientes con 3 tazas de caldo de pollo hasta obtener una salsa muy tersa que no sea necesario colar. Vierta el licuado en la salsa del mole, mezcle y mueva constantemente.'),
(130, 5, 'Caliente ½ taza de manteca a fuego alto y fría el tomate y el jitomate; una vez fritos, baje el fuego y cueza hasta que estén totalmente desbaratados y hayan tomado una consistencia casi de puré (½ hora aproximadamente). Añada el plátano frito y las pasitas, cueza por 15 minutos más y retire del fuego. Deje enfriar la mezcla para poder licuarla.'),
(131, 6, 'Licue la mitad de la mezcla con 2 tazas de caldo hasta que quede una salsa muy tersa que al pasarla por el colador no queden residuos; reserve. Repita este paso con la otra mitad de la mezcla y 2 tazas de caldo de pollo. Añada este licuado al mole moviendo constantemente.'),
(132, 7, 'Licue los clavos, las pimientas, el comino, el anís, la canela, el tomillo, el orégano, los ajos y la cebolla con 2 tazas de caldo de pollo hasta que obtenga una mezcla muy tersa. Cuele y añada al mole.'),
(133, 8, 'Continúe la cocción a fuego lento durante ½ hora, sin dejar de mover para que no se pegue en el fondo; añada la sal, mezcle y siga cociendo.'),
(134, 9, 'Licue el bolillo y las tortillas con 2 tazas de caldo de pollo hasta que obtenga una mezcla tersa; cuele y añada al mole. Continúe la cocción por 10 minutos más.'),
(135, 10, 'Rompa las tablillas de chocolate y añádalas al mole junto con el azúcar. Mezcle bien y cueza durante 20 minutos más. (En este punto la salsa debe estar espesa. Si estuviera muy aguada no importa, pues todavía va a reducir. En caso de que esté muy espesa, añada un poco de caldo.) Retire el mole del fuego cuando empiecen a flotar en la superficie \r\n			grandes vetas o manchas de grasa; esto es señal de que la salsa está totalmente cocida.'),
(136, 11, 'Finalmente pruebe de sal y azúcar, ajuste la sazón si es necesario.'),
(137, 12, 'El día que servirá el mole, cueza en una olla grande el pollo con agua, los ajos, la cebolla y la sal. Con una espumadera o cuchara retire la espuma que flota en la superficie del caldo mientras se cuece el pollo.'),
(138, 13, 'Cuando esté totalmente cocido y suave, deseche el ajo y la cebolla y resérvelo dentro del caldo para recalentarlo justo antes de servir.'),
(139, 14, 'Si desea, puede añadir el pollo cocido al mole o servir las piezas de pollo bañadas con él. Decore la superficie del mole poblano con una pizca de ajonjolí.'),
(140, 1, 'Prepara el café espresso: Utiliza una máquina de espresso o prepara un café bien concentrado. Este será la base de tu Carajillo.'),
(141, 2, 'Añade el licor: En una taza o vaso resistente al calor, vierte los 50 ml de licor. Si decides hacer un Carajillo frío, añade hielo en este paso.'),
(142, 3, 'Mezcla el café con el licor: Vierte el café caliente sobre el licor. Si prefieres tu Carajillo frío, puedes agitar la mezcla en una coctelera para enfriarla uniformemente.'),
(143, 4, 'Endulza a tu gusto: Si deseas, añade una cucharadita de azúcar y mezcla bien hasta que se disuelva completamente.'),
(144, 5, 'Sirve y disfruta: Tu Carajillo está listo para ser disfrutado. Puedes decorarlo con una ramita de canela o una rodaja de limón si buscas un toque extra de sabor.'),
(145, 1, 'Pela cada una de las papas y corta en bastones de 1 cm x 1 cm de ancho, con el mismo largo de la papa. Las papas tienen que ser casi del mismo tamaño para que al momento freírlas, \r\n		estas requieran el mismo tiempo de cocción. Coloca las papas en agua al momento de cortarlas para que no se oxiden.'),
(146, 2, 'Retira las papas del agua y seca muy bien.'),
(147, 3, 'Mezcla la harina, el ajo en polvo y la sal en un bowl. Agrega la papas a la mezcla y cúbrelas muy bien. Quita el exceso de harina.'),
(148, 4, 'Calienta el aceite vegetal en una olla a fuego medio alto. Para determinar si está bien caliente, agrega un poco de harina y si se forman burbujas, significa que el aceite ya está listo.'),
(149, 5, 'Agrega un puño de papas espolvoreadas con harina y fríe de 10 a 12 minutos. Cuando las papas estén doradas, retira y coloca en un plato con papel absorbente. Inmediatamente después, espolvorea con un poco de sal.'),
(150, 1, 'Coloca el maíz en una olla grande junto con la cebolla, cabeza de ajo, laurel, tomillo, mejorana y orégano. Agrega 5 litros de agua y calienta a fuego alto hasta que empiece a hervir, reduce el fuego a medio, tapa y cocina hasta que \r\n		el maíz reviente (puede tomar de 30 minutos a 1 hora).'),
(151, 2, 'Enjuaga muy bien la carne y agrégala a la olla con el maíz ya reventado. A este punto (no antes) puedes agregar sal. Reduce el fuego a bajo, tapa y cocina, retirando la espuma de la superficie de vez en cuando, hasta que la carne esté suave, pero firme, aproximadamente 2 horas.'),
(152, 3, 'Saca toda la carne de la olla y corta en trozos de tamaño regular, retirando los huesos de la manita de puerco. Desecha la cebolla, ajo y hierbas de olor. Regresa la carne a la olla.'),
(153, 4, 'Rectifica el sazón del pozole y deja que hierva a fuego bajo hasta que la carne esté completamente suave.'),
(154, 5, 'Sirve el pozole con lechuga, rabanitos y cebolla. Agrega jugo de limón y salsa para pozole o chile piquín al gusto. Acompaña con tostadas de maíz.');

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
(1, 'Ensalada Cesar', '../images/ensaladaCesar.jpeg', 60, '2024-09-01 00:00:00', '2024-11-04 17:59:39', 0, 1, 3),
(2, 'Spaghetti Bolognese', '../images/spaghettiBolognesa.jpg', 50, '2024-09-03 00:00:00', '2024-09-30 15:37:46', 0, 2, 2),
(3, 'Pollo al Curry', '../images/pollo_curry.jpeg', 15, '2024-09-05 00:00:00', '2024-09-30 15:38:14', 0, 3, 2),
(4, 'Tacos al Pastor', '../images/tacosPastor.jpeg', 30, '2024-09-07 00:00:00', '2024-10-06 20:23:03', 0, 4, 4),
(5, 'Cheesecake', '../images/cheesecake.jpg', 90, '2024-09-09 00:00:00', '2024-09-14 00:00:00', 0, 5, 1),
(6, 'Sushi', '../images/sushi.jpg', 25, '2024-09-22 19:45:50', '2024-09-22 19:45:50', 0, NULL, 2),
(7, 'Atole', '../images/atole.jpeg', 30, '2024-09-22 19:48:10', '2024-09-22 19:48:10', 0, NULL, 5),
(8, 'Lasagna', '../images/Lasagna.jpg', 50, '2024-09-22 23:29:46', '2024-09-22 23:29:46', 0, NULL, 2),
(9, 'Mil hojas', '../images/milhojas.jpg', 90, '2024-09-22 23:32:49', '2024-09-22 23:32:49', 0, NULL, 1),
(10, 'Poutine', '../images/poutine.jpg', 60, '2024-09-22 23:36:04', '2024-09-22 23:36:04', 0, NULL, 4),
(11, 'Pasta Carbonara', '../images/carbonara.jpg', 45, '2024-09-22 23:39:00', '2024-09-22 23:39:00', 0, NULL, 2),
(12, 'Pollo a la Naranja', '../images/pollonaranja.jpg', 30, '2024-09-22 23:46:02', '2024-09-22 23:46:02', 0, NULL, 2),
(13, 'Spaghetti Pesto', '../images/spaghettipesto.jpeg', 35, '2024-09-22 23:58:04', '2024-09-22 23:58:04', 0, NULL, 2),
(14, 'Mousse de Chocolate', '../images/mousse.jpeg', 20, '2024-09-23 00:02:43', '2024-09-23 00:02:43', 0, NULL, 1),
(15, 'Crema de espinaca', '../images/sopaespinaca.jpg', 15, '2024-09-23 00:04:44', '2024-09-23 00:04:44', 0, NULL, 2),
(16, 'Arepas', '../images/arepa.jpg', 46, '2024-09-23 00:18:24', '2024-09-23 18:13:11', 0, NULL, 4),
(17, 'Ratatouille', '../images/ratatouille.jpg', 25, '2024-09-23 00:19:35', '2024-09-23 00:19:35', 0, NULL, 2),
(18, 'Pastel tres leches', '../images/pasteltresleches.jpg', 45, '2024-09-23 00:26:04', '2024-09-23 00:26:04', 0, NULL, 1),
(19, 'Fettuccine Alfredo', '../images/FettuccineAlfredo.jpg', 35, '2024-09-23 00:27:43', '2024-09-23 00:27:43', 0, NULL, 2),
(20, 'Carlota de Limon', '../images/carlotadelimon.jpg', 25, '2024-09-23 00:52:51', '2024-09-23 00:52:51', 0, NULL, 1),
(21, 'Hamburguesa', '../images/hamburguesa.jpeg', 20, '2024-09-23 01:05:05', '2024-09-23 01:05:05', 0, NULL, 2),
(22, 'Pizza', '../images/pizza.jpg', 20, '2024-09-23 18:10:53', '2024-09-23 18:10:53', 0, NULL, 2),
(23, 'Dulce de calabaza', '../images/dulce de calabaza.jpg', 40, '2024-09-23 18:28:02', '2024-09-23 18:28:02', 0, NULL, 1),
(24, 'Ensalada de fruta', '../images/ensaladadefruta.jpg', 60, '2024-09-30 14:04:14', '2024-09-30 14:04:14', 0, NULL, 1),
(25, 'Clericot', '../images/clericot.jpeg', 10, '2024-10-02 12:05:17', '2024-10-02 12:05:17', 0, NULL, 5),
(26, 'Cemita', '../images/cemita.png', 10, '2024-10-06 14:02:23', '2024-10-06 14:02:23', 0, NULL, 2),
(27, 'Spaghetti Alfredo', '../images/spaghettialfredo.jpeg', 180, '2024-10-06 22:36:51', '2024-10-06 22:36:51', 0, NULL, 2),
(28, 'Ceviche', '../images/ceviche.jpeg', 20, '2024-10-06 22:49:43', '2024-10-06 22:49:43', 0, NULL, 2),
(29, 'Mojito', '../images/mojito.jpg', 1, '2024-10-06 22:54:15', '2024-10-06 22:54:15', 0, NULL, 5),
(30, 'Hojaldra', '../images/hojaldra.jpg', 10, '2024-10-06 23:02:09', '2024-10-06 23:02:09', 0, NULL, 1),
(31, 'Mole Poblano', '../images/mole.jpeg', 111, '2024-10-06 23:04:38', '2024-10-06 23:04:38', 0, NULL, 2),
(32, 'Carajillo', '../images/carajillo.jpg', 222, '2024-10-06 23:15:23', '2024-10-24 11:24:34', 0, NULL, 5),
(33, 'Papas Francesas', '../images/papasfritas.jpg', 5, '2024-10-24 10:24:23', '2024-10-24 11:16:50', 0, NULL, 4),
(34, 'Pozole', '../images/pozole.jpg', 15, '2024-10-24 10:35:28', '2024-10-24 10:35:28', 0, NULL, 2);

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
(1, 1, '8 hojas'),
(1, 20, 'al gusto'),
(1, 27, '1 cucharada sopera'),
(1, 28, '1 cucharada sopera'),
(1, 29, '60 ml'),
(1, 31, 'al gusto'),
(1, 32, '1'),
(1, 33, '1'),
(2, 34, '1 bote'),
(2, 35, '1 cucharada'),
(2, 33, '1 diente'),
(2, 20, 'al gusto'),
(2, 36, 'al gusto'),
(2, 37, 'al gusto'),
(2, 38, 'al gusto'),
(2, 2, '500 gramos'),
(2, 40, '1/2 en zumo'),
(2, 8, '400 gramos'),
(2, 41, 'al gusto'),
(2, 29, 'al gusto'),
(3, 3, '2'),
(3, 42, '1'),
(3, 33, '1 diente'),
(3, 42, '5 gramos'),
(3, 46, '2 gramos'),
(3, 47, '2 gramos'),
(3, 48, '45 ml'),
(3, 38, '2 gramos'),
(3, 49, 'al gusto'),
(3, 50, '200 ml'),
(3, 29, 'al gusto'),
(3, 59, 'al gusto'),
(4, 51, '500 gramos'),
(4, 52, '50 ml'),
(4, 53, '2 cucharadas'),
(4, 54, '3 cucharadas'),
(4, 33, 'en polvo 1 cucharada'),
(4, 41, '1 cucharada'),
(4, 47, '1 cucharada'),
(4, 38, '1 cucharada'),
(4, 49, '1 cucharada'),
(4, 55, '35 ml'),
(4, 56, '1/2'),
(4, 57, '1/2'),
(4, 59, 'al gusto'),
(4, 60, '12'),
(5, 61, 'barra derretida'),
(5, 15, '30 molidas'),
(5, 5, '3 paquetes'),
(5, 62, '1 lata'),
(5, 63, '1 lata'),
(5, 40, '2 su ralladura'),
(5, 40, '2 su jugo'),
(5, 64, '3 sobres'),
(5, 65, '1/4 de taza'),
(6, 70, '100 gramos'),
(6, 66, NULL),
(6, 67, '50 gramos'),
(6, 68, '1'),
(6, 69, '1'),
(6, 55, 'al gusto'),
(6, 35, 'una pizca'),
(6, 38, 'una pizca'),
(7, 71, '36 tazas'),
(7, 72, '1 pieza'),
(7, 73, '350 gramos disuelta en 3 1/2 taza de agua fría'),
(7, 11, '1 taza en polvo granulado'),
(7, 62, '1 lata'),
(7, 74, '1 lata'),
(8, 34, '1 1/2 tazas'),
(8, 75, '2 cucharadas'),
(8, 71, '1/2 taza'),
(8, 76, '1 cubo'),
(8, 82, '3 cucharadas'),
(8, 56, '2 cucharadas picada finamente'),
(8, 33, 'diente picado finamente'),
(8, 8, '600 gramos'),
(8, 77, '2 cucharadas'),
(8, 78, '4 cucharadas'),
(8, 79, '1 cucharada'),
(8, 80, '9'),
(8, 81, '200 gramos'),
(8, 37, '2 ramas'),
(9, 9, '1 kilogramo'),
(9, 83, '2 batidos'),
(9, 35, '1/2 taza'),
(9, 71, '2 1/2 tazas'),
(9, 62, '1 lata'),
(9, 32, '8'),
(9, 84, '1 cucharada'),
(9, 87, '6 cucharadas'),
(9, 85, '2 1/2 tazas'),
(9, 40, '2'),
(9, 71, '2 cucharadas'),
(9, 11, '1/2 barra fundida'),
(10, 10, '10'),
(10, 13, '2 cucharadas'),
(10, 88, '2 tazas'),
(10, 61, '2 cucharadas'),
(10, 88, '250 gramos'),
(10, 38, NULL),
(10, 71, NULL),
(10, 82, NULL),
(11, 2, '400 gramos'),
(11, 90, '150 gramos'),
(11, 32, '4'),
(11, 81, '100 gramos'),
(11, 29, NULL),
(11, 38, NULL),
(11, 91, NULL),
(12, 102, '1 1/2 cucharada'),
(12, 92, '1 cucharada'),
(12, 87, '1 taza'),
(12, 13, '3 tazas'),
(12, 83, '2'),
(12, 74, '1 lata'),
(12, 3, '1.5 kilogramos'),
(12, 93, NULL),
(12, 82, '1 cucharada'),
(12, 43, 'fresco picado finamente'),
(12, 33, '1 cucharada'),
(12, 94, '1/2 cucharada'),
(12, 95, '1/2 taza'),
(12, 96, '1/4 de taza'),
(12, 97, '1 taza'),
(12, 98, '1/4 taza'),
(12, 87, '3 cucharadas disuelta en 1/2 de taza de agua'),
(12, 101, '1 cucharada'),
(12, 99, NULL),
(12, 100, NULL),
(12, 103, '10 ramas'),
(13, 36, '1 1/2 tazas'),
(13, 37, '1/2 manojo'),
(13, 104, '1 cucharadita'),
(13, 102, '1 cucharadita'),
(13, 29, '3 cucharadas'),
(13, 105, '1 Taza'),
(13, 61, '2 cucharadas'),
(13, 63, '1 lata'),
(13, 2, '1 paquete'),
(14, 106, '1 taza'),
(14, 11, '2 barras para mesa'),
(14, 64, '2 sobres hidratada en 1/4 de taza fría y disuelta'),
(14, 63, '1 lata'),
(15, 61, '1 cucharada'),
(15, 56, '1/4 picada finamente'),
(15, 26, '400 gramos'),
(15, 102, '1 envase'),
(15, 29, '1 lata'),
(15, 105, '1 1/2 Taza'),
(15, 61, '1/4 de cucharada'),
(15, 63, '1 cucharada disuelta en 1/2 de taza de agua'),
(16, 13, '1 cucharada'),
(16, 71, '1 1/2 tazas tibia'),
(16, 108, '2 onzas'),
(16, 109, '2 cucharadas'),
(16, 38, '1 pizca'),
(16, 61, NULL),
(17, 12, '2'),
(17, 71, '2 tazas'),
(17, 38, '1/4 de taza en grano'),
(17, 110, '2'),
(17, 111, '3'),
(17, 29, '2 cucharadas'),
(17, 34, '1 1/2 tazas '),
(17, 36, '2 cucharadas finamente picada'),
(17, 38, 'pizcas'),
(17, 91, NULL),
(18, 83, '6 claras'),
(18, 35, '1/2 taza'),
(18, 84, '1 cucharada'),
(18, 32, '6'),
(18, 13, '1 taza'),
(18, 113, '1 cucharada'),
(18, 62, '1 lata '),
(18, 63, '1 lata'),
(18, 74, '1 lata'),
(18, 112, '1/4 taza'),
(18, 106, '2 tazas'),
(18, 85, '3/4 taza'),
(19, 14, '4 tazas'),
(19, 61, '1/4 de taza picada en cubos'),
(19, 114, '1 taza'),
(19, 20, '1/2 taza rallada'),
(19, 37, '2 cucharadas'),
(19, 91, '1 cucharada'),
(20, 62, '1 lata'),
(20, 74, '1 lata'),
(20, 40, '1/4 de taza de zumo colada'),
(20, 15, '30'),
(20, 15, '5 troceadas'),
(20, 40, '1 cortado en rodajas'),
(20, 22, '1 rama'),
(20, 40, '1 su ralladura'),
(21, 8, '500 gramos'),
(21, 82, '4 cucharadas'),
(21, 56, '1 picada finamente'),
(21, 116, '1 cucharada'),
(21, 33, '1 cucharada granulada'),
(21, 38, '1 cucharada'),
(21, 92, '1 cucharada'),
(21, 41, '1 cucharada'),
(21, 115, '2 cucharadas'),
(21, 78, '2 cucharadas'),
(21, 83, '1'),
(22, 13, '2 tazas'),
(22, 117, '1 cucharada'),
(22, 35, '1 cucharada'),
(22, 71, '2/3 taza tibia'),
(22, 82, '2 rociadas'),
(22, 118, '1 taza'),
(22, 108, '6 onzas'),
(23, 71, '2 1/2 tazas'),
(23, 125, '4 piezas'),
(23, 72, '2 piezas'),
(23, 126, '6'),
(23, 127, '1 pieza'),
(23, 128, '2'),
(23, 17, '1 kilogramo'),
(24, 62, '10 cucharadas'),
(24, 114, '10 cucharadas'),
(24, 18, '1 taza'),
(24, 65, '1 taza'),
(24, 129, '1'),
(24, 130, '1 taza'),
(25, 19, '750 mililitros'),
(25, 120, '355 mililitros'),
(25, 124, '355 mililitros'),
(25, 119, '1'),
(25, 121, '1'),
(25, 65, NULL),
(25, 18, '1/2 taza'),
(25, 122, NULL),
(25, 123, NULL),
(26, 13, '500 gramos'),
(26, 117, '10 gramos'),
(26, 38, '1 cucharada'),
(26, 35, '1 cucharada'),
(26, 71, '250 ml'),
(26, 83, '1'),
(26, 99, NULL),
(26, 4, '500 gramos'),
(26, 56, '1'),
(26, 33, '2 dientes'),
(26, 82, '2 cucharadas'),
(26, 91, NULL),
(26, 131, '200 gramos'),
(26, 68, '1'),
(26, 132, NULL),
(26, 133, NULL),
(27, 61, '1 1/2'),
(27, 20, '250 gramos'),
(27, 74, '1/4 taza'),
(27, 79, '1/2 cucharada'),
(27, 14, '1 paquete'),
(28, 40, '2 piezas'),
(28, 38, '3 cucharadas'),
(28, 29, '5 cucharadas'),
(28, 77, '3/4 Taza'),
(28, 110, '4 piezas'),
(28, 134, '2 cucharadas'),
(28, 59, '1 1/2 taza'),
(28, 21, '4 piezas'),
(28, 135, '24 piezas'),
(29, 35, '1 cucharada'),
(29, 40, '1/2 en jugo'),
(29, 22, NULL),
(29, 136, '1/4 taza'),
(29, 123, '3 cubos'),
(29, 124, '1/2 taza'),
(29, 22, '1 rama'),
(29, 40, '1 rodaja'),
(30, 105, '250 gramos'),
(30, 13, '2 kilos'),
(30, 83, '12 piezas'),
(30, 35, '600 gramos'),
(30, 61, '600 gramos'),
(30, 117, '100 gramos'),
(30, 38, '30 gramos'),
(30, 109, '70 mililitros'),
(30, 137, '5 gramos'),
(31, 138, '1 1/2 tazas'),
(31, 139, '250 gramos'),
(31, 140, '125 gramos'),
(31, 23, '125 gramos'),
(31, 141, '4 litros'),
(31, 138, '2 cucharadas'),
(31, 142, '150 gramos'),
(31, 143, '25 gramos pelados y tostados'),
(31, 145, '50 gramos'),
(31, 144, '1/4 de taza'),
(31, 99, '25 gramos'),
(31, 141, '3 tazas'),
(31, 138, '1/2 taza'),
(31, 146, '1/2 kilogramo'),
(31, 110, '1/2 kilogramo'),
(31, 147, '2/3 taza'),
(31, 152, '4 tazas'),
(31, 141, '5 asados'),
(31, 148, '1 cucharada'),
(31, 91, '5'),
(31, 149, '1 cucharada'),
(31, 127, '1/2 cucharada'),
(31, 72, '1 raja'),
(31, 150, '1/2 cucharada'),
(31, 41, '1 cucharada'),
(31, 33, '12 dientes'),
(31, 56, '1'),
(31, 141, '2 tazas'),
(31, 38, '1 cucharada'),
(31, 151, '1'),
(31, 60, '3'),
(31, 141, '2 tazas'),
(31, 11, '3 tablillas'),
(31, 35, '1 taza'),
(31, 153, '24 piezas'),
(31, 33, '2 cabezas cortadas a la mitad'),
(31, 56, '1'),
(31, 38, '1 1/2 cucharadas'),
(31, 71, '5 litros'),
(31, 99, '1/4 de taza'),
(32, 154, '1 taza'),
(32, 24, '50 ml'),
(32, 35, '1 cucharada'),
(32, 123, NULL),
(33, 10, '10'),
(33, 71, NULL),
(33, 13, NULL),
(33, 33, '1 cucharada en polvo'),
(33, 38, '1 cucharada'),
(33, 82, NULL),
(34, 25, '1 kilogramo'),
(34, 56, '1'),
(34, 33, '1 cabeza'),
(34, 155, '2 hojas'),
(34, 150, '2 ramitas'),
(34, 156, '2 ramitas'),
(34, 41, '2 ramitas'),
(34, 157, '750 gramos'),
(34, 158, '750 gramos'),
(34, 159, '750 gramos'),
(34, 160, '1'),
(34, 38, NULL),
(34, 1, '1/2'),
(34, 161, '10'),
(34, 56, '1'),
(34, 40, '5'),
(34, 162, NULL),
(34, 163, '1 paquete');

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
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(3, 11),
(3, 12),
(3, 13),
(4, 14),
(4, 15),
(4, 16),
(5, 17),
(5, 18),
(5, 19),
(6, 20),
(6, 21),
(6, 22),
(6, 23),
(6, 24),
(7, 25),
(7, 26),
(8, 27),
(8, 28),
(8, 29),
(9, 30),
(9, 31),
(9, 32),
(9, 33),
(10, 34),
(10, 35),
(10, 36),
(10, 37),
(10, 38),
(10, 39),
(10, 40),
(10, 41),
(10, 42),
(10, 43),
(11, 44),
(11, 45),
(11, 46),
(11, 47),
(12, 48),
(12, 49),
(12, 50),
(13, 51),
(13, 52),
(13, 53),
(14, 54),
(14, 55),
(14, 56),
(15, 57),
(15, 58),
(16, 59),
(16, 60),
(16, 61),
(17, 62),
(17, 63),
(17, 64),
(17, 65),
(17, 66),
(17, 67),
(17, 68),
(18, 69),
(18, 70),
(18, 71),
(18, 72),
(19, 73),
(19, 74),
(19, 75),
(19, 76),
(19, 77),
(20, 78),
(20, 79),
(20, 80),
(21, 81),
(21, 82),
(21, 83),
(21, 84),
(22, 85),
(22, 86),
(22, 87),
(22, 88),
(22, 89),
(22, 90),
(22, 91),
(22, 92),
(22, 93),
(22, 94),
(22, 95),
(23, 96),
(23, 97),
(24, 98),
(24, 99),
(24, 100),
(25, 101),
(25, 102),
(25, 103),
(25, 104),
(26, 105),
(26, 106),
(26, 107),
(26, 108),
(26, 109),
(26, 110),
(26, 111),
(26, 112),
(26, 113),
(27, 114),
(27, 115),
(27, 116),
(28, 117),
(28, 118),
(28, 119),
(29, 120),
(30, 121),
(30, 122),
(30, 123),
(30, 124),
(30, 125),
(31, 126),
(31, 127),
(31, 128),
(31, 129),
(31, 130),
(31, 131),
(31, 132),
(31, 133),
(31, 134),
(31, 135),
(31, 136),
(31, 137),
(31, 138),
(31, 139),
(32, 140),
(32, 141),
(32, 142),
(32, 143),
(32, 144),
(33, 145),
(33, 146),
(33, 147),
(33, 148),
(33, 149),
(34, 150),
(34, 151),
(34, 152),
(34, 153),
(34, 154);

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