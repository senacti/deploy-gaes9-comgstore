-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 11-12-2022 a las 19:23:26
-- Versión del servidor: 8.0.21
-- Versión de PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
create database comgstore_django;
use comgstore_django;
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(2, 'Clientes'),
(1, 'Empleados');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(514, 1, 21),
(515, 1, 22),
(516, 1, 23),
(517, 1, 32),
(518, 1, 36),
(519, 1, 38),
(520, 1, 40),
(521, 1, 44),
(522, 1, 45),
(523, 1, 46),
(524, 1, 48),
(525, 1, 52),
(526, 1, 53),
(527, 1, 54),
(528, 1, 55),
(529, 1, 56),
(530, 1, 69),
(531, 1, 70),
(532, 1, 72),
(533, 1, 73),
(534, 1, 74),
(535, 1, 75),
(536, 1, 76),
(537, 2, 1),
(538, 2, 2),
(539, 2, 3),
(540, 2, 4),
(541, 2, 13),
(542, 2, 14),
(543, 2, 16),
(544, 2, 21),
(545, 2, 22),
(546, 2, 23),
(547, 2, 29),
(548, 2, 30),
(549, 2, 31),
(550, 2, 32),
(551, 2, 37),
(552, 2, 38),
(553, 2, 39),
(554, 2, 40),
(555, 2, 45),
(556, 2, 46),
(557, 2, 48),
(558, 2, 50),
(559, 2, 52),
(560, 2, 53),
(561, 2, 54),
(562, 2, 55),
(563, 2, 56),
(564, 2, 57),
(565, 2, 58),
(566, 2, 60),
(567, 2, 73),
(568, 2, 74),
(569, 2, 75),
(570, 2, 76);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Compra', 7, 'add_purchase'),
(26, 'Can change Compra', 7, 'change_purchase'),
(27, 'Can delete Compra', 7, 'delete_purchase'),
(28, 'Can view Compra', 7, 'view_purchase'),
(29, 'Can add Orden', 8, 'add_order'),
(30, 'Can change Orden', 8, 'change_order'),
(31, 'Can delete Orden', 8, 'delete_order'),
(32, 'Can view Orden', 8, 'view_order'),
(33, 'Can add EstadoDomicilio', 9, 'add_statedomicile'),
(34, 'Can change EstadoDomicilio', 9, 'change_statedomicile'),
(35, 'Can delete EstadoDomicilio', 9, 'delete_statedomicile'),
(36, 'Can view EstadoDomicilio', 9, 'view_statedomicile'),
(37, 'Can add Domicilio', 10, 'add_delivery'),
(38, 'Can change Domicilio', 10, 'change_delivery'),
(39, 'Can delete Domicilio', 10, 'delete_delivery'),
(40, 'Can view Domicilio', 10, 'view_delivery'),
(41, 'Can add Proveedor', 11, 'add_supplier'),
(42, 'Can change Proveedor', 11, 'change_supplier'),
(43, 'Can delete Proveedor', 11, 'delete_supplier'),
(44, 'Can view Proveedor', 11, 'view_supplier'),
(45, 'Can add Cliente', 12, 'add_client'),
(46, 'Can change Cliente', 12, 'change_client'),
(47, 'Can delete Cliente', 12, 'delete_client'),
(48, 'Can view Cliente', 12, 'view_client'),
(49, 'Can add Producto', 13, 'add_product'),
(50, 'Can change Producto', 13, 'change_product'),
(51, 'Can delete Producto', 13, 'delete_product'),
(52, 'Can view Producto', 13, 'view_product'),
(53, 'Can add Venta', 14, 'add_sales'),
(54, 'Can change Venta', 14, 'change_sales'),
(55, 'Can delete Venta', 14, 'delete_sales'),
(56, 'Can view Venta', 14, 'view_sales'),
(57, 'Can add Usuario', 15, 'add_profile'),
(58, 'Can change Usuario', 15, 'change_profile'),
(59, 'Can delete Usuario', 15, 'delete_profile'),
(60, 'Can view Usuario', 15, 'view_profile'),
(61, 'Can add Rol', 16, 'add_rol'),
(62, 'Can change Rol', 16, 'change_rol'),
(63, 'Can delete Rol', 16, 'delete_rol'),
(64, 'Can view Rol', 16, 'view_rol'),
(65, 'Can add DetalleCompra', 17, 'add_purchasedetail'),
(66, 'Can change DetalleCompra', 17, 'change_purchasedetail'),
(67, 'Can delete DetalleCompra', 17, 'delete_purchasedetail'),
(68, 'Can view DetalleCompra', 17, 'view_purchasedetail'),
(69, 'Can add Inventario', 18, 'add_inventorymovement'),
(70, 'Can change Inventario', 18, 'change_inventorymovement'),
(71, 'Can delete Inventario', 18, 'delete_inventorymovement'),
(72, 'Can view Inventario', 18, 'view_inventorymovement'),
(73, 'Can add DetalleVenta', 19, 'add_salesdetail'),
(74, 'Can change DetalleVenta', 19, 'change_salesdetail'),
(75, 'Can delete DetalleVenta', 19, 'delete_salesdetail'),
(76, 'Can view DetalleVenta', 19, 'view_salesdetail'),
(77, 'Can add Permiso', 20, 'add_permissions'),
(78, 'Can change Permiso', 20, 'change_permissions'),
(79, 'Can delete Permiso', 20, 'delete_permissions'),
(80, 'Can view Permiso', 20, 'view_permissions'),
(81, 'Can add Cliente', 7, 'add_client'),
(82, 'Can change Cliente', 7, 'change_client'),
(83, 'Can delete Cliente', 7, 'delete_client'),
(84, 'Can view Cliente', 7, 'view_client'),
(85, 'Can add Permiso', 8, 'add_permissions'),
(86, 'Can change Permiso', 8, 'change_permissions'),
(87, 'Can delete Permiso', 8, 'delete_permissions'),
(88, 'Can view Permiso', 8, 'view_permissions'),
(89, 'Can add Producto', 9, 'add_product'),
(90, 'Can change Producto', 9, 'change_product'),
(91, 'Can delete Producto', 9, 'delete_product'),
(92, 'Can view Producto', 9, 'view_product'),
(93, 'Can add Usuario', 10, 'add_profile'),
(94, 'Can change Usuario', 10, 'change_profile'),
(95, 'Can delete Usuario', 10, 'delete_profile'),
(96, 'Can view Usuario', 10, 'view_profile'),
(97, 'Can add Compra', 11, 'add_purchase'),
(98, 'Can change Compra', 11, 'change_purchase'),
(99, 'Can delete Compra', 11, 'delete_purchase'),
(100, 'Can view Compra', 11, 'view_purchase'),
(101, 'Can add Venta', 12, 'add_sales'),
(102, 'Can change Venta', 12, 'change_sales'),
(103, 'Can delete Venta', 12, 'delete_sales'),
(104, 'Can view Venta', 12, 'view_sales'),
(105, 'Can add EstadoDomicilio', 13, 'add_statedomicile'),
(106, 'Can change EstadoDomicilio', 13, 'change_statedomicile'),
(107, 'Can delete EstadoDomicilio', 13, 'delete_statedomicile'),
(108, 'Can view EstadoDomicilio', 13, 'view_statedomicile'),
(109, 'Can add Proveedor', 14, 'add_supplier'),
(110, 'Can change Proveedor', 14, 'change_supplier'),
(111, 'Can delete Proveedor', 14, 'delete_supplier'),
(112, 'Can view Proveedor', 14, 'view_supplier'),
(113, 'Can add DetalleVenta', 15, 'add_salesdetail'),
(114, 'Can change DetalleVenta', 15, 'change_salesdetail'),
(115, 'Can delete DetalleVenta', 15, 'delete_salesdetail'),
(116, 'Can view DetalleVenta', 15, 'view_salesdetail'),
(117, 'Can add Orden', 18, 'add_order'),
(118, 'Can change Orden', 18, 'change_order'),
(119, 'Can delete Orden', 18, 'delete_order'),
(120, 'Can view Orden', 18, 'view_order'),
(121, 'Can add Inventario', 19, 'add_inventorymovement'),
(122, 'Can change Inventario', 19, 'change_inventorymovement'),
(123, 'Can delete Inventario', 19, 'delete_inventorymovement'),
(124, 'Can view Inventario', 19, 'view_inventorymovement'),
(125, 'Can add Domicilio', 20, 'add_delivery'),
(126, 'Can change Domicilio', 20, 'change_delivery'),
(127, 'Can delete Domicilio', 20, 'delete_delivery'),
(128, 'Can view Domicilio', 20, 'view_delivery');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$IW7e3Rekj5ZbDQJWrvJUr6$ggYGD23CvW5VgkFLH7PD3CRRICfwAyQB1rS6TbNxBag=', '2022-12-11 16:57:01.312351', 1, 'admin', 'Juan Pablo', 'Gonzales', 'admin64@gmail.com', 1, 1, '2022-11-11 18:48:54.000000'),
(4, 'pbkdf2_sha256$390000$z9IjkJFmVqRdSYH3hQf20V$0J6GnhanTGrFX9VON5dPPKiGcp4R8xAE+zJauH6xWaw=', '2022-12-10 17:55:15.535724', 0, 'JuanP', 'Juan Pablo', 'Bohorquez', 'juanpablobohorquez2004@gmail.com', 0, 1, '2022-11-11 19:55:48.000000'),
(6, 'pbkdf2_sha256$390000$12B2yobzANdE0ZAULmBxwd$PeQeTZgUOWqXUIaJzYoYJwA2L1ZUU6g1GlWarpUvNTY=', '2022-12-10 18:39:16.313527', 0, 'BrayanB', 'Brayan Sneider', 'Beltran', 'jpbohorquez74@misena.edu.co', 0, 1, '2022-11-11 20:14:07.000000'),
(7, 'pbkdf2_sha256$390000$8GI4PqxBQCH3wEuNZ8dqqe$gHBzKnYRj7ieH21OhEAQgCzlQ/BmVFWFl26rC9IC/v8=', NULL, 0, 'Carlos', 'Carlos Fernando', 'Martinez', 'marthaluciabohorquez2211@gmail.com', 0, 1, '2022-11-14 04:12:00.000000'),
(9, 'pbkdf2_sha256$390000$FrdfgncyS0O419aqFOKd4e$SbVjqW7zV7NTbnendN66tUeY8Y0J671GkNHsvhCL71g=', NULL, 0, 'JulianB', 'Julian', 'Benavidez', 'plataholguin109@gmail.com', 0, 0, '2022-12-05 21:36:06.540417');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(19, 4, 2),
(20, 6, 1),
(22, 9, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_user_user_permissions`
--

INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`) VALUES
(721, 1, 1),
(722, 1, 2),
(723, 1, 3),
(724, 1, 4),
(725, 1, 5),
(726, 1, 6),
(727, 1, 7),
(728, 1, 8),
(729, 1, 9),
(730, 1, 10),
(731, 1, 11),
(732, 1, 12),
(733, 1, 13),
(734, 1, 14),
(735, 1, 15),
(736, 1, 16),
(737, 1, 17),
(738, 1, 18),
(739, 1, 19),
(740, 1, 20),
(741, 1, 21),
(742, 1, 22),
(743, 1, 23),
(744, 1, 24),
(745, 1, 25),
(746, 1, 26),
(747, 1, 27),
(748, 1, 28),
(749, 1, 29),
(750, 1, 30),
(751, 1, 31),
(752, 1, 32),
(753, 1, 33),
(754, 1, 34),
(755, 1, 35),
(756, 1, 36),
(757, 1, 37),
(758, 1, 38),
(759, 1, 39),
(760, 1, 40),
(761, 1, 41),
(762, 1, 42),
(763, 1, 43),
(764, 1, 44),
(765, 1, 45),
(766, 1, 46),
(767, 1, 47),
(768, 1, 48),
(769, 1, 49),
(770, 1, 50),
(771, 1, 51),
(772, 1, 52),
(773, 1, 53),
(774, 1, 54),
(775, 1, 55),
(776, 1, 56),
(777, 1, 57),
(778, 1, 58),
(779, 1, 59),
(780, 1, 60),
(781, 1, 61),
(782, 1, 62),
(783, 1, 63),
(784, 1, 64),
(785, 1, 65),
(786, 1, 66),
(787, 1, 67),
(788, 1, 68),
(789, 1, 69),
(790, 1, 70),
(791, 1, 71),
(792, 1, 72),
(793, 1, 73),
(794, 1, 74),
(795, 1, 75),
(796, 1, 76),
(797, 1, 77),
(798, 1, 78),
(799, 1, 79),
(800, 1, 80);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `cod_client` int NOT NULL,
  `client_name` varchar(20) NOT NULL,
  `client_address` varchar(50) NOT NULL,
  `id_user_id` int NOT NULL,
  PRIMARY KEY (`cod_client`),
  KEY `cliente_id_user_id_6013e780_fk_usuario_id_profile` (`id_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cod_client`, `client_name`, `client_address`, `id_user_id`) VALUES
(1, 'Juan Pablo', 'Cll 11 # 34 - 78', 1045243);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
  `cod_purchase` int NOT NULL AUTO_INCREMENT,
  `total_value` decimal(8,2) NOT NULL,
  `date_purchase` date NOT NULL,
  `id_user_id` int NOT NULL,
  `supplier_id` int DEFAULT NULL,
  PRIMARY KEY (`cod_purchase`),
  KEY `compra_id_user_id_ca50bbd4_fk_usuario_id_profile` (`id_user_id`),
  KEY `compra_supplier_id_546e2c3c_fk_proveedor_cod_supplier` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`cod_purchase`, `total_value`, `date_purchase`, `id_user_id`, `supplier_id`) VALUES
(13, '57500.00', '2022-12-05', 1212121212, 1243232),
(14, '0.00', '2022-12-10', 1212121212, 1243232),
(15, '23000.00', '2022-12-10', 1212121212, 1243232);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
CREATE TABLE IF NOT EXISTS `detalle_compra` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `product_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detalle_compra_product_id_cfeabb94_fk_producto_cod_product` (`product_id`),
  KEY `detalle_compra_purchase_id_d425c2af_fk_compra_cod_purchase` (`purchase_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id`, `quantity`, `product_id`, `purchase_id`, `subtotal`) VALUES
(17, 2, 2, 13, '20000.00'),
(18, 5, 3, 13, '37500.00'),
(19, 2, 2, 15, '20000.00'),
(20, 2, 4, 15, '3000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `product_id` int NOT NULL,
  `sale_id` int NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detalle_venta_product_id_55a4ef95_fk_producto_cod_product` (`product_id`),
  KEY `detalle_venta_sale_id_41a62fc9_fk_venta_cod_sale` (`sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id`, `quantity`, `product_id`, `sale_id`, `subtotal`) VALUES
(22, 3, 3, 10, '45000.00'),
(23, 5, 1, 10, '4000.00'),
(27, 1, 2, 14, '0.00'),
(28, 1, 3, 14, '0.00'),
(29, 3, 2, 15, '60000.00'),
(30, 1, 4, 15, '3000.00'),
(31, 2, 5, 15, '10000.00'),
(32, 1, 2, 16, '20000.00'),
(33, 5, 3, 16, '75000.00'),
(34, 1, 6, 16, '3000.00'),
(35, 1, 7, 16, '5000.00'),
(36, 4, 6, 17, '12000.00'),
(37, 1, 7, 17, '5000.00'),
(38, 2, 7, 18, '10000.00'),
(39, 3, 6, 18, '9000.00'),
(40, 4, 5, 19, '20000.00'),
(41, 1, 2, 21, '0.00'),
(42, 1, 6, 21, '0.00'),
(43, 1, 2, 23, '20000.00'),
(44, 1, 6, 23, '3000.00'),
(45, 1, 2, 24, '20000.00'),
(46, 3, 3, 24, '45000.00'),
(47, 1, 3, 25, '0.00'),
(48, 4, 1, 26, '0.00'),
(49, 2, 3, 26, '0.00'),
(50, 4, 1, 27, '3200.00'),
(51, 1, 2, 27, '20000.00'),
(52, 2, 6, 27, '6000.00'),
(53, 1, 4, 30, '3000.00'),
(54, 3, 2, 30, '60000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`)
) ;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2022-11-11 18:50:03.417000', '1', 'Chocolatina', 1, '[{\"added\": {}}]', 13, 1),
(2, '2022-11-11 18:51:21.625000', '1', 'Administrador', 1, '[{\"added\": {}}]', 20, 1),
(3, '2022-11-11 18:51:27.530000', '1', 'Administrador', 1, '[{\"added\": {}}]', 16, 1),
(4, '2022-11-11 18:51:33.683000', '1212121212', 'Profile object (1212121212)', 1, '[{\"added\": {}}]', 15, 1),
(5, '2022-11-11 18:54:56.910000', '2', 'Aceite', 1, '[{\"added\": {}}]', 13, 1),
(6, '2022-11-11 19:08:06.884000', '3', 'Huevos', 1, '[{\"added\": {}}]', 13, 1),
(7, '2022-11-11 19:09:07.342000', '4', 'AtÀn', 1, '[{\"added\": {}}]', 13, 1),
(8, '2022-11-11 19:09:57.528000', '5', 'Pasta', 1, '[{\"added\": {}}]', 13, 1),
(9, '2022-11-11 19:10:34.620000', '6', 'Avena', 1, '[{\"added\": {}}]', 13, 1),
(10, '2022-11-11 19:11:37.471000', '7', 'Cocacola', 1, '[{\"added\": {}}]', 13, 1),
(11, '2022-11-11 19:20:35.889000', '1', 'Chocolatina', 2, '[{\"changed\": {\"fields\": [\"Precio del producto\"]}}]', 13, 1),
(12, '2022-11-11 19:50:58.169000', '2', 'Empleado', 1, '[{\"added\": {}}]', 16, 1),
(13, '2022-11-11 19:51:12.826000', '3', 'Cliente', 1, '[{\"added\": {}}]', 16, 1),
(14, '2022-11-11 19:55:21.821000', '2', 'JuanP', 3, '', 4, 1),
(15, '2022-11-11 20:58:20.008000', '1', 'Empleados', 1, '[{\"added\": {}}]', 3, 1),
(16, '2022-11-11 20:58:35.415000', '6', 'BrayanB', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(17, '2022-11-11 20:58:53.808000', '6', 'BrayanB', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(18, '2022-11-11 20:59:02.970000', '6', 'BrayanB', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(19, '2022-11-11 21:01:18.111000', '1', 'Empleados', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(20, '2022-11-11 21:04:30.709000', '1', 'Empleados', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(21, '2022-11-11 21:18:28.914000', '2', 'Clientes', 1, '[{\"added\": {}}]', 3, 1),
(22, '2022-11-11 21:19:09.449000', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(23, '2022-11-11 21:25:33.539000', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 4, 1),
(24, '2022-11-11 21:25:37.063000', '1', 'admin', 2, '[]', 4, 1),
(25, '2022-11-11 21:28:54.561000', '6', 'BrayanB', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 4, 1),
(26, '2022-11-11 21:30:15.622000', '4', 'JuanP', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 4, 1),
(27, '2022-11-11 21:30:16.779000', '4', 'JuanP', 2, '[]', 4, 1),
(28, '2022-11-11 21:31:19.030000', '6', 'Avena', 2, '[{\"changed\": {\"fields\": [\"Precio del producto\"]}}]', 13, 1),
(29, '2022-11-11 21:37:29.436000', '2', '2', 3, '', 8, 1),
(30, '2022-11-11 21:56:44.660000', '1', 'Empleados', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(31, '2022-11-11 21:57:27.030000', '2', 'Clientes', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(32, '2022-11-11 21:58:15.584000', '1', 'Empleados', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(33, '2022-11-11 21:58:41.546000', '1', '1', 3, '', 7, 1),
(34, '2022-11-11 21:58:41.549000', '2', '2', 3, '', 7, 1),
(35, '2022-11-11 21:58:41.550000', '3', '3', 3, '', 7, 1),
(36, '2022-11-11 21:59:25.428000', '2', '2', 3, '', 14, 1),
(37, '2022-11-11 21:59:25.430000', '3', '3', 3, '', 14, 1),
(38, '2022-11-11 21:59:25.432000', '4', '4', 3, '', 14, 1),
(39, '2022-11-11 21:59:25.433000', '5', '5', 3, '', 14, 1),
(40, '2022-11-11 21:59:25.435000', '6', '6', 3, '', 14, 1),
(41, '2022-11-11 21:59:25.439000', '7', '7', 3, '', 14, 1),
(42, '2022-11-11 21:59:25.440000', '8', '8', 3, '', 14, 1),
(43, '2022-11-11 21:59:25.442000', '9', '9', 3, '', 14, 1),
(44, '2022-11-11 21:59:25.443000', '10', '10', 3, '', 14, 1),
(45, '2022-11-11 21:59:25.445000', '11', '11', 3, '', 14, 1),
(46, '2022-11-11 21:59:25.446000', '12', '12', 3, '', 14, 1),
(47, '2022-11-11 21:59:25.448000', '13', '13', 3, '', 14, 1),
(48, '2022-11-11 21:59:25.449000', '14', '14', 3, '', 14, 1),
(49, '2022-11-11 21:59:32.393000', '2', 'Clientes', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(50, '2022-11-11 22:00:18.973000', '5', 'pepe123', 3, '', 4, 1),
(54, '2022-11-11 23:06:50.737000', '4', 'JuanP', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(55, '2022-11-11 23:12:35.462000', '6', 'BrayanB', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(56, '2022-11-11 23:24:34.220000', '6', 'BrayanB', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(57, '2022-11-11 23:27:10.303000', '6', 'BrayanB', 2, '[]', 4, 1),
(58, '2022-11-11 23:41:41.288000', '1', 'Empleados', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(59, '2022-11-11 23:53:18.004000', '4', '4', 3, '', 7, 1),
(60, '2022-11-11 23:53:18.007000', '5', '5', 3, '', 7, 1),
(61, '2022-11-11 23:53:27.803000', '4', '4', 3, '', 8, 1),
(62, '2022-11-11 23:53:48.265000', '16', '16', 3, '', 14, 1),
(63, '2022-11-11 23:53:48.268000', '17', '17', 3, '', 14, 1),
(64, '2022-11-12 01:15:56.174000', '18', '18', 3, '', 14, 1),
(65, '2022-11-12 01:16:16.251000', '6', '6', 3, '', 7, 1),
(66, '2022-11-12 01:16:16.253000', '7', '7', 3, '', 7, 1),
(67, '2022-11-13 02:41:50.220998', '7', 'Cocacola', 2, '[{\"changed\": {\"fields\": [\"Unidades_stock\"]}}]', 9, 1),
(68, '2022-11-13 03:24:10.626346', '1', 'Juan Pablo', 1, '[{\"added\": {}}]', 7, 1),
(69, '2022-11-13 04:20:28.124545', '1', '1', 3, '', 12, 1),
(70, '2022-11-13 21:35:00.316312', '3', '3', 3, '', 11, 1),
(71, '2022-11-13 21:35:00.364707', '4', '4', 3, '', 11, 1),
(72, '2022-11-13 21:38:06.027380', '6', '6', 3, '', 11, 1),
(73, '2022-11-14 00:53:39.694132', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1),
(74, '2022-11-14 01:12:08.236531', '1', 'Sin entregar', 1, '[{\"added\": {}}]', 13, 1),
(75, '2022-11-14 01:12:23.104263', '1', 'Entregado', 2, '[{\"changed\": {\"fields\": [\"Estado del Domicilio\"]}}]', 13, 1),
(76, '2022-11-14 01:12:32.269411', '2', 'Sin entregar', 1, '[{\"added\": {}}]', 13, 1),
(77, '2022-11-14 16:18:35.013832', '1', '1', 3, '', 20, 1),
(78, '2022-11-14 16:19:06.128523', '1', '1', 3, '', 18, 1),
(79, '2022-11-14 16:19:06.223607', '2', '2', 3, '', 18, 1),
(80, '2022-11-14 16:19:54.091762', '8', 'Angel', 3, '', 4, 1),
(81, '2022-11-14 16:20:32.340776', '2', '2', 3, '', 12, 1),
(82, '2022-11-14 16:20:32.568988', '3', '3', 3, '', 12, 1),
(83, '2022-11-14 16:20:32.605301', '4', '4', 3, '', 12, 1),
(84, '2022-11-14 16:20:32.698655', '5', '5', 3, '', 12, 1),
(85, '2022-11-14 16:20:32.734653', '6', '6', 3, '', 12, 1),
(86, '2022-11-14 16:20:41.388726', '7', '7', 3, '', 12, 1),
(87, '2022-11-14 16:20:41.454687', '8', '8', 3, '', 12, 1),
(88, '2022-11-14 16:20:41.479717', '9', '9', 3, '', 12, 1),
(89, '2022-11-14 16:21:12.823070', '1', '1', 3, '', 11, 1),
(90, '2022-11-14 16:21:12.956073', '2', '2', 3, '', 11, 1),
(91, '2022-11-14 16:21:13.054080', '5', '5', 3, '', 11, 1),
(92, '2022-11-14 16:21:13.148063', '7', '7', 3, '', 11, 1),
(93, '2022-11-20 23:56:29.098603', '2', '2', 2, '[{\"changed\": {\"fields\": [\"State domicile\"]}}]', 20, 1),
(94, '2022-11-21 00:07:59.675453', '2', '2', 2, '[{\"changed\": {\"fields\": [\"State domicile\"]}}]', 20, 1),
(95, '2022-11-24 03:40:02.211200', '7', 'Carlos', 2, '[{\"changed\": {\"fields\": [\"Email address\"]}}]', 4, 1),
(96, '2022-11-24 03:57:44.370109', '7', 'Carlos', 2, '[{\"changed\": {\"fields\": [\"Email address\"]}}]', 4, 1),
(97, '2022-12-05 21:48:22.902908', '1', 'Chocolatina', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(98, '2022-12-05 21:48:22.982896', '2', 'Aceite', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(99, '2022-12-05 21:48:23.106000', '3', 'Huevos', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(100, '2022-12-05 21:48:23.155519', '4', 'AtÀn', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(101, '2022-12-05 21:48:23.204791', '5', 'Pasta', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(102, '2022-12-05 21:48:35.853471', '6', 'Avena', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(103, '2022-12-05 21:48:35.927481', '7', 'Cocacola', 2, '[{\"changed\": {\"fields\": [\"Precio del proveedor\"]}}]', 9, 1),
(104, '2022-12-05 21:48:50.569123', '8', '8', 3, '', 11, 1),
(105, '2022-12-05 21:48:50.602451', '9', '9', 3, '', 11, 1),
(106, '2022-12-05 21:48:50.648849', '10', '10', 3, '', 11, 1),
(107, '2022-12-05 21:48:50.673683', '11', '11', 3, '', 11, 1),
(108, '2022-12-05 21:48:50.712928', '12', '12', 3, '', 11, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'core', 'client'),
(20, 'core', 'delivery'),
(19, 'core', 'inventorymovement'),
(18, 'core', 'order'),
(8, 'core', 'permissions'),
(9, 'core', 'product'),
(10, 'core', 'profile'),
(11, 'core', 'purchase'),
(17, 'core', 'purchasedetail'),
(16, 'core', 'rol'),
(12, 'core', 'sales'),
(15, 'core', 'salesdetail'),
(13, 'core', 'statedomicile'),
(14, 'core', 'supplier'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-11-12 00:52:43.107456'),
(2, 'auth', '0001_initial', '2022-11-12 00:52:56.618581'),
(3, 'admin', '0001_initial', '2022-11-12 00:52:59.876264'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-11-12 00:52:59.925277'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-11-12 00:52:59.990281'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-11-12 00:53:02.175737'),
(7, 'auth', '0002_alter_permission_name_max_length', '2022-11-12 00:53:03.531251'),
(8, 'auth', '0003_alter_user_email_max_length', '2022-11-12 00:53:03.681243'),
(9, 'auth', '0004_alter_user_username_opts', '2022-11-12 00:53:03.739244'),
(10, 'auth', '0005_alter_user_last_login_null', '2022-11-12 00:53:04.830788'),
(11, 'auth', '0006_require_contenttypes_0002', '2022-11-12 00:53:04.873815'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2022-11-12 00:53:04.933784'),
(13, 'auth', '0008_alter_user_username_max_length', '2022-11-12 00:53:06.087115'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2022-11-12 00:53:07.230338'),
(15, 'auth', '0010_alter_group_name_max_length', '2022-11-12 00:53:07.498094'),
(16, 'auth', '0011_update_proxy_permissions', '2022-11-12 00:53:07.644097'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2022-11-12 00:53:08.902197'),
(18, 'core', '0001_initial', '2022-11-12 00:53:48.496690'),
(19, 'sessions', '0001_initial', '2022-11-12 00:53:49.563024'),
(20, 'core', '0002_alter_delivery_cod_delivery_and_more', '2022-11-14 01:16:46.670429'),
(21, 'core', '0003_salesdetail_subtotal', '2022-11-27 21:11:29.158025'),
(22, 'core', '0004_purchasedetail_subtotal', '2022-12-04 01:51:56.917451'),
(23, 'core', '0005_product_price_supplier', '2022-12-05 21:25:32.131629'),
(24, 'core', '0006_alter_product_price_product', '2022-12-05 21:25:32.184625');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('56tmr4c22iiagb14irlezsoyr7agx470', '.eJxVjsEOgjAQRP-lZ9O40O5aj975BrLbbQU1NKFwMv67kHDQ67yZl3mbntdl6Nea5n5UczVgTr-ZcHymaQf64OlebCzTMo9i94o9aLVd0fS6Hd0_wcB12NaBPGZQUNd4pMCYqY3kwQUMoJnPsYXouUGXBAEgkuZEJF4liZBs0v0eXD5fkJA56g:1oteFB:n2JOV6unNMsVqH7MjsMEZY_Tvg2AO0mGMOduMYhfDmg', '2022-11-13 00:19:33.968000'),
('5hfmovakpponzgzyzgi8fk0xpcol860g', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1ouJDb:Iajs3kwOgQ_L8XRqL7GtAmHqPTnGmPLxD7SxPJkIiF4', '2022-11-14 20:04:39.340573'),
('f2ww52a7l9ji0m6hdk6tlrniitiylgw8', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1p4PdN:LgdnAn3tDEAGzROQX2WAlqxODzjcR0YemP3YRexgeWs', '2022-12-12 16:57:01.488358'),
('gbe4o2acz1hyopvndooezq50zayciu39', '.eJxVjEEOwiAQRe_C2pAKlTIu3fcMZJgZpGogKe3KeHfbpAvd_vfef6uA65LD2mQOE6urcur0u0Wkp5Qd8APLvWqqZZmnqHdFH7TpsbK8bof7d5Cx5a0-OzbEwMYRi00Gk3iAjpmMvQhGoCH2bpMEhxjZWybvO2cBepPAW_X5AhaCOLI:1otdt5:aDehfedPL1Y0uZ0soErm-QbWOIwkiETYG0KmCp-5w-E', '2022-11-12 23:56:43.724000'),
('gob67b07snacu4dyzmiw9ukpqxf4gc6x', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1owsMw:aCrP6BRUqDx3h3QNZND4bVZD8IlYI3Ai5RPPcRicydQ', '2022-11-21 22:00:54.639205'),
('hfak71f01v91ywtseue2zo456ursw7gf', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1oy34y:NL0ecHH8WWvsH65b2oKmB7eLSVfrYIlVgcvn_8mCBUc', '2022-11-25 03:39:12.110588'),
('ho00qks4g31nnwlf22zt7y4ysi1fxxp6', '.eJxVjjsOgzAQRO_iGlkbm8-SMn3OgPZjAgmyJQxVlLsHJBdJM8XMm9G8zUD7Ng17Duswq7ma2lS_HpO8QjwDfVJ8JCspbuvM9kRsSbO9Jw3LrbB_AxPl6Wg3PdaM0qH3o3ovrgcShEOJpQPh0NYjKl8YkRoB5wL4sW21Bwjs_DF63nNYmbRqORv3Zfl8AXU_P4Y:1p2mEE:kMzYCR3pp794Zj8AMGVxuMqE7AexR37yqgJZ2i7R-yo', '2022-12-08 04:40:18.422411'),
('j8lsclu2hr0bpxt0zeu3bqy5b2p3c2nw', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1otf7b:LbBY245ASzC10Pihulo9as33D9NDT2mwBgreFT5-jnI', '2022-11-13 01:15:47.935000'),
('m55wilqqpkusiwxqf5j7fl2dgordrd8n', '.eJxVjsEOwiAQRP-FsyFuC2zw6N1vaHZZsNUGklJOjf9um_Sg13kzL7Opgdo6Dq3GZZhE3RSoy2_GFN4xH0BelJ9Fh5LXZWJ9VPRJq34UifP97P4JRqrjvvZoXQIBMZ116Mkl7ANaMN55kETX0EOw1DkT2QFAQEkRka1wZEbepce93Ob58wUHujs8:1p1ebt:n36i8BJfZnG-a_T77GoBTY6A1gC7civMYBxxYTLDxuk', '2022-12-05 02:20:05.268541'),
('n7002i0eteepuk4yto53p0d9485jimlv', '.eJxVjsEOgjAQRP-lZ9LQZWldj975BrJlq6CkTQqcjP9um3DQ68ybl3mrkY99Ho8t5HERdVVGNb-Z5-kVYi3kyfGR9JTinhevK6LPdtNDkrDeTvZPMPM2lzVJ21rAuw1kqQfnxRhygp0VZwg73we20wWK0QQkEoTeARTCM6OFIq33sFEpy_k1Huv6-QL_sD51:1otZT2:6u5sNXte6wfTdZtZFSF8Tmp320XdaSX-FD7dYToAR-U', '2022-11-12 19:13:32.630000'),
('pasxwbuwu0mbnhp275pxus3ruchj3pa0', '.eJxVjEEOwiAQRe_C2pAKlTIu3fcMZJgZpGogKe3KeHfbpAvd_vfef6uA65LD2mQOE6urcur0u0Wkp5Qd8APLvWqqZZmnqHdFH7TpsbK8bof7d5Cx5a0-OzbEwMYRi00Gk3iAjpmMvQhGoCH2bpMEhxjZWybvO2cBepPAW_X5AhaCOLI:1oueVT:geUwFbJmbZV3042NHhLezuTV-9zXbQgcCYyX2FL1_JA', '2022-11-15 18:48:31.730320'),
('rta1pgc3s9uaeq0yc4kvpgmxthftpdm6', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1p0Qpb:vzn6TZos-tW1C5nhHN6SGBAhKqQJ0IgDymFyT0pp-Jc', '2022-12-01 17:25:11.295829'),
('twuw8sz01818u4a6c9p9vwiihqe4vasi', '.eJxVjsEOwiAQRP-FsyFuC2zw6N1vILssSNXQpLQn479bkh70Om_mZd4q0LaWsLW0hEnURYE6_WZM8ZlqB_Kgep91nOu6TKx7RR-06dss6XU9un-CQq3sa4_WZRAQM1iHnlzGMaIF450HyXSOI0RLgzOJHQBElJwQ2QonZuRd2u_h5wtW9zm4:1ote9e:vpwhLNdAbofH_sOh7qMvl9OSrZVCzcG4Gv-FXQGNEoE', '2022-11-13 00:13:50.840000'),
('u4802maf7nsf4qg5kg8plc81723rwodm', '.eJxVjsEOwiAQRP-FsyFuC2zw6N1vaHZZsNUGklJOjf9um_Sg13kzL7Opgdo6Dq3GZZhE3RSoy2_GFN4xH0BelJ9Fh5LXZWJ9VPRJq34UifP97P4JRqrjvvZoXQIBMZ116Mkl7ANaMN55kETX0EOw1DkT2QFAQEkRka1wZEbepce93Ob58wUHujs8:1owurC:ic9Vy7Y1kDnxH0uEjIAwXcntOW2bLqUVphYNlKyjK8E', '2022-11-22 00:40:18.585539'),
('vl0odyr5e7kgoky4nraxm3ey5ks2d2mt', '.eJxVjEEOwiAQRe_C2hCnBSa4dO8ZyAwDUjWQlHbVeHdt0oVu_3vvbyrQupSw9jSHSdRFgTr9bkzxmeoO5EH13nRsdZkn1ruiD9r1rUl6XQ_376BQL9_ao3UZBMQM1qEnl3GMaMF450EyneMI0dLgTGIHABElJ0S2wokZWb0_yaI4Cg:1oyyR4:2asatH_v29EQDpIBVggy0D_hFHqV-wsdVi6EhAU0oho', '2022-11-27 16:53:50.140962'),
('zsjsahimjbf7mlv0xd0v9ohifw77jmfx', '.eJxVjsEOwiAQRP-FsyFuC2zw6N1vaHZZsNUGklJOjf9um_Sg13kzL7Opgdo6Dq3GZZhE3RSoy2_GFN4xH0BelJ9Fh5LXZWJ9VPRJq34UifP97P4JRqrjvvZoXQIBMZ116Mkl7ANaMN55kETX0EOw1DkT2QFAQEkRka1wZEbepce93Ob58wUHujs8:1ozRvD:uuVeR9S6m6vuk_0Ifd0o1N7luZ-uI0sexdhpuCvTYpQ', '2022-11-29 00:22:55.386654');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domicilio`
--

DROP TABLE IF EXISTS `domicilio`;
CREATE TABLE IF NOT EXISTS `domicilio` (
  `cod_delivery` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `code_order_id` int NOT NULL,
  `id_user_id` int NOT NULL,
  `state_domicile_id` int NOT NULL,
  PRIMARY KEY (`cod_delivery`),
  KEY `domicilio_code_order_id_e0182877_fk_orden_cod_order` (`code_order_id`),
  KEY `domicilio_id_user_id_a715c4af_fk_usuario_id_profile` (`id_user_id`),
  KEY `domicilio_state_domicile_id_c253e78e_fk` (`state_domicile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `domicilio`
--

INSERT INTO `domicilio` (`cod_delivery`, `date`, `code_order_id`, `id_user_id`, `state_domicile_id`) VALUES
(2, '2022-11-20', 3, 1234265, 1),
(3, '2022-12-03', 5, 1234265, 2),
(4, '2022-12-10', 6, 1234265, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_domicilio`
--

DROP TABLE IF EXISTS `estado_domicilio`;
CREATE TABLE IF NOT EXISTS `estado_domicilio` (
  `cod_state_domicile` int NOT NULL AUTO_INCREMENT,
  `name_state` varchar(20) NOT NULL,
  PRIMARY KEY (`cod_state_domicile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `estado_domicilio`
--

INSERT INTO `estado_domicilio` (`cod_state_domicile`, `name_state`) VALUES
(1, 'Entregado'),
(2, 'Sin entregar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE IF NOT EXISTS `inventario` (
  `cod_inventory` int NOT NULL,
  `previous_units` int NOT NULL,
  `units` int NOT NULL,
  `kind_of_movement` varchar(15) NOT NULL,
  `date_inventory` date NOT NULL,
  `cod_product_id` int NOT NULL,
  PRIMARY KEY (`cod_inventory`),
  KEY `inventario_cod_product_id_844b028c_fk_producto_cod_product` (`cod_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

DROP TABLE IF EXISTS `orden`;
CREATE TABLE IF NOT EXISTS `orden` (
  `cod_order` int NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `deliver_cost` decimal(8,2) NOT NULL,
  `full_value` decimal(8,2) NOT NULL,
  `date_order` date NOT NULL,
  `cod_sale_id` int DEFAULT NULL,
  `id_user_id` int DEFAULT NULL,
  PRIMARY KEY (`cod_order`),
  KEY `orden_cod_sale_id_c5c7f254_fk_venta_cod_sale` (`cod_sale_id`),
  KEY `orden_id_user_id_edc594f1_fk_usuario_id_profile` (`id_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`cod_order`, `status`, `deliver_cost`, `full_value`, `date_order`, `cod_sale_id`, `id_user_id`) VALUES
(3, 'OrderStatus.PAYED', '1000.00', '50000.00', '2022-11-20', 10, 1045243),
(5, 'OrderStatus.COMPLETED', '1000.00', '24000.00', '2022-12-03', 21, 1045243),
(6, 'OrderStatus.COMPLETED', '1000.00', '16000.00', '2022-12-05', 25, 1045243),
(7, 'OrderStatus.CREATED', '1000.00', '34200.00', '2022-12-06', 26, 1045243),
(8, 'OrderStatus.CREATED', '1000.00', '30200.00', '2022-12-06', 27, 1045243);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

DROP TABLE IF EXISTS `permiso`;
CREATE TABLE IF NOT EXISTS `permiso` (
  `id_permission` int NOT NULL,
  `description` longtext NOT NULL,
  `date_creation` date NOT NULL,
  `state` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permission`, `description`, `date_creation`, `state`) VALUES
(1, 'Administrador', '2022-11-11', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `cod_product` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `price_product` decimal(8,2) NOT NULL,
  `net_content` varchar(15) NOT NULL,
  `product_image` varchar(100) NOT NULL,
  `stock` smallint NOT NULL,
  `state` tinyint(1) NOT NULL,
  `price_supplier` decimal(8,2) NOT NULL,
  PRIMARY KEY (`cod_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`cod_product`, `name`, `brand`, `price_product`, `net_content`, `product_image`, `stock`, `state`, `price_supplier`) VALUES
(1, 'Chocolatina', 'Jett', '800.00', '200gr', 'media/Chocolatina-Jet_paRPWl2.webp', 0, 1, '500.00'),
(2, 'Aceite', 'Sol', '20000.00', '1000ml', 'media/Aceite_vZZ8BCs.webp', 38, 1, '10000.00'),
(3, 'Huevos', 'Sol', '15000.00', '20 u', 'media/huevos_HUbsC5i_nBn1Luz.webp', 3, 1, '7500.00'),
(4, 'Atun', 'Sol', '3000.00', '200gr', 'media/Atun_LMJ3aL8_8J2zlrE.webp', 18, 1, '1500.00'),
(5, 'Pasta', 'La muñeca', '5000.00', '200gr', 'media/Pasta_IRDwo9o_OAOW6pt.webp', 23, 1, '2500.00'),
(6, 'Avena', 'Rama', '3000.00', '500gr', 'media/Avena_jjWw50M.webp', 22, 1, '1500.00'),
(7, 'Cocacola', 'Cocacola', '5000.00', '1L', 'media/coca_cola_pkoyVmc.webp', 4, 1, '2500.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `cod_supplier` int NOT NULL,
  `name_supplier` varchar(30) NOT NULL,
  `enterprise` varchar(20) NOT NULL,
  `telephone_number` bigint NOT NULL,
  PRIMARY KEY (`cod_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`cod_supplier`, `name_supplier`, `enterprise`, `telephone_number`) VALUES
(1243232, 'David', 'Sol', 31052331),
(6543432, 'Esteban', 'Coca Cola', 310163532);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `cod_rol` int NOT NULL,
  `name_rol` varchar(20) NOT NULL,
  PRIMARY KEY (`cod_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`cod_rol`, `name_rol`) VALUES
(1, 'Administrador'),
(2, 'Empleado'),
(3, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_id_permission`
--

DROP TABLE IF EXISTS `rol_id_permission`;
CREATE TABLE IF NOT EXISTS `rol_id_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rol_id` int NOT NULL,
  `permissions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rol_id_permission_rol_id_permissions_id_533017ce_uniq` (`rol_id`,`permissions_id`),
  KEY `rol_id_permission_permissions_id_7a2a0d4b_fk_permiso_i` (`permissions_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `rol_id_permission`
--

INSERT INTO `rol_id_permission` (`id`, `rol_id`, `permissions_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_profile` int NOT NULL,
  `birthdate` date NOT NULL,
  `gender` varchar(9) NOT NULL,
  `telephone_number` bigint NOT NULL,
  `address` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `cod_rol_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id_profile`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `usuario_cod_rol_id_bc97cb6e_fk_rol_cod_rol` (`cod_rol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_profile`, `birthdate`, `gender`, `telephone_number`, `address`, `state`, `cod_rol_id`, `user_id`) VALUES
(1045243, '2022-11-16', 'Masculino', 32032201, 'Cll 11 # 34 - 12', 1, 3, 4),
(1210123, '2022-12-01', 'Masculino', 31031233, 'Cra 40 # 10 - 20', 0, 2, 9),
(1234265, '2022-11-10', 'Masculino', 312030121, 'Cra 40 # 10 - 20', 1, 2, 6),
(6434423, '2022-11-09', 'Masculino', 31056465, 'Carrera 32 # 33 - 33', 1, 2, 7),
(1212121212, '2022-11-11', 'Maculino', 12457895, 'Bogota D.C', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
  `cod_sale` int NOT NULL AUTO_INCREMENT,
  `date_sale` date NOT NULL,
  `full_value` decimal(8,2) NOT NULL,
  `cod_client_id` int DEFAULT NULL,
  `id_user_id` int DEFAULT NULL,
  PRIMARY KEY (`cod_sale`),
  KEY `venta_id_user_id_d3bd0ca1_fk_usuario_id_profile` (`id_user_id`),
  KEY `venta_cod_client_id_eb0190fb_fk_cliente_cod_client` (`cod_client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`cod_sale`, `date_sale`, `full_value`, `cod_client_id`, `id_user_id`) VALUES
(10, '2022-11-20', '49000.00', 1, 1045243),
(11, '2022-11-20', '0.00', NULL, 1045243),
(13, '2022-11-20', '0.00', NULL, 1045243),
(14, '2022-11-20', '35000.00', 1, 1212121212),
(15, '2022-11-27', '73000.00', 1, 1212121212),
(16, '2022-11-29', '103000.00', 1, 1212121212),
(17, '2022-11-29', '17000.00', 1, 1212121212),
(18, '2022-11-29', '19000.00', 1, 1212121212),
(19, '2022-12-03', '20000.00', 1, 1212121212),
(20, '2022-12-03', '0.00', NULL, 1212121212),
(21, '2022-12-03', '23000.00', NULL, 1045243),
(22, '2022-12-03', '0.00', NULL, 1045243),
(23, '2022-12-05', '23000.00', 1, 1212121212),
(24, '2022-12-05', '65000.00', 1, 1234265),
(25, '2022-12-05', '15000.00', NULL, 1045243),
(26, '2022-12-06', '33200.00', NULL, 1045243),
(27, '2022-12-06', '29200.00', NULL, 1045243),
(28, '2022-12-06', '0.00', NULL, 1045243),
(29, '2022-12-09', '0.00', NULL, 1045243),
(30, '2022-12-10', '63000.00', 1, 1212121212),
(31, '2022-12-10', '0.00', NULL, 1045243);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_id_user_id_6013e780_fk_usuario_id_profile` FOREIGN KEY (`id_user_id`) REFERENCES `usuario` (`id_profile`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_id_user_id_ca50bbd4_fk_usuario_id_profile` FOREIGN KEY (`id_user_id`) REFERENCES `usuario` (`id_profile`),
  ADD CONSTRAINT `compra_supplier_id_546e2c3c_fk_proveedor_cod_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `proveedor` (`cod_supplier`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_product_id_cfeabb94_fk_producto_cod_product` FOREIGN KEY (`product_id`) REFERENCES `producto` (`cod_product`),
  ADD CONSTRAINT `detalle_compra_purchase_id_d425c2af_fk_compra_cod_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `compra` (`cod_purchase`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_product_id_55a4ef95_fk_producto_cod_product` FOREIGN KEY (`product_id`) REFERENCES `producto` (`cod_product`),
  ADD CONSTRAINT `detalle_venta_sale_id_41a62fc9_fk_venta_cod_sale` FOREIGN KEY (`sale_id`) REFERENCES `venta` (`cod_sale`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD CONSTRAINT `domicilio_code_order_id_e0182877_fk_orden_cod_order` FOREIGN KEY (`code_order_id`) REFERENCES `orden` (`cod_order`),
  ADD CONSTRAINT `domicilio_id_user_id_a715c4af_fk_usuario_id_profile` FOREIGN KEY (`id_user_id`) REFERENCES `usuario` (`id_profile`),
  ADD CONSTRAINT `domicilio_state_domicile_id_c253e78e_fk` FOREIGN KEY (`state_domicile_id`) REFERENCES `estado_domicilio` (`cod_state_domicile`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_cod_product_id_844b028c_fk_producto_cod_product` FOREIGN KEY (`cod_product_id`) REFERENCES `producto` (`cod_product`);

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_cod_sale_id_c5c7f254_fk_venta_cod_sale` FOREIGN KEY (`cod_sale_id`) REFERENCES `venta` (`cod_sale`),
  ADD CONSTRAINT `orden_id_user_id_edc594f1_fk_usuario_id_profile` FOREIGN KEY (`id_user_id`) REFERENCES `usuario` (`id_profile`);

--
-- Filtros para la tabla `rol_id_permission`
--
ALTER TABLE `rol_id_permission`
  ADD CONSTRAINT `rol_id_permission_permissions_id_7a2a0d4b_fk_permiso_i` FOREIGN KEY (`permissions_id`) REFERENCES `permiso` (`id_permission`),
  ADD CONSTRAINT `rol_id_permission_rol_id_79c00d74_fk_rol_cod_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`cod_rol`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_cod_rol_id_bc97cb6e_fk_rol_cod_rol` FOREIGN KEY (`cod_rol_id`) REFERENCES `rol` (`cod_rol`),
  ADD CONSTRAINT `usuario_user_id_727981f6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_cod_client_id_eb0190fb_fk_cliente_cod_client` FOREIGN KEY (`cod_client_id`) REFERENCES `cliente` (`cod_client`),
  ADD CONSTRAINT `venta_id_user_id_d3bd0ca1_fk_usuario_id_profile` FOREIGN KEY (`id_user_id`) REFERENCES `usuario` (`id_profile`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
