-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 14-09-2022 a las 02:09:03
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
-- Base de datos: `comgstore_django`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin_interface_theme`
--

DROP TABLE IF EXISTS `admin_interface_theme`;
CREATE TABLE IF NOT EXISTS `admin_interface_theme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_visible` tinyint(1) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `logo_visible` tinyint(1) NOT NULL,
  `css_header_background_color` varchar(10) NOT NULL,
  `title_color` varchar(10) NOT NULL,
  `css_header_text_color` varchar(10) NOT NULL,
  `css_header_link_color` varchar(10) NOT NULL,
  `css_header_link_hover_color` varchar(10) NOT NULL,
  `css_module_background_color` varchar(10) NOT NULL,
  `css_module_text_color` varchar(10) NOT NULL,
  `css_module_link_color` varchar(10) NOT NULL,
  `css_module_link_hover_color` varchar(10) NOT NULL,
  `css_module_rounded_corners` tinyint(1) NOT NULL,
  `css_generic_link_color` varchar(10) NOT NULL,
  `css_generic_link_hover_color` varchar(10) NOT NULL,
  `css_save_button_background_color` varchar(10) NOT NULL,
  `css_save_button_background_hover_color` varchar(10) NOT NULL,
  `css_save_button_text_color` varchar(10) NOT NULL,
  `css_delete_button_background_color` varchar(10) NOT NULL,
  `css_delete_button_background_hover_color` varchar(10) NOT NULL,
  `css_delete_button_text_color` varchar(10) NOT NULL,
  `list_filter_dropdown` tinyint(1) NOT NULL,
  `related_modal_active` tinyint(1) NOT NULL,
  `related_modal_background_color` varchar(10) NOT NULL,
  `related_modal_rounded_corners` tinyint(1) NOT NULL,
  `logo_color` varchar(10) NOT NULL,
  `recent_actions_visible` tinyint(1) NOT NULL,
  `favicon` varchar(100) NOT NULL,
  `related_modal_background_opacity` varchar(5) NOT NULL,
  `env_name` varchar(50) NOT NULL,
  `env_visible_in_header` tinyint(1) NOT NULL,
  `env_color` varchar(10) NOT NULL,
  `env_visible_in_favicon` tinyint(1) NOT NULL,
  `related_modal_close_button_visible` tinyint(1) NOT NULL,
  `language_chooser_active` tinyint(1) NOT NULL,
  `language_chooser_display` varchar(10) NOT NULL,
  `list_filter_sticky` tinyint(1) NOT NULL,
  `form_pagination_sticky` tinyint(1) NOT NULL,
  `form_submit_sticky` tinyint(1) NOT NULL,
  `css_module_background_selected_color` varchar(10) NOT NULL,
  `css_module_link_selected_color` varchar(10) NOT NULL,
  `logo_max_height` smallint UNSIGNED NOT NULL,
  `logo_max_width` smallint UNSIGNED NOT NULL,
  `foldable_apps` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_interface_theme_name_30bda70f_uniq` (`name`)
) ;

--
-- Volcado de datos para la tabla `admin_interface_theme`
--

INSERT INTO `admin_interface_theme` (`id`, `name`, `active`, `title`, `title_visible`, `logo`, `logo_visible`, `css_header_background_color`, `title_color`, `css_header_text_color`, `css_header_link_color`, `css_header_link_hover_color`, `css_module_background_color`, `css_module_text_color`, `css_module_link_color`, `css_module_link_hover_color`, `css_module_rounded_corners`, `css_generic_link_color`, `css_generic_link_hover_color`, `css_save_button_background_color`, `css_save_button_background_hover_color`, `css_save_button_text_color`, `css_delete_button_background_color`, `css_delete_button_background_hover_color`, `css_delete_button_text_color`, `list_filter_dropdown`, `related_modal_active`, `related_modal_background_color`, `related_modal_rounded_corners`, `logo_color`, `recent_actions_visible`, `favicon`, `related_modal_background_opacity`, `env_name`, `env_visible_in_header`, `env_color`, `env_visible_in_favicon`, `related_modal_close_button_visible`, `language_chooser_active`, `language_chooser_display`, `list_filter_sticky`, `form_pagination_sticky`, `form_submit_sticky`, `css_module_background_selected_color`, `css_module_link_selected_color`, `logo_max_height`, `logo_max_width`, `foldable_apps`) VALUES
(1, 'Django', 0, 'Django administration', 1, '', 1, '#0C4B33', '#F5DD5D', '#44B78B', '#FFFFFF', '#C9F0DD', '#44B78B', '#FFFFFF', '#FFFFFF', '#C9F0DD', 1, '#0C3C26', '#156641', '#0C4B33', '#0C3C26', '#FFFFFF', '#BA2121', '#A41515', '#FFFFFF', 1, 1, '#000000', 1, '#FFFFFF', 1, '', '0.3', '', 1, '#E74C3C', 1, 1, 1, 'code', 1, 0, 0, '#FFFFCC', '#FFFFFF', 100, 400, 1),
(2, 'ComGStore', 1, 'ComGStore', 1, 'admin-interface/logo/ComGStore_ljSn8Rl.png', 1, '#0D084B', '#F5F5F5', '#44B78B', '#FFFFFF', '#B10000', '#44B78B', '#FFFFFF', '#FFFFFF', '#C9F0DD', 1, '#0C3C26', '#156641', '#0C4B33', '#0C3C26', '#FFFFFF', '#BA2121', '#A41515', '#FFFFFF', 1, 1, '#000000', 1, '#FFFFFF', 1, '', '0.3', '', 1, '#E74C3C', 1, 1, 1, 'code', 1, 0, 0, '#FFFFCC', '#FFFFFF', 100, 400, 1);

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
) ENGINE=InnoDB ;

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
) ENGINE=InnoDB ;

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
) ENGINE=InnoDB AUTO_INCREMENT=77 ;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add Theme', 1, 'add_theme'),
(2, 'Can change Theme', 1, 'change_theme'),
(3, 'Can delete Theme', 1, 'delete_theme'),
(4, 'Can view Theme', 1, 'view_theme'),
(5, 'Can add log entry', 2, 'add_logentry'),
(6, 'Can change log entry', 2, 'change_logentry'),
(7, 'Can delete log entry', 2, 'delete_logentry'),
(8, 'Can view log entry', 2, 'view_logentry'),
(9, 'Can add permission', 3, 'add_permission'),
(10, 'Can change permission', 3, 'change_permission'),
(11, 'Can delete permission', 3, 'delete_permission'),
(12, 'Can view permission', 3, 'view_permission'),
(13, 'Can add group', 4, 'add_group'),
(14, 'Can change group', 4, 'change_group'),
(15, 'Can delete group', 4, 'delete_group'),
(16, 'Can view group', 4, 'view_group'),
(17, 'Can add Profile', 5, 'add_Profile'),
(18, 'Can change Profile', 5, 'change_Profile'),
(19, 'Can delete Profile', 5, 'delete_Profile'),
(20, 'Can view Profile', 5, 'view_Profile'),
(21, 'Can add content type', 6, 'add_contenttype'),
(22, 'Can change content type', 6, 'change_contenttype'),
(23, 'Can delete content type', 6, 'delete_contenttype'),
(24, 'Can view content type', 6, 'view_contenttype'),
(25, 'Can add session', 7, 'add_session'),
(26, 'Can change session', 7, 'change_session'),
(27, 'Can delete session', 7, 'delete_session'),
(28, 'Can view session', 7, 'view_session'),
(29, 'Can add Cliente', 8, 'add_client'),
(30, 'Can change Cliente', 8, 'change_client'),
(31, 'Can delete Cliente', 8, 'delete_client'),
(32, 'Can view Cliente', 8, 'view_client'),
(33, 'Can add Orden', 9, 'add_order'),
(34, 'Can change Orden', 9, 'change_order'),
(35, 'Can delete Orden', 9, 'delete_order'),
(36, 'Can view Orden', 9, 'view_order'),
(37, 'Can add Permiso', 10, 'add_permissions'),
(38, 'Can change Permiso', 10, 'change_permissions'),
(39, 'Can delete Permiso', 10, 'delete_permissions'),
(40, 'Can view Permiso', 10, 'view_permissions'),
(41, 'Can add Producto', 11, 'add_product'),
(42, 'Can change Producto', 11, 'change_product'),
(43, 'Can delete Producto', 11, 'delete_product'),
(44, 'Can view Producto', 11, 'view_product'),
(45, 'Can add Rol', 12, 'add_rol'),
(46, 'Can change Rol', 12, 'change_rol'),
(47, 'Can delete Rol', 12, 'delete_rol'),
(48, 'Can view Rol', 12, 'view_rol'),
(49, 'Can add EstadoDomicilio', 13, 'add_statedomicile'),
(50, 'Can change EstadoDomicilio', 13, 'change_statedomicile'),
(51, 'Can delete EstadoDomicilio', 13, 'delete_statedomicile'),
(52, 'Can view EstadoDomicilio', 13, 'view_statedomicile'),
(53, 'Can add Proveedor', 14, 'add_supplier'),
(54, 'Can change Proveedor', 14, 'change_supplier'),
(55, 'Can delete Proveedor', 14, 'delete_supplier'),
(56, 'Can view Proveedor', 14, 'view_supplier'),
(57, 'Can add Usuario', 15, 'add_Profile'),
(58, 'Can change Usuario', 15, 'change_Profile'),
(59, 'Can delete Usuario', 15, 'delete_Profile'),
(60, 'Can view Usuario', 15, 'view_Profile'),
(61, 'Can add Venta', 16, 'add_sales'),
(62, 'Can change Venta', 16, 'change_sales'),
(63, 'Can delete Venta', 16, 'delete_sales'),
(64, 'Can view Venta', 16, 'view_sales'),
(65, 'Can add Compra', 17, 'add_purchase'),
(66, 'Can change Compra', 17, 'change_purchase'),
(67, 'Can delete Compra', 17, 'delete_purchase'),
(68, 'Can view Compra', 17, 'view_purchase'),
(69, 'Can add Inventario', 18, 'add_inventorymovement'),
(70, 'Can change Inventario', 18, 'change_inventorymovement'),
(71, 'Can delete Inventario', 18, 'delete_inventorymovement'),
(72, 'Can view Inventario', 18, 'view_inventorymovement'),
(73, 'Can add Domicilio', 19, 'add_delivery'),
(74, 'Can change Domicilio', 19, 'change_delivery'),
(75, 'Can delete Domicilio', 19, 'delete_delivery'),
(76, 'Can view Domicilio', 19, 'view_delivery');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_Profile`
--

DROP TABLE IF EXISTS `auth_Profile`;
CREATE TABLE IF NOT EXISTS `auth_Profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superProfile` tinyint(1) NOT NULL,
  `Profilename` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Profilename` (`Profilename`)
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `auth_Profile`
--

INSERT INTO `auth_Profile` (`id`, `password`, `last_login`, `is_superProfile`, `Profilename`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$fL5XyjjGvegSYCiCiZaInE$Rrz6ricpFxv0XRqmZZoz3LHXzSk/x1eKThQp2XpfYYw=', '2022-09-12 21:15:45.055870', 1, 'juanp', '', '', 'juan@gmail.com', 1, 1, '2022-09-12 20:56:47.323570');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_Profile_groups`
--

DROP TABLE IF EXISTS `auth_Profile_groups`;
CREATE TABLE IF NOT EXISTS `auth_Profile_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Profile_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_Profile_groups_Profile_id_group_id_94350c0c_uniq` (`Profile_id`,`group_id`),
  KEY `auth_Profile_groups_group_id_97559544_fk_auth_group_id` (`group_id`)
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_Profile_Profile_permissions`
--

DROP TABLE IF EXISTS `auth_Profile_Profile_permissions`;
CREATE TABLE IF NOT EXISTS `auth_Profile_Profile_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Profile_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_Profile_Profile_permissions_Profile_id_permission_id_14a6b632_uniq` (`Profile_id`,`permission_id`),
  KEY `auth_Profile_Profile_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `cod_client` int NOT NULL,
  `client_name` varchar(20) NOT NULL,
  `client_address` varchar(50) NOT NULL,
  `id_Profile_id` int NOT NULL,
  PRIMARY KEY (`cod_client`),
  KEY `cliente_id_Profile_id_6013e780_fk_usuario_id_Profile` (`id_Profile_id`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cod_client`, `client_name`, `client_address`, `id_Profile_id`) VALUES
(1, 'Maria', 'Calle 80', 45345);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
  `cod_purchase` int NOT NULL,
  `total_value` double NOT NULL,
  `date_purchase` date NOT NULL,
  `id_Profile_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  PRIMARY KEY (`cod_purchase`),
  KEY `compra_id_Profile_id_ca50bbd4_fk_usuario_id_Profile` (`id_Profile_id`),
  KEY `compra_supplier_id_546e2c3c_fk_proveedor_cod_supplier` (`supplier_id`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`cod_purchase`, `total_value`, `date_purchase`, `id_Profile_id`, `supplier_id`) VALUES
(1, 20000, '2022-09-13', 341231, 124314);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_cod_product`
--

DROP TABLE IF EXISTS `compra_cod_product`;
CREATE TABLE IF NOT EXISTS `compra_cod_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compra_cod_product_purchase_id_product_id_3e87be85_uniq` (`purchase_id`,`product_id`),
  KEY `compra_cod_product_product_id_aa12324a_fk_producto_cod_product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `compra_cod_product`
--

INSERT INTO `compra_cod_product` (`id`, `purchase_id`, `product_id`) VALUES
(4, 1, 222),
(3, 1, 333);

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
  `Profile_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_Profile_id_c564eba6_fk_auth_Profile_id` (`Profile_id`)
) ;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `Profile_id`) VALUES
(1, '2022-09-12 20:58:28.231706', '2', 'ComGStore', 1, '[{\"added\": {}}]', 1, 1),
(2, '2022-09-12 21:00:35.547193', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Logo\"]}}]', 1, 1),
(3, '2022-09-12 21:01:37.951331', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Favicon\"]}}]', 1, 1),
(4, '2022-09-12 21:01:45.284902', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Favicon\"]}}]', 1, 1),
(5, '2022-09-12 21:01:52.152917', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Logo\"]}}]', 1, 1),
(6, '2022-09-12 21:02:19.686911', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Title\"]}}]', 1, 1),
(7, '2022-09-12 21:05:23.058241', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Color\"]}}]', 1, 1),
(8, '2022-09-12 21:06:23.057200', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Active\"]}}]', 1, 1),
(9, '2022-09-12 21:06:23.298233', '1', 'Django', 2, '[{\"changed\": {\"fields\": [\"Active\"]}}]', 1, 1),
(10, '2022-09-12 21:16:07.001164', '2', 'ComGStore', 2, '[]', 1, 1),
(11, '2022-09-12 21:16:20.465106', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Active\"]}}]', 1, 1),
(12, '2022-09-12 21:17:19.276663', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Logo\"]}}]', 1, 1),
(13, '2022-09-12 21:19:27.994994', '2', 'ComGStore', 2, '[]', 1, 1),
(14, '2022-09-12 21:28:25.119745', '2', 'ComGStore', 2, '[{\"changed\": {\"fields\": [\"Background color\", \"Link hover color\"]}}]', 1, 1),
(15, '2022-09-12 21:28:34.608008', '2', 'ComGStore', 2, '[]', 1, 1),
(16, '2022-09-12 21:28:51.974803', '2', 'ComGStore', 2, '[]', 1, 1),
(17, '2022-09-14 00:50:26.626285', '1', 'Registrar Ventas', 1, '[{\"added\": {}}]', 10, 1),
(18, '2022-09-14 01:37:16.079551', '1', 'Administrador', 1, '[{\"added\": {}}]', 12, 1),
(19, '2022-09-14 01:37:32.843950', '2', 'Empleado', 1, '[{\"added\": {}}]', 12, 1),
(20, '2022-09-14 01:38:15.279302', '2', 'Registrar Pedido', 1, '[{\"added\": {}}]', 10, 1),
(21, '2022-09-14 01:38:34.013552', '3', 'Cliente', 1, '[{\"added\": {}}]', 12, 1),
(22, '2022-09-14 01:39:09.230398', '1', 'En Espera', 1, '[{\"added\": {}}]', 13, 1),
(23, '2022-09-14 01:39:17.607673', '2', 'Entregado', 1, '[{\"added\": {}}]', 13, 1),
(24, '2022-09-14 01:39:27.466891', '3', 'Cancelado', 1, '[{\"added\": {}}]', 13, 1),
(25, '2022-09-14 01:40:51.389892', '124314', 'Sneider', 1, '[{\"added\": {}}]', 14, 1),
(26, '2022-09-14 01:41:20.906229', '4123421', 'Juan', 1, '[{\"added\": {}}]', 14, 1),
(27, '2022-09-14 01:42:46.790138', '341231', 'Brayan', 1, '[{\"added\": {}}]', 15, 1),
(28, '2022-09-14 01:44:18.545483', '535464', 'Felipe', 1, '[{\"added\": {}}]', 15, 1),
(29, '2022-09-14 01:45:45.083214', '45345', 'Maria', 1, '[{\"added\": {}}]', 15, 1),
(30, '2022-09-14 01:46:16.690218', '1', 'Maria', 1, '[{\"added\": {}}]', 8, 1),
(31, '2022-09-14 01:49:51.475457', '222', 'Chocolatina', 1, '[{\"added\": {}}]', 11, 1),
(32, '2022-09-14 01:52:54.991140', '333', 'Arroz', 1, '[{\"added\": {}}]', 11, 1),
(33, '2022-09-14 02:00:37.114974', '1', '1', 1, '[{\"added\": {}}]', 17, 1),
(34, '2022-09-14 02:03:39.558746', '1', '1', 1, '[{\"added\": {}}]', 9, 1),
(35, '2022-09-14 02:03:57.771773', '1', '1', 1, '[{\"added\": {}}]', 16, 1),
(36, '2022-09-14 02:05:01.098205', '1', '1', 1, '[{\"added\": {}}]', 19, 1),
(37, '2022-09-14 02:05:10.564297', '1', '1', 2, '[{\"changed\": {\"fields\": [\"State domicile\"]}}]', 19, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(2, 'admin', 'logentry'),
(1, 'admin_interface', 'theme'),
(4, 'auth', 'group'),
(3, 'auth', 'permission'),
(5, 'auth', 'Profile'),
(6, 'contenttypes', 'contenttype'),
(8, 'core', 'client'),
(19, 'core', 'delivery'),
(18, 'core', 'inventorymovement'),
(9, 'core', 'order'),
(10, 'core', 'permissions'),
(11, 'core', 'product'),
(17, 'core', 'purchase'),
(12, 'core', 'rol'),
(16, 'core', 'sales'),
(13, 'core', 'statedomicile'),
(14, 'core', 'supplier'),
(15, 'core', 'Profile'),
(7, 'sessions', 'session');

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
) ENGINE=InnoDB AUTO_INCREMENT=45 ;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-09-12 20:47:15.156982'),
(2, 'auth', '0001_initial', '2022-09-12 20:47:28.735927'),
(3, 'admin', '0001_initial', '2022-09-12 20:47:31.434415'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-09-12 20:47:31.477364'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-09-12 20:47:31.509039'),
(6, 'admin_interface', '0001_initial', '2022-09-12 20:47:31.906207'),
(7, 'admin_interface', '0002_add_related_modal', '2022-09-12 20:47:33.546282'),
(8, 'admin_interface', '0003_add_logo_color', '2022-09-12 20:47:33.930257'),
(9, 'admin_interface', '0004_rename_title_color', '2022-09-12 20:47:34.111984'),
(10, 'admin_interface', '0005_add_recent_actions_visible', '2022-09-12 20:47:34.538490'),
(11, 'admin_interface', '0006_bytes_to_str', '2022-09-12 20:47:34.656209'),
(12, 'admin_interface', '0007_add_favicon', '2022-09-12 20:47:34.965249'),
(13, 'admin_interface', '0008_change_related_modal_background_opacity_type', '2022-09-12 20:47:35.871617'),
(14, 'admin_interface', '0009_add_enviroment', '2022-09-12 20:47:36.469289'),
(15, 'admin_interface', '0010_add_localization', '2022-09-12 20:47:36.533067'),
(16, 'admin_interface', '0011_add_environment_options', '2022-09-12 20:47:37.514334'),
(17, 'admin_interface', '0012_update_verbose_names', '2022-09-12 20:47:37.546310'),
(18, 'admin_interface', '0013_add_related_modal_close_button', '2022-09-12 20:47:37.898602'),
(19, 'admin_interface', '0014_name_unique', '2022-09-12 20:47:38.335939'),
(20, 'admin_interface', '0015_add_language_chooser_active', '2022-09-12 20:47:38.666562'),
(21, 'admin_interface', '0016_add_language_chooser_display', '2022-09-12 20:47:39.114390'),
(22, 'admin_interface', '0017_change_list_filter_dropdown', '2022-09-12 20:47:39.189480'),
(23, 'admin_interface', '0018_theme_list_filter_sticky', '2022-09-12 20:47:39.487595'),
(24, 'admin_interface', '0019_add_form_sticky', '2022-09-12 20:47:40.277087'),
(25, 'admin_interface', '0020_module_selected_colors', '2022-09-12 20:47:40.970381'),
(26, 'admin_interface', '0021_file_extension_validator', '2022-09-12 20:47:41.034334'),
(27, 'admin_interface', '0022_add_logo_max_width_and_height', '2022-09-12 20:47:43.146552'),
(28, 'admin_interface', '0023_theme_foldable_apps', '2022-09-12 20:47:43.637413'),
(29, 'admin_interface', '0024_remove_theme_css', '2022-09-12 20:47:44.735740'),
(30, 'contenttypes', '0002_remove_content_type_name', '2022-09-12 20:47:46.506657'),
(31, 'auth', '0002_alter_permission_name_max_length', '2022-09-12 20:47:47.658350'),
(32, 'auth', '0003_alter_Profile_email_max_length', '2022-09-12 20:47:47.946697'),
(33, 'auth', '0004_alter_Profile_Profilename_opts', '2022-09-12 20:47:48.010839'),
(34, 'auth', '0005_alter_Profile_last_login_null', '2022-09-12 20:47:48.991663'),
(35, 'auth', '0006_require_contenttypes_0002', '2022-09-12 20:47:49.045102'),
(36, 'auth', '0007_alter_validators_add_error_messages', '2022-09-12 20:47:49.103434'),
(37, 'auth', '0008_alter_Profile_Profilename_max_length', '2022-09-12 20:47:50.111712'),
(38, 'auth', '0009_alter_Profile_last_name_max_length', '2022-09-12 20:47:51.157762'),
(39, 'auth', '0010_alter_group_name_max_length', '2022-09-12 20:47:51.263691'),
(40, 'auth', '0011_update_proxy_permissions', '2022-09-12 20:47:51.317261'),
(41, 'auth', '0012_alter_Profile_first_name_max_length', '2022-09-12 20:47:52.341079'),
(42, 'core', '0001_initial', '2022-09-12 20:48:19.605287'),
(43, 'sessions', '0001_initial', '2022-09-12 20:48:20.330420'),
(44, 'core', '0002_alter_statedomicile_table', '2022-09-12 20:49:41.045085');

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
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('aiy1r5g6re08a6u70i4s5ooluqvgzzsl', '.eJxVjEEOwiAURO_C2pDwgQ-4dO8ZCPBBqgaS0q4a726bdKGZ3bw3szEf1qX6deTZT8SuTLDLbxdDeuV2AHqG9ug89bbMU-SHwk86-L1Tft9O9--ghlH3dVEmu4xgkazWJSUEICAjtENQ2gqwuqBUSAGiQCeTldI5sycixMw-X8GfNrU:1oXqmP:9yWR6_8RpceET1I0JefJrn_ud-KGk2O--k63sC_TwdE', '2022-09-26 21:15:45.105618');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domicilio`
--

DROP TABLE IF EXISTS `domicilio`;
CREATE TABLE IF NOT EXISTS `domicilio` (
  `cod_delivery` int NOT NULL,
  `date` date NOT NULL,
  `code_order_id` int NOT NULL,
  `id_Profile_id` int NOT NULL,
  `state_domicile_id` int NOT NULL,
  PRIMARY KEY (`cod_delivery`),
  KEY `domicilio_code_order_id_e0182877_fk_orden_cod_order` (`code_order_id`),
  KEY `domicilio_id_Profile_id_a715c4af_fk_usuario_id_Profile` (`id_Profile_id`),
  KEY `domicilio_state_domicile_id_c253e78e_fk_estado_do` (`state_domicile_id`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `domicilio`
--

INSERT INTO `domicilio` (`cod_delivery`, `date`, `code_order_id`, `id_Profile_id`, `state_domicile_id`) VALUES
(1, '2022-09-13', 1, 535464, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_domicilio`
--

DROP TABLE IF EXISTS `estado_domicilio`;
CREATE TABLE IF NOT EXISTS `estado_domicilio` (
  `cod_state_domicile` int NOT NULL,
  `name_state` varchar(20) NOT NULL,
  PRIMARY KEY (`cod_state_domicile`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `estado_domicilio`
--

INSERT INTO `estado_domicilio` (`cod_state_domicile`, `name_state`) VALUES
(1, 'En Espera'),
(2, 'Entregado'),
(3, 'Cancelado');

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
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

DROP TABLE IF EXISTS `orden`;
CREATE TABLE IF NOT EXISTS `orden` (
  `cod_order` int NOT NULL,
  `date_order` date NOT NULL,
  `full_value` double NOT NULL,
  `cod_client_id` int NOT NULL,
  PRIMARY KEY (`cod_order`),
  KEY `orden_cod_client_id_b2760147_fk_cliente_cod_client` (`cod_client_id`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`cod_order`, `date_order`, `full_value`, `cod_client_id`) VALUES
(1, '2022-09-13', 30000, 1);

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
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permission`, `description`, `date_creation`, `state`) VALUES
(1, 'Registrar Ventas', '2022-09-13', 1),
(2, 'Registrar Pedido', '2022-09-13', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `cod_product` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `price_product` double NOT NULL,
  `net_content` varchar(15) NOT NULL,
  `product_image` varchar(100) NOT NULL,
  `stock` smallint NOT NULL,
  `state` tinyint(1) NOT NULL,
  PRIMARY KEY (`cod_product`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`cod_product`, `name`, `brand`, `price_product`, `net_content`, `product_image`, `stock`, `state`) VALUES
(222, 'Chocolatina', 'Colombina', 3000, '50 gr', 'chocolate.jpg', 30, 1),
(333, 'Arroz', 'Diana', 1500, '500 gr', 'arroz.jpg', 50, 1);

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
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`cod_supplier`, `name_supplier`, `enterprise`, `telephone_number`) VALUES
(124314, 'Sneider', 'Cilantro S.A', 31254321),
(4123421, 'Juan', 'Colombina', 32054321);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `cod_rol` int NOT NULL,
  `name_rol` varchar(20) NOT NULL,
  PRIMARY KEY (`cod_rol`)
) ENGINE=InnoDB ;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `rol_id_permission`
--

INSERT INTO `rol_id_permission` (`id`, `rol_id`, `permissions_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_Profile` int NOT NULL,
  `name` varchar(40) NOT NULL,
  `surname` varchar(40) NOT NULL,
  `second_surname` varchar(40) NOT NULL,
  `birthdate` date NOT NULL,
  `gender` varchar(9) NOT NULL,
  `telephone_number` bigint NOT NULL,
  `address` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `Profile_password` varchar(20) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `cod_rol_id` int NOT NULL,
  PRIMARY KEY (`id_Profile`),
  KEY `usuario_cod_rol_id_bc97cb6e_fk_rol_cod_rol` (`cod_rol_id`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_Profile`, `name`, `surname`, `second_surname`, `birthdate`, `gender`, `telephone_number`, `address`, `email`, `Profile_password`, `state`, `cod_rol_id`) VALUES
(45345, 'Maria', 'Robledo', 'Murcia', '2003-09-13', 'Femenino', 3215349, 'Calle 80', 'maria@gmail.com', 'Mari2354', 1, 3),
(341231, 'Brayan', 'Ramos', 'Quiñones', '2000-09-13', 'Masculino', 312254323, 'Calle 70 # 40', 'brayan@gmail.com', 'elbrayan777', 1, 1),
(535464, 'Felipe', 'Plata', 'Holguin', '2004-09-13', 'Masculino', 311542352, 'Calle 100 # 80', 'felipe@gmail.com', 'felipe354', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
  `cod_sale` int NOT NULL,
  `date_sale` date NOT NULL,
  `full_value` double NOT NULL,
  `cod_client_id` int NOT NULL,
  `cod_order_id` int DEFAULT NULL,
  `id_Profile_id` int NOT NULL,
  PRIMARY KEY (`cod_sale`),
  KEY `venta_cod_client_id_eb0190fb_fk_cliente_cod_client` (`cod_client_id`),
  KEY `venta_cod_order_id_1bd7ca74_fk_orden_cod_order` (`cod_order_id`),
  KEY `venta_id_Profile_id_d3bd0ca1_fk_usuario_id_Profile` (`id_Profile_id`)
) ENGINE=InnoDB ;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`cod_sale`, `date_sale`, `full_value`, `cod_client_id`, `cod_order_id`, `id_Profile_id`) VALUES
(1, '2022-09-13', 30000, 1, 1, 535464);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_cod_product`
--

DROP TABLE IF EXISTS `venta_cod_product`;
CREATE TABLE IF NOT EXISTS `venta_cod_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sales_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `venta_cod_product_sales_id_product_id_707686c1_uniq` (`sales_id`,`product_id`),
  KEY `venta_cod_product_product_id_4c982e15_fk_producto_cod_product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `venta_cod_product`
--

INSERT INTO `venta_cod_product` (`id`, `sales_id`, `product_id`) VALUES
(2, 1, 222),
(1, 1, 333);

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
  ADD CONSTRAINT `cliente_id_Profile_id_6013e780_fk_usuario_id_Profile` FOREIGN KEY (`id_Profile_id`) REFERENCES `usuario` (`id_Profile`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_id_Profile_id_ca50bbd4_fk_usuario_id_Profile` FOREIGN KEY (`id_Profile_id`) REFERENCES `usuario` (`id_Profile`),
  ADD CONSTRAINT `compra_supplier_id_546e2c3c_fk_proveedor_cod_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `proveedor` (`cod_supplier`);

--
-- Filtros para la tabla `compra_cod_product`
--
ALTER TABLE `compra_cod_product`
  ADD CONSTRAINT `compra_cod_product_product_id_aa12324a_fk_producto_cod_product` FOREIGN KEY (`product_id`) REFERENCES `producto` (`cod_product`),
  ADD CONSTRAINT `compra_cod_product_purchase_id_3a996ba6_fk_compra_cod_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `compra` (`cod_purchase`);

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
  ADD CONSTRAINT `domicilio_code_order_id_e0182877_fk_orden_cod_order` FOREIGN KEY (`code_order_id`) REFERENCES `orden` (`cod_order`),
  ADD CONSTRAINT `domicilio_id_Profile_id_a715c4af_fk_usuario_id_Profile` FOREIGN KEY (`id_Profile_id`) REFERENCES `usuario` (`id_Profile`),
  ADD CONSTRAINT `domicilio_state_domicile_id_c253e78e_fk_estado_do` FOREIGN KEY (`state_domicile_id`) REFERENCES `estado_domicilio` (`cod_state_domicile`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_cod_product_id_844b028c_fk_producto_cod_product` FOREIGN KEY (`cod_product_id`) REFERENCES `producto` (`cod_product`);

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_cod_client_id_b2760147_fk_cliente_cod_client` FOREIGN KEY (`cod_client_id`) REFERENCES `cliente` (`cod_client`);

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
  ADD CONSTRAINT `usuario_cod_rol_id_bc97cb6e_fk_rol_cod_rol` FOREIGN KEY (`cod_rol_id`) REFERENCES `rol` (`cod_rol`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_cod_client_id_eb0190fb_fk_cliente_cod_client` FOREIGN KEY (`cod_client_id`) REFERENCES `cliente` (`cod_client`),
  ADD CONSTRAINT `venta_cod_order_id_1bd7ca74_fk_orden_cod_order` FOREIGN KEY (`cod_order_id`) REFERENCES `orden` (`cod_order`),
  ADD CONSTRAINT `venta_id_Profile_id_d3bd0ca1_fk_usuario_id_Profile` FOREIGN KEY (`id_Profile_id`) REFERENCES `usuario` (`id_Profile`);

--
-- Filtros para la tabla `venta_cod_product`
--
ALTER TABLE `venta_cod_product`
  ADD CONSTRAINT `venta_cod_product_product_id_4c982e15_fk_producto_cod_product` FOREIGN KEY (`product_id`) REFERENCES `producto` (`cod_product`),
  ADD CONSTRAINT `venta_cod_product_sales_id_00afa237_fk_venta_cod_sale` FOREIGN KEY (`sales_id`) REFERENCES `venta` (`cod_sale`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
