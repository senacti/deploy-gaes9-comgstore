-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-08-2022 a las 19:46:18
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `comgstore_django_bd`
--
CREATE DATABASE IF NOT EXISTS `comgstore_django_bd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `comgstore_django_bd`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `Domiciliario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Domiciliario` (IN `accion` VARCHAR(15), IN `IdEmpleado` INT, IN `IdPedido` INT)  begin

declare DomiciliarioAsignado int;
declare Domicilio int;

case accion
when 'asignar' then
set DomiciliarioAsignado = (select Id_usuario from usuario where Estado_empleado_domicilio = "Disponible" or Estado_empleado_domicilio = "En Domicilio" order by Estado_empleado_domicilio asc limit 1);
insert into domicilio values (null,DomiciliarioAsignado, IdPedido, curdate(), 1);
update usuario set Estado_empleado_domicilio = "En Domicilio" where Id_usuario = DomiciliarioAsignado;
when 'entregado' then
set DomiciliarioAsignado = IdEmpleado;
update usuario set Estado_empleado_domicilio = "Disponible" where Id_usuario = IdEmpleado;
set Domicilio = (select Cod_domicilio from domicilio where Id_usuario_FK = IdEmpleado and Estado_domicilio_FK = 1 order by Cod_domicilio asc limit 1);
update domicilio set Estado_domicilio_FK = 2 where Cod_domicilio = Domicilio;
when 'retirarse' then
update usuario set Estado_empleado_domicilio = "Ausente" where Id_usuario = IdEmpleado;
when 'ingresar' then
update usuario set Estado_empleado_domicilio = "Disponible" where Id_usuario = IdEmpleado;
end case;

end$$

DROP PROCEDURE IF EXISTS `ProductoGeneraMasIngresos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProductoGeneraMasIngresos` (IN `FechaInicio` DATE, IN `FechaFin` DATE)  begin

select * from (select Cod_producto_FK, sum(Cantidad_productos) as cantidad, sum(Subtotal) as IngresoProducto from detalle_venta inner join venta on Cod_venta = Cod_venta_FK where Fecha_venta between FechaInicio and FechaFin group by Cod_producto_FK)C
where IngresoProducto = 
(
select max(IngresoProducto) from
(
select Cod_producto_FK, sum(Cantidad_productos) as cantidad, sum(Subtotal) as IngresoProducto from detalle_venta inner join venta on Cod_venta = Cod_venta_FK where Fecha_venta between FechaInicio and FechaInicio group by Cod_producto_FK
) A
);

end$$

DROP PROCEDURE IF EXISTS `ProductoMasVendido`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ProductoMasVendido` (IN `FechaInicio` DATE, IN `FechaFin` DATE)  begin

select * from (select Cod_producto_FK, Nombre_producto, sum(Cantidad_productos) as cantidad from venta inner join detalle_venta on Cod_venta = Cod_venta_FK inner join producto on Cod_producto_FK = Cod_producto where Fecha_venta between FechaInicio and FechaFin group by Cod_producto_FK)C
where cantidad = 
(
select max(cantidad) from
(
select Cod_producto_FK, Nombre_producto, sum(Cantidad_productos) as cantidad from venta inner join detalle_venta on Cod_venta = Cod_venta_FK inner join producto on Cod_producto_FK = Cod_producto where Fecha_venta between FechaInicio and FechaFin group by Cod_producto_FK
) A
);

end$$

DROP PROCEDURE IF EXISTS `Promociones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Promociones` (IN `idProducto` INT, IN `TipoPromocion` VARCHAR(20), IN `valor` DOUBLE, IN `marca` VARCHAR(20))  begin

declare prom double;

case TipoPromocion
when 'descuento' then
set prom = valor / 100;
update producto set Precio_producto = (Precio_producto*prom) - Precio_producto where Cod_producto = idProducto;
select concat(Nombre_producto," ", valor, "% de descuento") as descripcion, Precio_Producto from producto where Cod_producto = idProducto;
when 'restaurar' then
update producto set Precio_producto = valor where Cod_producto = idProducto;
select Nombre_producto, valor as ValorNormal from producto where Cod_producto = idProducto;
when 'descuento marca' then
set prom = valor / 100;
update producto set Precio_producto = (Precio_producto*prom) - Precio_producto where Marca = marca;
select concat(Nombre_producto," ", valor, "% de descuento") as descripcion, Precio_Producto from producto where Marca = marca;
end case;

end$$

DROP PROCEDURE IF EXISTS `SpDescuento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SpDescuento` (IN `IdProducto` INT, IN `MaxUnidades` INT, IN `Descuento` INT)  begin

declare SubtotalP double;
declare UnidadesPro int;

set SubtotalP = (select Subtotal from detalle_venta where Cod_producto_FK = IdProducto);
set UnidadesPro = (select Cantidad_productos from detalle_venta where Cod_producto_FK = IdProducto);

update detalle_venta set Subtotal = VentaPorMayor(UnidadesPro, MaxUnidades, SubtotalP, Descuento) where Cod_producto_FK = IdProducto;

select Cod_producto_FK, Cantidad_productos, Subtotal from detalle_venta where Cod_producto_FK = IdProducto;

end$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `Ganancias`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Ganancias` (`Ventas` DOUBLE, `Gastos` DOUBLE) RETURNS DOUBLE begin

declare Ganancias double;
set Ganancias = Ventas - Gastos;

return Ganancias;
end$$

DROP FUNCTION IF EXISTS `GananciasSemanales`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GananciasSemanales` (`FechaInicio` DATE, `FechaFin` DATE) RETURNS DOUBLE begin

declare Ganancias double;
set Ganancias = VentasSemanales(FechaInicio, FechaFin) - GastosSemanales(FechaInicio, FechaFin);

return Ganancias;

end$$

DROP FUNCTION IF EXISTS `GastosSemanales`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GastosSemanales` (`FechaInicio` DATE, `FechaFin` DATE) RETURNS DOUBLE begin

declare Gastos double;
set Gastos = (select sum(Valor_total) from compra where Fecha_compra between FechaInicio and FechaFin);

return Gastos;

end$$

DROP FUNCTION IF EXISTS `VentaPorMayor`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `VentaPorMayor` (`UnidadesPro` INT, `MaxUnidades` INT, `Subtotal` DOUBLE, `Descuento` INT) RETURNS DOUBLE begin

declare ProductoConDescuento double;
declare PorcentajeDesc double;
set PorcentajeDesc = (Descuento / 100);

if(UnidadesPro >= MaxUnidades) then
set ProductoConDescuento = Subtotal - (Subtotal*PorcentajeDesc);
elseif (UnidadesPro < MaxUnidades) then
set ProductoConDescuento = Subtotal;
end if;

return ProductoConDescuento;

end$$

DROP FUNCTION IF EXISTS `VentasSemanales`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `VentasSemanales` (`FechaInicio` DATE, `FechaFin` DATE) RETURNS DOUBLE begin

declare Ventas double;
set Ventas = (select sum(Valor_total) from venta where Fecha_venta between FechaInicio and FechaFin);

return Ventas;

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(13, 'Can add Profile', 4, 'add_Profile'),
(14, 'Can change Profile', 4, 'change_Profile'),
(15, 'Can delete Profile', 4, 'delete_Profile'),
(16, 'Can view Profile', 4, 'view_Profile'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_Profile`
--

DROP TABLE IF EXISTS `auth_Profile`;
CREATE TABLE `auth_Profile` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superProfile` tinyint(1) NOT NULL,
  `Profilename` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_Profile_groups`
--

DROP TABLE IF EXISTS `auth_Profile_groups`;
CREATE TABLE `auth_Profile_groups` (
  `id` bigint(20) NOT NULL,
  `Profile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_Profile_Profile_permissions`
--

DROP TABLE IF EXISTS `auth_Profile_Profile_permissions`;
CREATE TABLE `auth_Profile_Profile_permissions` (
  `id` bigint(20) NOT NULL,
  `Profile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `Cod_cliente` int(11) NOT NULL,
  `Nombre_cliente` varchar(20) NOT NULL,
  `Telefono_cliente` bigint(20) NOT NULL,
  `Direccion_cliente` varchar(50) NOT NULL,
  `Id_usuario_FK` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`Cod_cliente`, `Nombre_cliente`, `Telefono_cliente`, `Direccion_cliente`, `Id_usuario_FK`) VALUES
(1, 'Amor', 3114507100, 'Cl 32 No. 21-105', 4),
(2, 'Rocío', 3027020901, 'Cl 23SUR No. 24C-16', 5),
(3, 'Toribio', 3005017206, 'Cr 22 No. 6-69', 7),
(4, 'Dominga', 3214308637, 'Cr.30A No. 38-29', 8),
(5, 'Lupe', 3035804430, 'Av 22 No. 37-51', 9),
(6, 'Lupe', 3637750449, 'Cl 21 No. 16-37', 10),
(7, 'Otilia', 3806517903, 'Cr 100 No. 11-60', 12),
(8, 'Asunción Leocadia', 3402879360, 'Cr 42 No. 52-10', 13),
(9, 'Laura', 3115839455, 'Av 53 No. 14-55', 15),
(10, 'Francisca', 3186970054, 'Cr.14 No.93A-30', 16),
(11, 'Aura', 3156873281, 'Av 53 No. 14-55', 17),
(12, 'Rodolfo', 3167985531, 'Cr.14 No.93A-30', 18),
(13, 'Albino Dionisio', 3104763310, 'Cr 55A No. 188-41', 19),
(14, 'Salomé', 3115548730, 'Dg 147 No. 34-30', 20),
(15, 'Juan', 3048710294, 'Cl 35 No. 79A-28', 21),
(16, 'Ciriaco Benigno', 3116678940, 'Cl 34 No. 17-36', 22),
(17, 'Godofredo', 3806473310, 'Cl.54 No.47-105', 23),
(18, 'Juan Francisco', 317108963, 'Cl 7 No. 11-16', 24),
(19, 'Santos', 307445842, 'Cr 22 No. 6-69', 25),
(20, 'Lola', 3228437756, 'Cr 12 No. 21-35', 26),
(21, 'Ángel', 3186672863, 'av. 13114A-32', 27),
(22, 'Leandro', 3027064892, 'Cl 43 No. 66-14', 28),
(23, 'Virginia', 3089763310, 'Cl 1B No. 54-35', 29),
(24, '', 0, '', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

DROP TABLE IF EXISTS `compra`;
CREATE TABLE `compra` (
  `Cod_compra` int(11) NOT NULL,
  `Cod_proveedor_FK` int(11) NOT NULL,
  `Valor_total` double DEFAULT NULL,
  `Fecha_compra` date NOT NULL,
  `Id_usuario_FK` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`Cod_compra`, `Cod_proveedor_FK`, `Valor_total`, `Fecha_compra`, `Id_usuario_FK`) VALUES
(1, 3, 54400, '2022-02-18', 1),
(2, 2, 34500, '2022-02-20', 1),
(3, 6, 200000, '2022-03-08', 3),
(4, 8, 30000, '2022-01-28', 6),
(5, 12, 22000, '2022-03-08', 1),
(6, 1, 20000, '2022-02-02', 11),
(7, 3, 27200, '2022-03-01', 14),
(8, 5, 60000, '2022-01-15', 1),
(9, 3, 13600, '2022-02-27', 6),
(10, 3, 19040, '2022-01-31', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
CREATE TABLE `detalle_compra` (
  `Cod_compra_FK` int(11) NOT NULL,
  `Cod_producto_FK` int(11) NOT NULL,
  `Cantidad_productos` int(11) NOT NULL,
  `Subtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`Cod_compra_FK`, `Cod_producto_FK`, `Cantidad_productos`, `Subtotal`) VALUES
(1, 6, 20, 54400),
(2, 32, 15, 34500),
(3, 35, 25, 200000),
(4, 33, 15, 30000),
(5, 34, 10, 22000),
(6, 31, 50, 20000),
(7, 6, 10, 27200),
(8, 36, 10, 60000),
(9, 6, 5, 13600),
(10, 6, 7, 19040);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE `detalle_venta` (
  `Cod_venta_FK` int(11) NOT NULL,
  `Cod_producto_FK` int(11) NOT NULL,
  `Cantidad_productos` smallint(6) NOT NULL,
  `Subtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`Cod_venta_FK`, `Cod_producto_FK`, `Cantidad_productos`, `Subtotal`) VALUES
(1, 1, 4, 4520),
(2, 12, 1, 8190),
(2, 13, 1, 12090),
(3, 15, 4, 13800),
(3, 18, 2, 37100),
(4, 25, 1, 6900),
(4, 26, 2, 12400),
(5, 23, 5, 8250),
(5, 27, 1, 11280),
(6, 31, 10, 3600),
(6, 30, 2, 11140),
(7, 16, 3, 6990),
(7, 20, 4, 8000),
(8, 2, 2, 2180),
(8, 7, 3, 17520),
(9, 5, 2, 9980),
(9, 9, 3, 26640),
(10, 10, 2, 13900),
(10, 14, 1, 2390),
(11, 12, 1, 8190),
(11, 16, 4, 9320),
(12, 15, 2, 6900),
(12, 16, 2, 4660),
(13, 7, 3, 17520),
(13, 11, 2, 1500),
(14, 17, 2, 7980),
(14, 21, 3, 20940),
(15, 15, 1, 3450),
(15, 19, 1, 1460),
(16, 18, 1, 18550),
(16, 19, 4, 5840),
(17, 22, 3, 6540),
(17, 23, 3, 4950),
(18, 24, 5, 15150),
(18, 25, 2, 13800),
(19, 1, 5, 5650),
(19, 2, 6, 6540),
(20, 4, 1, 6750),
(20, 5, 1, 4990);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `Profile_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'Profile'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-08-31 17:21:14.530788'),
(2, 'auth', '0001_initial', '2022-08-31 17:21:26.014717'),
(3, 'admin', '0001_initial', '2022-08-31 17:21:29.320682'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-08-31 17:21:29.428647'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-08-31 17:21:29.518795'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-08-31 17:21:30.864709'),
(7, 'auth', '0002_alter_permission_name_max_length', '2022-08-31 17:21:32.132836'),
(8, 'auth', '0003_alter_Profile_email_max_length', '2022-08-31 17:21:32.293347'),
(9, 'auth', '0004_alter_Profile_Profilename_opts', '2022-08-31 17:21:32.359351'),
(10, 'auth', '0005_alter_Profile_last_login_null', '2022-08-31 17:21:33.458685'),
(11, 'auth', '0006_require_contenttypes_0002', '2022-08-31 17:21:33.491687'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2022-08-31 17:21:33.564894'),
(13, 'auth', '0008_alter_Profile_Profilename_max_length', '2022-08-31 17:21:33.778962'),
(14, 'auth', '0009_alter_Profile_last_name_max_length', '2022-08-31 17:21:33.946685'),
(15, 'auth', '0010_alter_group_name_max_length', '2022-08-31 17:21:34.109819'),
(16, 'auth', '0011_update_proxy_permissions', '2022-08-31 17:21:34.178388'),
(17, 'auth', '0012_alter_Profile_first_name_max_length', '2022-08-31 17:21:34.596299'),
(18, 'sessions', '0001_initial', '2022-08-31 17:21:35.649795');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domicilio`
--

DROP TABLE IF EXISTS `domicilio`;
CREATE TABLE `domicilio` (
  `Cod_domicilio` int(11) NOT NULL,
  `Id_usuario_FK` bigint(20) NOT NULL,
  `Cod_pedido_FK` int(11) NOT NULL,
  `Fecha_domicilio` date DEFAULT NULL,
  `Estado_domicilio_FK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `domicilio`
--

INSERT INTO `domicilio` (`Cod_domicilio`, `Id_usuario_FK`, `Cod_pedido_FK`, `Fecha_domicilio`, `Estado_domicilio_FK`) VALUES
(1, 3, 1, '2022-01-20', 2),
(2, 14, 2, '2022-01-23', 2),
(3, 1, 3, '2022-02-10', 2),
(4, 1, 4, '2022-01-03', 2),
(5, 3, 5, '2022-01-30', 2),
(6, 11, 6, '2022-02-28', 2),
(7, 6, 7, '2022-02-23', 2),
(8, 3, 8, '2022-03-05', 2),
(9, 1, 9, '2022-03-16', 2),
(10, 14, 10, '2022-03-02', 2),
(11, 6, 11, '2022-01-18', 2),
(12, 3, 12, '2022-01-07', 2),
(13, 11, 13, '2022-02-09', 2),
(14, 11, 14, '2022-02-09', 2),
(15, 6, 15, '2022-01-19', 2),
(16, 14, 10, '2022-06-22', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_domicilio`
--

DROP TABLE IF EXISTS `estado_domicilio`;
CREATE TABLE `estado_domicilio` (
  `Id_estado_domicilio` int(11) NOT NULL,
  `nombre_estado_domicilio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado_domicilio`
--

INSERT INTO `estado_domicilio` (`Id_estado_domicilio`, `nombre_estado_domicilio`) VALUES
(1, 'Sin entregar'),
(2, 'Entregado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento_inventario`
--

DROP TABLE IF EXISTS `movimiento_inventario`;
CREATE TABLE `movimiento_inventario` (
  `Cod_invetario` int(11) NOT NULL,
  `Unidades_anteriores` int(11) NOT NULL,
  `Unidades_movimiento` int(11) NOT NULL,
  `Tipo_movimiento` varchar(15) NOT NULL,
  `Cod_producto_FK` int(11) NOT NULL,
  `Fecha_inventario` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `movimiento_inventario`
--

INSERT INTO `movimiento_inventario` (`Cod_invetario`, `Unidades_anteriores`, `Unidades_movimiento`, `Tipo_movimiento`, `Cod_producto_FK`, `Fecha_inventario`) VALUES
(1, 25, 4, 'Salida', 1, '2022-01-05'),
(2, 21, 3, 'Salida', 5, '2022-01-05'),
(3, 25, 1, 'Salida', 12, '2022-01-06'),
(4, 23, 1, 'Salida', 13, '2022-01-06'),
(5, 15, 4, 'Salida', 15, '2022-01-07'),
(6, 10, 2, 'Salida', 18, '2022-01-07'),
(7, 20, 1, 'Salida', 25, '2022-01-08'),
(8, 11, 2, 'Salida', 26, '2022-01-08'),
(9, 25, 5, 'Salida', 23, '2022-01-09'),
(10, 10, 1, 'Salida', 27, '2022-01-09'),
(11, 25, 20, 'Entrada', 6, '2022-01-10'),
(12, 20, 10, 'Salida', 31, '2022-01-10'),
(13, 20, 2, 'Salida', 30, '2022-01-10'),
(14, 18, 3, 'Salida', 16, '2022-01-10'),
(15, 21, 4, 'Salida', 20, '2022-01-10'),
(16, 10, 2, 'Salida', 2, '2022-01-11'),
(17, 16, 3, 'Salida', 7, '2022-01-11'),
(18, 18, 2, 'Salida', 5, '2022-01-11'),
(19, 10, 3, 'Salida', 9, '2022-01-11'),
(20, 20, 2, 'Salida', 10, '2022-01-11'),
(21, 23, 1, 'Salida', 14, '2022-01-11'),
(22, 24, 1, 'Salida', 12, '2022-01-12'),
(23, 15, 4, 'Salida', 16, '2022-01-12'),
(24, 11, 2, 'Salida', 15, '2022-01-13'),
(25, 11, 2, 'Salida', 16, '2022-01-13'),
(26, 13, 3, 'Salida', 7, '2022-01-14'),
(27, 20, 2, 'Salida', 11, '2022-01-14'),
(28, 30, 15, 'Entrada', 32, '2022-01-15'),
(29, 13, 2, 'Salida', 17, '2022-01-15'),
(30, 14, 3, 'Salida', 21, '2022-01-15'),
(31, 9, 1, 'Salida', 15, '2022-01-16'),
(32, 10, 1, 'Salida', 19, '2022-01-16'),
(33, 8, 1, 'Salida', 18, '2022-01-16'),
(34, 9, 4, 'Salida', 19, '2022-01-16'),
(35, 16, 3, 'Salida', 22, '2022-01-17'),
(36, 20, 3, 'Salida', 23, '2022-01-17'),
(37, 21, 5, 'Salida', 24, '2022-01-17'),
(38, 19, 2, 'Salida', 25, '2022-01-17'),
(39, 30, 25, 'Entrada', 35, '2022-01-18'),
(40, 21, 5, 'Salida', 1, '2022-01-18'),
(41, 8, 6, 'Salida', 2, '2022-01-18'),
(42, 18, 1, 'Salida', 4, '2022-01-19'),
(43, 16, 1, 'Salida', 5, '2022-01-19'),
(44, 30, 15, 'Entrada', 33, '2022-01-22'),
(45, 20, 10, 'Entrada', 34, '2022-01-26'),
(46, 10, 50, 'Entrada', 31, '2022-02-01'),
(47, 45, 10, 'Entrada', 6, '2022-02-06'),
(48, 30, 10, 'Entrada', 36, '2022-02-09'),
(49, 55, 5, 'Entrada', 6, '2022-02-10'),
(50, 60, 7, 'Entrada', 6, '2022-02-13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `Cod_pedido` int(11) NOT NULL,
  `Fecha_pedido` date NOT NULL,
  `Valor_total` double NOT NULL,
  `Cod_cliente_FK` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`Cod_pedido`, `Fecha_pedido`, `Valor_total`, `Cod_cliente_FK`) VALUES
(1, '2022-01-20', 50000, 5),
(2, '2022-01-23', 50000, 5),
(3, '2022-02-10', 70000, 4),
(4, '2022-01-03', 20000, 7),
(5, '2022-01-30', 10000, 8),
(6, '2022-02-28', 30000, 5),
(7, '2022-02-23', 25000, 10),
(8, '2022-03-05', 60000, 15),
(9, '2022-03-16', 40000, 16),
(10, '2022-03-02', 10000, 5),
(11, '2022-01-18', 15000, 7),
(12, '2022-01-07', 55000, 20),
(13, '2022-02-09', 40000, 22),
(14, '2022-02-09', 35000, 5),
(15, '2022-01-19', 15000, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

DROP TABLE IF EXISTS `permiso`;
CREATE TABLE `permiso` (
  `Id_permiso` int(11) NOT NULL,
  `Descripcion_permiso` varchar(60) NOT NULL,
  `Fecha_creacion` date DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos_tipo_usuario`
--

DROP TABLE IF EXISTS `permisos_tipo_usuario`;
CREATE TABLE `permisos_tipo_usuario` (
  `Cod_tipo_usuario_FK` int(11) NOT NULL,
  `Id_permiso_FK` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `Cod_producto` int(11) NOT NULL,
  `Nombre_producto` varchar(30) NOT NULL,
  `Marca` varchar(20) NOT NULL,
  `Precio_producto` double NOT NULL,
  `Contenido_neto` varchar(15) NOT NULL,
  `Imagen_producto` mediumblob DEFAULT NULL,
  `Unidades_stock` smallint(6) NOT NULL,
  `Estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Cod_producto`, `Nombre_producto`, `Marca`, `Precio_producto`, `Contenido_neto`, `Imagen_producto`, `Unidades_stock`, `Estado`) VALUES
(1, 'Pasta en conchitas', 'Colombina', 1130, '250gr', NULL, 16, 1),
(2, 'Spaguetti Doria', 'Colombina', 1090, '250gr', NULL, 2, 1),
(3, 'Cereal desayuno Zucaritas', 'Colombina', 9.25, '420gr', NULL, 13, 1),
(4, 'Fríjol rojo ', 'Colombina', 6750, '1000gr', NULL, 17, 1),
(5, 'Duraznos en almíbar', 'Colombina', 4990, '822gr', NULL, 17, 1),
(6, 'Mantequilla con sal Alpina', 'Alpina', 2720, '250gr', NULL, 67, 1),
(7, 'Margarina Rama', 'Rama', 4500, '500gr', NULL, 10, 1),
(8, 'Chocolate Sol', 'Sol', 3250, '500gr', NULL, 11, 1),
(9, 'Café instantáneo Colcafe', 'Colcafe', 8880, '170gr', NULL, 10, 1),
(10, 'Aceite Girasoli', 'Girasol', 6950, '170gr', NULL, 20, 1),
(11, 'Sal Refisal', 'Refisal', 750, '1000gr', NULL, 20, 1),
(12, 'Huevos bandeja', 'Kikes', 8190, '30 Unidades', NULL, 25, 1),
(13, 'Leche Alquería larga vida', 'Alqueria', 12090, '900ml', NULL, 23, 1),
(14, 'Arroz FlorHuila', 'Florhuila', 2390, '500gr', NULL, 23, 1),
(15, 'Lentejas', 'Diana', 3450, '1000gr', NULL, 15, 1),
(16, 'Clorox ', 'Clorox', 2330, '1000ml', NULL, 18, 1),
(17, 'Fabuloso', 'Fabuloso', 3990, '1000ml', NULL, 13, 1),
(18, 'Detergente Fab', 'Fab', 18550, '3000gr', NULL, 10, 1),
(19, 'Jabón barra Fab original', 'Fab', 1460, '250gr', NULL, 10, 1),
(20, 'Jabón barra Coco Varela', 'Coco Varela', 2000, '300gr', NULL, 21, 1),
(21, 'Limpiavidrios Easy Off', 'Easy Off', 6980, '500ml', NULL, 14, 1),
(22, 'Sabra paquete', 'Bombril', 2180, '3 Unidades', NULL, 16, 1),
(23, 'Brillaollas Scoth Brite', 'Scoth', 1650, '6 Unidades', NULL, 25, 1),
(24, 'Lavaplatos Axion Limón', 'Axion', 3030, '500gr', NULL, 21, 1),
(25, 'Ambientador Glade', 'Glade', 6900, '360cm3', NULL, 20, 1),
(26, 'Crema Colgate', 'Colgate', 6200, '3 Unidades', NULL, 11, 1),
(27, 'Listerine Fresh Burst', 'Listerine', 11280, '500ml', NULL, 10, 1),
(28, 'Jabón Protex Fresh', 'Protex', 4790, '3 Unidades', NULL, 17, 1),
(29, 'Jabón líquido Fiamme', 'Flamme', 11810, '400ml', NULL, 18, 1),
(30, 'JShampoo Savital ', 'Savital', 5570, '350ml', NULL, 20, 1),
(31, 'Bom Bom Bum', 'Colombina', 400, '408gr', NULL, 20, 1),
(32, 'Gaseosa Manzana', 'Postobon', 2300, '350gr', NULL, 30, 1),
(33, 'Cafe', 'AguilaRoja', 2000, '400gr', NULL, 30, 1),
(34, 'Gaseosa', 'CocaCola', 2200, '1500ml', NULL, 20, 1),
(35, 'Zucaritas', 'Kellogg\'s', 8000, '900gr', NULL, 30, 1),
(36, 'Salchicha', 'Zenu', 6000, '6 Unidades', NULL, 30, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor` (
  `Cod_proveedor` int(11) NOT NULL,
  `Nombre_proveedor` varchar(30) NOT NULL,
  `Empresa` varchar(20) NOT NULL,
  `Telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`Cod_proveedor`, `Nombre_proveedor`, `Empresa`, `Telefono`) VALUES
(1, 'Felipe', 'Colombina', '3002345678'),
(2, 'Frank', 'Postobón', '6763363448'),
(3, 'Jhonny', 'Alpina', '4663049090'),
(4, 'Billy', 'Bimbo', '4952277984'),
(5, 'Tomas', 'Zenú', '4701046951'),
(6, 'Brayan', 'Kellogg\'s', '2467466491'),
(7, 'Sofia', 'Quala', '4372160535'),
(8, 'Patricia', 'Aguila Roja', '3747333505'),
(9, 'Federica', 'Babaria', '6333983038'),
(10, 'Tatiana', 'Margarita', '56019543'),
(11, 'Carlos', 'Doria', '3284270645'),
(12, 'Laura', 'Coca-Cola', '2233797564'),
(13, 'Josefina', 'Nestle', '2996296649'),
(14, 'Francisco', 'Quala', '31201201'),
(21, 'Catalina', 'Postobon', '421312'),
(22, 'Tatiana', 'Frutiño', '32412312');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
CREATE TABLE `tipo_usuario` (
  `Cod_tipo_usuario` int(11) NOT NULL,
  `Tipo_usuario` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`Cod_tipo_usuario`, `Tipo_usuario`) VALUES
(1, 'Administrador'),
(3, 'Cliente'),
(2, 'Empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `Id_usuario` bigint(20) NOT NULL,
  `Nombres` varchar(20) NOT NULL,
  `Apellido_1` varchar(20) NOT NULL,
  `Apellido_2` varchar(20) NOT NULL,
  `Fecha_nacimiento` date NOT NULL,
  `Genero` varchar(9) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Direccion_residencia` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Contraseña_usuario` varchar(20) NOT NULL,
  `Cod_tipo_usuario_FK` int(11) NOT NULL,
  `Estado` tinyint(1) NOT NULL,
  `Estado_empleado_domicilio` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Id_usuario`, `Nombres`, `Apellido_1`, `Apellido_2`, `Fecha_nacimiento`, `Genero`, `Telefono`, `Direccion_residencia`, `Email`, `Contraseña_usuario`, `Cod_tipo_usuario_FK`, `Estado`, `Estado_empleado_domicilio`) VALUES
(1, 'Juan David', 'Castro', 'Rodriguez', '1990-02-19', 'Masculino', '3128457645', 'Calle 45 # 44 - 30', 'juand@gmail.com', 'jujud333', 2, 1, 'Ausente'),
(2, 'Renata', 'Miralles', 'Asensio', '1999-03-25', 'Femenino', '3004570100', 'Cr 105 No. 14-250', 'rnata@gmail.com', 'rmlles571', 1, 1, 'No Aplica'),
(3, 'Elba', 'Zurita', 'Calderón', '1993-01-26', 'Femenino', '3129015701', 'Cr 2 No. 4-15', 'zcalderon@gmail.com', 'elcalderon12', 2, 1, 'Ausente'),
(4, 'Amor', 'Donoso', 'Escolano', '1992-02-17', 'Femenino', '3114507100', 'Cl 32 No. 21-105', 'amorpenoso@gmail.com', 'aescol11', 3, 1, 'No Aplica'),
(5, 'Rocío', 'Castro', 'del Melero', '1978-03-12', 'Masculino', '3027020901', 'Cl 23SUR No. 24C-16', 'castrodrocio@gmail.com', 'rocio20', 3, 1, 'No Aplica'),
(6, 'Augusto', 'Pintor ', 'Marí', '1982-09-26', 'Masculino', '315080211', 'Av. Calle 80 # 69 -70', 'gustopinto@gmail.com', 'apintor08', 2, 1, 'Ausente'),
(7, 'Toribio ', 'Cuéllar', 'Salas', '1978-11-18', 'Masculino', '3005017206', 'Cr 22 No. 6-69', 'thorvivio@gmail.com', 'torisalas', 3, 1, 'No Aplica'),
(8, 'Dominga', 'Valera', 'Escalona', '1968-04-23', 'Femenino', '3214308637', 'Cr.30A No. 38-29', 'hormigavalera@gmail.com', 'valeralona', 3, 1, 'No Aplica'),
(9, 'Lupe', 'Falcó', 'López', '1986-07-28', 'Femenino', '3035804430', 'Av 22 No. 37-51', 'lupitafalcon@gmail.com', 'lupfalco', 3, 1, 'No Aplica'),
(10, 'Lupe', 'Rico', 'García', '1972-03-30', 'Femenino', '3637750449', 'Cl 21 No. 16-37', 'luperich@gmail.com', 'garciar77', 3, 1, 'No Aplica'),
(11, 'Anastasia', 'Salgado', 'del Barrio', '1970-09-07', 'Femenino', '3084607799', 'Cl 19 N No. 2 N-29', 'anadelbarrio@gmail.com', 'salgadob3', 2, 1, 'En Domicilio'),
(12, 'Otilia', 'Rius', 'Peral', '1972-08-16', 'Femenino', '3806517903', 'Cr 100 No. 11-60', 'riuspiedra@gmail.com', 'otilia17', 3, 1, 'No Aplica'),
(13, 'Asunción Leocadia', 'Serna', 'Ruiz', '1993-07-24', 'Femenino', '3402879360', 'Cr 42 No. 52-10', 'asuntosleo@gmail.com', 'leoruiz', 3, 1, 'No Aplica'),
(14, 'Rodolfo', 'Gracia', 'Arana', '2001-12-30', 'Masculino', '3305697740', 'Cr 37 No. 10-35', 'renofeliz@gmail.com', 'aranag30', 2, 1, 'Disponible'),
(15, 'Laura', 'Rebollo', 'Alberola', '1991-06-28', 'Femenino', '3115839455', 'Av 53 No. 14-55', 'lalarepollo@gmail.com', 'laurebollo11', 3, 1, 'No Aplica'),
(16, 'Francisca', 'Cabello', 'Carnero', '1999-03-12', 'Femenino', '3186970054', 'Cr.14 No.93A-30', 'fcabello@gmail.com', 'x4^NRM@%sPhA&4iP', 3, 1, 'No Aplica'),
(17, ' Aura', 'Roman', 'Salgado', '1968-04-26', 'Femenino', '3156873281', 'Av 53 No. 14-55', 'romancousin@gmail.com', 'fCSWM@%6H66H9UiE', 3, 1, 'No Aplica'),
(18, 'Rodolfo', ' Garay', 'Granados', '1968-04-28', 'Masculino', '3167985531', 'Cr.14 No.93A-30', 'reno_copia@gmail.com', 'R%C&RRNsKYJy82A2', 3, 1, 'No Aplica'),
(19, 'Albino Dionisio', 'Segura', 'Larrañaga', '1971-08-03', 'Masculino', '3104763310', 'Cr 55A No. 188-41', 'juand@gmail.com', 'ekM^jkaGQQwmZ3k6', 3, 1, 'No Aplica'),
(20, 'Salomé', 'Amaya', 'Rodriguez', '2000-08-23', 'Femenino', '3115548730', 'Dg 147 No. 34-30', 'salmonfeliz@gmail.com', 'yMgdEbLR!R5BZtwd', 3, 1, 'No Aplica'),
(21, 'Juan', 'Castro', 'Duarte', '1976-08-16', 'Masculino', '3048710294', 'Cl 35 No. 79A-28', 'castroperros@gmail.com', 'nPYh!AJunbqEu6rY', 3, 1, 'No Aplica'),
(22, 'Ciriaco Benigno', 'Llopis', 'Larrea', '2004-07-26', 'Masculino', '3116678940', 'Cl 34 No. 17-36', 'ciriaco@gmail.com', 'xmu37FS@hQVHmXZ4', 3, 1, 'No Aplica'),
(23, 'Godofredo', 'Tejera', 'Carretero', '2003-04-29', 'Masculino', '3806473310', 'Cl.54 No.47-105', 'godpedro@gmail.com', '2a%yMbEHpA7fWdos', 3, 1, 'No Aplica'),
(24, 'Juan Francisco', 'Cerro', 'Ugarte', '1990-02-19', 'Masculino', '317108963', 'Cl 7 No. 11-16', 'sanfrancisco@gmail.com', 'u4tbs%qd7fw9AZyA', 3, 1, 'No Aplica'),
(25, 'Santos', 'Castro', 'de Sandoval', '1995-01-26', 'Masculino', '307445842', 'Cr 22 No. 6-69', 'santosdobrasil@gmail.com', 'yR4xfq3ZW@S!s@3G', 3, 1, 'No Aplica'),
(26, 'Lola', 'Quesada', 'del Garcia', '1992-04-20', 'Femenino', '3228437756', 'Cr 12 No. 21-35', 'lolaqueso@gmail.com', 'k6UZ5P!Cod4G8fav', 3, 1, 'No Aplica'),
(27, 'Ángel', 'Quesada', 'Canet', '1987-06-01', 'Masculino', '3186672863', 'av. 13114A-32', 'angelheaven@gmail.com', '&ubH^CAT9fxF3tG9', 3, 1, 'No Aplica'),
(28, 'Leandro', 'Arnaiz', 'Barrio', '2003-08-20', 'Masculino', '3027064892', 'Cl 43 No. 66-14', 'androlea@gmail.com', 'aB33d$xeBgy9f49U', 3, 1, 'No Aplica'),
(29, 'Virginia', 'Colomer', 'Ferrándiz', '1975-05-24', 'Femenino', '3089763310', 'Cl 1B No. 54-35', 'geektriste@gmail.com', 'UT!kxauZ6@ENKdAv', 3, 1, 'No Aplica'),
(30, 'Tito ', 'Castelló', 'Bellido', '2002-07-02', 'Masculino', '3149679001', 'Cr 87C No. 34C-39', 'belludotito@gmail.com', '$sW&8p9GwicTzAox', 3, 1, 'No Aplica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta` (
  `Cod_venta` int(11) NOT NULL,
  `Fecha_venta` date NOT NULL,
  `Valor_total` double NOT NULL,
  `Id_usuario_FK` bigint(20) NOT NULL,
  `Cod_cliente_FK` int(11) NOT NULL,
  `Cod_pedido_FK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`Cod_venta`, `Fecha_venta`, `Valor_total`, `Id_usuario_FK`, `Cod_cliente_FK`, `Cod_pedido_FK`) VALUES
(1, '2022-02-15', 19490, 1, 19, NULL),
(2, '2022-02-20', 20280, 11, 10, NULL),
(3, '2022-01-16', 50900, 3, 4, NULL),
(4, '2022-02-17', 19300, 14, 9, NULL),
(5, '2022-03-01', 19530, 6, 16, NULL),
(6, '2022-01-20', 15140, 3, 5, 1),
(7, '2022-01-23', 14990, 14, 5, 2),
(8, '2022-02-10', 19700, 1, 4, 3),
(9, '2022-01-03', 36620, 1, 7, 4),
(10, '2022-01-30', 16290, 3, 8, 5),
(11, '2022-02-28', 17510, 11, 5, 6),
(12, '2022-02-23', 11560, 6, 10, 7),
(13, '2022-03-05', 19020, 3, 15, 8),
(14, '2022-03-16', 28920, 1, 16, 9),
(15, '2022-03-02', 4910, 14, 5, 10),
(16, '2022-01-18', 24390, 6, 7, 11),
(17, '2022-01-07', 11490, 3, 20, 12),
(18, '2022-02-09', 28950, 11, 22, 13),
(19, '2022-02-09', 12190, 11, 5, 14),
(20, '2022-01-19', 11740, 6, 8, 15);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_Profile`
--
ALTER TABLE `auth_Profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Profilename` (`Profilename`);

--
-- Indices de la tabla `auth_Profile_groups`
--
ALTER TABLE `auth_Profile_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_Profile_groups_Profile_id_group_id_94350c0c_uniq` (`Profile_id`,`group_id`),
  ADD KEY `auth_Profile_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_Profile_Profile_permissions`
--
ALTER TABLE `auth_Profile_Profile_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_Profile_Profile_permissions_Profile_id_permission_id_14a6b632_uniq` (`Profile_id`,`permission_id`),
  ADD KEY `auth_Profile_Profile_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Cod_cliente`),
  ADD UNIQUE KEY `index_telefono_cliente` (`Telefono_cliente`),
  ADD KEY `Id_usuario_FK` (`Id_usuario_FK`),
  ADD KEY `index_cliente` (`Nombre_cliente`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`Cod_compra`),
  ADD UNIQUE KEY `index_compra` (`Cod_compra`),
  ADD KEY `Cod_proveedor_FK` (`Cod_proveedor_FK`),
  ADD KEY `Id_usuario_FK` (`Id_usuario_FK`),
  ADD KEY `index_fecha_compra` (`Fecha_compra`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD KEY `Cod_compra_FK` (`Cod_compra_FK`),
  ADD KEY `Cod_producto_FK` (`Cod_producto_FK`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD KEY `Cod_venta_FK` (`Cod_venta_FK`),
  ADD KEY `Cod_producto_FK` (`Cod_producto_FK`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_Profile_id_c564eba6_fk_auth_Profile_id` (`Profile_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD PRIMARY KEY (`Cod_domicilio`),
  ADD KEY `Id_usuario_FK` (`Id_usuario_FK`),
  ADD KEY `Cod_pedido_FK` (`Cod_pedido_FK`),
  ADD KEY `index_domicilio` (`Cod_domicilio`),
  ADD KEY `Estado_domicilio_FK` (`Estado_domicilio_FK`);

--
-- Indices de la tabla `estado_domicilio`
--
ALTER TABLE `estado_domicilio`
  ADD PRIMARY KEY (`Id_estado_domicilio`);

--
-- Indices de la tabla `movimiento_inventario`
--
ALTER TABLE `movimiento_inventario`
  ADD PRIMARY KEY (`Cod_invetario`),
  ADD KEY `Cod_producto_FK` (`Cod_producto_FK`),
  ADD KEY `index_fecha_inv` (`Fecha_inventario`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`Cod_pedido`),
  ADD KEY `Cod_cliente_FK` (`Cod_cliente_FK`),
  ADD KEY `index_pedido` (`Fecha_pedido`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`Id_permiso`);

--
-- Indices de la tabla `permisos_tipo_usuario`
--
ALTER TABLE `permisos_tipo_usuario`
  ADD KEY `Cod_tipo_usuario_FK` (`Cod_tipo_usuario_FK`),
  ADD KEY `Id_permiso_FK` (`Id_permiso_FK`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Cod_producto`),
  ADD KEY `index_nom_producto` (`Nombre_producto`),
  ADD KEY `index_marca_producto` (`Marca`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`Cod_proveedor`),
  ADD KEY `index_proveedor` (`Nombre_proveedor`),
  ADD KEY `index_empresa_proveedor` (`Empresa`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`Cod_tipo_usuario`),
  ADD KEY `index_tipo_usuario` (`Tipo_usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Id_usuario`),
  ADD UNIQUE KEY `Contraseña_usuario` (`Contraseña_usuario`),
  ADD UNIQUE KEY `index_telefono_usuario` (`Telefono`),
  ADD KEY `Cod_tipo_usuario_FK` (`Cod_tipo_usuario_FK`),
  ADD KEY `index_usuario` (`Nombres`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`Cod_venta`),
  ADD KEY `Id_usuario_FK` (`Id_usuario_FK`),
  ADD KEY `Cod_cliente_FK` (`Cod_cliente_FK`),
  ADD KEY `Cod_pedido_FK` (`Cod_pedido_FK`),
  ADD KEY `index_fecha_venta` (`Fecha_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `auth_Profile`
--
ALTER TABLE `auth_Profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_Profile_groups`
--
ALTER TABLE `auth_Profile_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_Profile_Profile_permissions`
--
ALTER TABLE `auth_Profile_Profile_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `Cod_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `Cod_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  MODIFY `Cod_domicilio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `estado_domicilio`
--
ALTER TABLE `estado_domicilio`
  MODIFY `Id_estado_domicilio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `movimiento_inventario`
--
ALTER TABLE `movimiento_inventario`
  MODIFY `Cod_invetario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `Cod_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `Id_permiso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `Cod_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `Cod_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `Id_usuario` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `Cod_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
-- Filtros para la tabla `auth_Profile_groups`
--
ALTER TABLE `auth_Profile_groups`
  ADD CONSTRAINT `auth_Profile_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_Profile_groups_Profile_id_6a12ed8b_fk_auth_Profile_id` FOREIGN KEY (`Profile_id`) REFERENCES `auth_Profile` (`id`);

--
-- Filtros para la tabla `auth_Profile_Profile_permissions`
--
ALTER TABLE `auth_Profile_Profile_permissions`
  ADD CONSTRAINT `auth_Profile_Profile_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_Profile_Profile_permissions_Profile_id_a95ead1b_fk_auth_Profile_id` FOREIGN KEY (`Profile_id`) REFERENCES `auth_Profile` (`id`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`Id_usuario_FK`) REFERENCES `usuario` (`Id_usuario`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`Cod_proveedor_FK`) REFERENCES `proveedor` (`Cod_proveedor`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`Id_usuario_FK`) REFERENCES `usuario` (`Id_usuario`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`Cod_compra_FK`) REFERENCES `compra` (`Cod_compra`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`Cod_producto_FK`) REFERENCES `producto` (`Cod_producto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`Cod_venta_FK`) REFERENCES `venta` (`Cod_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`Cod_producto_FK`) REFERENCES `producto` (`Cod_producto`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_Profile_id_c564eba6_fk_auth_Profile_id` FOREIGN KEY (`Profile_id`) REFERENCES `auth_Profile` (`id`);

--
-- Filtros para la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD CONSTRAINT `domicilio_ibfk_1` FOREIGN KEY (`Id_usuario_FK`) REFERENCES `usuario` (`Id_usuario`),
  ADD CONSTRAINT `domicilio_ibfk_2` FOREIGN KEY (`Cod_pedido_FK`) REFERENCES `pedido` (`Cod_pedido`),
  ADD CONSTRAINT `domicilio_ibfk_3` FOREIGN KEY (`Estado_domicilio_FK`) REFERENCES `estado_domicilio` (`Id_estado_domicilio`),
  ADD CONSTRAINT `domicilio_ibfk_4` FOREIGN KEY (`Estado_domicilio_FK`) REFERENCES `estado_domicilio` (`Id_estado_domicilio`);

--
-- Filtros para la tabla `movimiento_inventario`
--
ALTER TABLE `movimiento_inventario`
  ADD CONSTRAINT `movimiento_inventario_ibfk_1` FOREIGN KEY (`Cod_producto_FK`) REFERENCES `producto` (`Cod_producto`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`Cod_cliente_FK`) REFERENCES `cliente` (`Cod_cliente`);

--
-- Filtros para la tabla `permisos_tipo_usuario`
--
ALTER TABLE `permisos_tipo_usuario`
  ADD CONSTRAINT `permisos_tipo_usuario_ibfk_1` FOREIGN KEY (`Cod_tipo_usuario_FK`) REFERENCES `tipo_usuario` (`Cod_tipo_usuario`),
  ADD CONSTRAINT `permisos_tipo_usuario_ibfk_2` FOREIGN KEY (`Id_permiso_FK`) REFERENCES `permiso` (`Id_permiso`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Cod_tipo_usuario_FK`) REFERENCES `tipo_usuario` (`Cod_tipo_usuario`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`Id_usuario_FK`) REFERENCES `usuario` (`Id_usuario`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`Cod_cliente_FK`) REFERENCES `cliente` (`Cod_cliente`),
  ADD CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`Cod_pedido_FK`) REFERENCES `pedido` (`Cod_pedido`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
