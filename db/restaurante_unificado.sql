-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 21-10-2025 a las 22:40:34
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `restaurante_unificado`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alineacion`
--

CREATE TABLE `alineacion` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_areas`
--

CREATE TABLE `catalogo_areas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_bancos`
--

CREATE TABLE `catalogo_bancos` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_categorias`
--

CREATE TABLE `catalogo_categorias` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_denominaciones`
--

CREATE TABLE `catalogo_denominaciones` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_folios`
--

CREATE TABLE `catalogo_folios` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `folio_actual` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_promos`
--

CREATE TABLE `catalogo_promos` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `monto` decimal(15,2) DEFAULT NULL,
  `activo` int(11) DEFAULT NULL,
  `visible_en_ticket` int(11) DEFAULT NULL,
  `tipo` text DEFAULT NULL,
  `regla` text DEFAULT NULL,
  `tipo_venta` text DEFAULT NULL,
  `creado_en` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_tarjetas`
--

CREATE TABLE `catalogo_tarjetas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_facturacion`
--

CREATE TABLE `clientes_facturacion` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `rfc` text DEFAULT NULL,
  `razon_social` text DEFAULT NULL,
  `correo` text DEFAULT NULL,
  `telefono` text DEFAULT NULL,
  `calle` text DEFAULT NULL,
  `numero_ext` text DEFAULT NULL,
  `numero_int` text DEFAULT NULL,
  `colonia` text DEFAULT NULL,
  `municipio` text DEFAULT NULL,
  `estado` text DEFAULT NULL,
  `pais` text DEFAULT NULL,
  `cp` text DEFAULT NULL,
  `regimen` text DEFAULT NULL,
  `uso_cfdi` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conekta_events`
--

CREATE TABLE `conekta_events` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `reference` text DEFAULT NULL,
  `event_type` text DEFAULT NULL,
  `conekta_event_id` text DEFAULT NULL,
  `payload` text DEFAULT NULL,
  `received_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conekta_payments`
--

CREATE TABLE `conekta_payments` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `reference` text DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `customer_name` text DEFAULT NULL,
  `customer_email` text DEFAULT NULL,
  `customer_phone` text DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `currency` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `payment_method` text DEFAULT NULL,
  `conekta_order_id` text DEFAULT NULL,
  `conekta_checkout_id` text DEFAULT NULL,
  `checkout_url` text DEFAULT NULL,
  `cart_snapshot` text DEFAULT NULL,
  `metadata` text DEFAULT NULL,
  `raw_order` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cortes_almacen`
--

CREATE TABLE `cortes_almacen` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `usuario_abre_id` int(11) DEFAULT NULL,
  `usuario_cierra_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cortes_almacen_detalle`
--

CREATE TABLE `cortes_almacen_detalle` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `corte_id` int(11) DEFAULT NULL,
  `insumo_id` int(11) DEFAULT NULL,
  `existencia_inicial` decimal(15,2) DEFAULT NULL,
  `entradas` decimal(15,2) DEFAULT NULL,
  `salidas` decimal(15,2) DEFAULT NULL,
  `mermas` decimal(15,2) DEFAULT NULL,
  `existencia_final` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `corte_caja`
--

CREATE TABLE `corte_caja` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `folio_inicio` int(11) DEFAULT NULL,
  `folio_fin` int(11) DEFAULT NULL,
  `total_folios` int(11) DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fondo_inicial` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `corte_caja_historial`
--

CREATE TABLE `corte_caja_historial` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `corte_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `datos_json` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desglose_corte`
--

CREATE TABLE `desglose_corte` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `corte_id` int(11) DEFAULT NULL,
  `denominacion` decimal(15,2) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `tipo_pago` text DEFAULT NULL,
  `denominacion_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas_detalle`
--

CREATE TABLE `entradas_detalle` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `entrada_id` int(11) DEFAULT NULL,
  `insumo_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(15,2) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas_insumo`
--

CREATE TABLE `entradas_insumo` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `folio` text DEFAULT NULL,
  `uuid` text DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL,
  `impuestos` decimal(15,2) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `fecha_emision` datetime DEFAULT NULL,
  `estado` text DEFAULT NULL,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_detalles`
--

CREATE TABLE `factura_detalles` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `factura_id` int(11) DEFAULT NULL,
  `ticket_detalle_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(15,2) DEFAULT NULL,
  `importe` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_tickets`
--

CREATE TABLE `factura_tickets` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `factura_id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fondo`
--

CREATE TABLE `fondo` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `monto` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `dia_semana` text DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `serie_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `unidad` text DEFAULT NULL,
  `existencia` decimal(15,2) DEFAULT NULL,
  `tipo_control` text DEFAULT NULL,
  `imagen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_accion`
--

CREATE TABLE `logs_accion` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `modulo` text DEFAULT NULL,
  `accion` text DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_asignaciones_mesas`
--

CREATE TABLE `log_asignaciones_mesas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `mesa_id` int(11) DEFAULT NULL,
  `mesero_anterior_id` int(11) DEFAULT NULL,
  `mesero_nuevo_id` int(11) DEFAULT NULL,
  `fecha_cambio` datetime DEFAULT NULL,
  `usuario_que_asigna_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_cancelaciones`
--

CREATE TABLE `log_cancelaciones` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `tipo` text DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `venta_detalle_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `motivo` text DEFAULT NULL,
  `total_anterior` decimal(15,2) DEFAULT NULL,
  `subtotal_detalle` decimal(15,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_mesas`
--

CREATE TABLE `log_mesas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `mesa_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_dia`
--

CREATE TABLE `menu_dia` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `precio` decimal(15,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesas`
--

CREATE TABLE `mesas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `estado` text DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `mesa_principal_id` int(11) DEFAULT NULL,
  `area` text DEFAULT NULL,
  `tiempo_ocupacion_inicio` datetime DEFAULT NULL,
  `estado_reserva` text DEFAULT NULL,
  `nombre_reserva` text DEFAULT NULL,
  `fecha_reserva` datetime DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `ticket_enviado` int(11) DEFAULT NULL,
  `alineacion_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mesas`
--

INSERT INTO `mesas` (`_consolidation_id`, `_source_database`, `_source_alias`, `_sync_timestamp`, `_record_hash`, `id`, `nombre`, `estado`, `capacidad`, `mesa_principal_id`, `area`, `tiempo_ocupacion_inicio`, `estado_reserva`, `nombre_reserva`, `fecha_reserva`, `usuario_id`, `area_id`, `ticket_enviado`, `alineacion_id`) VALUES
(1, 'restaurante', 'localhost_restaurante', '2025-09-21 23:54:27', 'e890f12550a4b1ccdbfa15bfaa41a789fb306b2710c239b43cc929379eb28454', 21, 'Mesa 10', 'libre', 4, NULL, 'Salón Principal', NULL, 'ninguna', NULL, NULL, 1, 1, 0, NULL),
(2, 'restaurante', 'localhost_restaurante', '2025-09-21 23:54:27', '899ad970d35650238591a04a02ec9569270b585252f1718e2eba072173d174b7', 22, 'Mesa 11', 'libre', 6, NULL, 'Salón Principal', NULL, 'ninguna', NULL, NULL, 1, 1, 0, NULL),
(3, 'restaurante', 'localhost_restaurante', '2025-09-21 23:54:27', '0f2282f810e0d03c793d224064c463dbf7fb38bd3fddcb060009e36ee329b99a', 23, 'Mesa 12', 'libre', 2, NULL, 'Terraza', NULL, 'ninguna', NULL, NULL, 1, 2, 0, NULL),
(4, 'restaurante', 'localhost_restaurante', '2025-09-21 23:54:27', '9eb2f504e82002189bcfbd0c8b6ac2a9c951fc7619dbf2f8758a2ac3aa1a7e33', 24, 'Mesa 13', 'libre', 8, NULL, 'Salón VIP', NULL, 'ninguna', NULL, NULL, 1, 3, 0, NULL),
(5, 'restaurante', 'localhost_restaurante', '2025-09-21 23:54:27', 'a5697a3a801226e0bf28731e677410f302ec5e7347eaca10abacf484c6a11ffb', 25, 'Mesa 14', 'libre', 4, NULL, 'Patio', NULL, 'ninguna', NULL, NULL, 1, 4, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_caja`
--

CREATE TABLE `movimientos_caja` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `corte_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `tipo_movimiento` text DEFAULT NULL,
  `monto` decimal(15,2) DEFAULT NULL,
  `motivo` text DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_insumos`
--

CREATE TABLE `movimientos_insumos` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `tipo` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `usuario_destino_id` int(11) DEFAULT NULL,
  `insumo_id` int(11) DEFAULT NULL,
  `cantidad` decimal(15,2) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `qr_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ofertas_dia`
--

CREATE TABLE `ofertas_dia` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `vigente` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `precio` decimal(15,2) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `existencia` int(11) DEFAULT NULL,
  `activo` int(11) DEFAULT NULL,
  `imagen` text DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`_consolidation_id`, `_source_database`, `_source_alias`, `_sync_timestamp`, `_record_hash`, `id`, `nombre`, `precio`, `descripcion`, `existencia`, `activo`, `imagen`, `categoria_id`) VALUES
(1, 'restaurante', 'localhost_restaurante', '2025-09-21 23:19:08', 'adf1b40ec9c83c0dd7b7b34834836d60e7af45560771bd80b970bccaf29e036a', 9006, 'Hamburguesa Clásica', 85.00, 'Hamburguesa con carne, lechuga, tomate y cebolla', 30, 1, NULL, 1),
(2, 'restaurante', 'localhost_restaurante', '2025-09-21 23:19:08', 'dafd83b538a3c24824b90c0d67aa09b0ceb13ffc48204a82b6b860c7aeff3caf', 9007, 'Ensalada César', 65.00, 'Lechuga romana, pollo, crutones y aderezo césar', 25, 1, NULL, 2),
(3, 'restaurante', 'localhost_restaurante', '2025-09-21 23:19:08', '4798dbeadaeb9d839d25f9ec5be63dcc7d3ff4a6f30ec0044a659eca76e9dc59', 9008, 'Pasta Alfredo', 95.00, 'Fettuccine con salsa alfredo y pollo', 20, 1, NULL, 3),
(4, 'restaurante', 'localhost_restaurante', '2025-09-21 23:19:08', '6aa3f2aaa71945faa7584dbbf97019af17a0de43ace4416e5ed3fb196cd91ecb', 9009, 'Tacos al Pastor', 45.00, 'Tacos de cerdo marinado con piña', 40, 1, NULL, 4),
(5, 'restaurante', 'localhost_restaurante', '2025-09-21 23:19:08', 'cbd5de2937cdfdb049e86afb6262e416adfb570192d1e9a1a372e12af19c4828', 9010, 'Café Americano', 25.00, 'Café negro americano', 100, 1, NULL, 5),
(6, 'restaurante_2', 'localhost_restaurante_2', '2025-09-21 23:19:08', 'd85ac9b15f356a0554ecb9303a9965be8def3a2965fcff58b67bf2ed8513ad44', 9006, 'Hamburguesa Clásica', 85.00, 'Hamburguesa con carne, lechuga, tomate y cebolla', 30, 1, NULL, 1),
(7, 'restaurante_2', 'localhost_restaurante_2', '2025-09-21 23:19:08', '21da6d7311295dfa010a669cdaccc24caf2b1410b9d5ef246636e6c36c4bf1b9', 9007, 'Ensalada César', 65.00, 'Lechuga romana, pollo, crutones y aderezo césar', 25, 1, NULL, 2),
(8, 'restaurante_2', 'localhost_restaurante_2', '2025-09-21 23:19:08', '106c59c54ed4b89bd6c37563e40d2ed9caaab8ac95d80f91bf7d67d8b3e5807e', 9008, 'Pasta Alfredo', 95.00, 'Fettuccine con salsa alfredo y pollo', 20, 1, NULL, 3),
(9, 'restaurante_2', 'localhost_restaurante_2', '2025-09-21 23:19:08', 'ec3acbd44087925df83f665e52071ec4c52925e42234dd2a640b831c30afa70b', 9009, 'Tacos al Pastor', 45.00, 'Tacos de cerdo marinado con piña', 40, 1, NULL, 4),
(10, 'restaurante_2', 'localhost_restaurante_2', '2025-09-21 23:19:08', '0049798dff391e78012f1e6b97f7fc8bb1352cd6f15067bea8c2b7f5d9ae1554', 9010, 'Café Americano', 25.00, 'Café negro americano', 100, 1, NULL, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `telefono` text DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `_record_hash` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`_consolidation_id`, `_source_database`, `_source_alias`, `_sync_timestamp`, `id`, `nombre`, `telefono`, `direccion`, `_record_hash`) VALUES
(11, 'restaurante', 'localhost_restaurante', '2025-09-22 00:24:28', 30, 'Verduras Frescas S.A.', '555-1001', 'Calle Verde 456, Mercado Central', 'a922608e616b93859ac90826a6e2ec6dcc545b4b52ebbe188d0a3f4a63cea900'),
(12, 'restaurante', 'localhost_restaurante', '2025-09-22 00:24:28', 31, 'Lácteos del Norte', '555-1002', 'Av. Láctea 789, Zona Industrial', '2c0165a0ad5490048718a96ab0f14847b5e985b212234553acf9a5e49de6ef45'),
(13, 'restaurante', 'localhost_restaurante', '2025-09-22 00:24:28', 32, 'Panadería Artesanal', '555-1003', 'Esquina Pan 321, Centro', 'e5904c8382a5d1e0ef14ea2503f96ba2612667003adb6c786f30c43865bd85aa'),
(14, 'restaurante', 'localhost_restaurante', '2025-09-22 00:24:28', 33, 'Pescados del Mar', '555-1004', 'Puerto 654, Zona Portuaria', '489f2eba584136cc707103c4e5afd92135cd820952bd0f08d38b961fa23d7918'),
(15, 'restaurante', 'localhost_restaurante', '2025-09-22 00:24:28', 34, 'Bebidas y Refrescos', '555-1005', 'Calle Refresco 987, Distribuidora', '5ae1c471e662d6b8ffd8f84de683dd8bdf5f17e65fd9420be5d47f366f34d4ec');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `qrs_insumo`
--

CREATE TABLE `qrs_insumo` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `token` text DEFAULT NULL,
  `json_data` text DEFAULT NULL,
  `estado` text DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL,
  `expiracion` datetime DEFAULT NULL,
  `pdf_envio` text DEFAULT NULL,
  `pdf_recepcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recetas`
--

CREATE TABLE `recetas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `insumo_id` int(11) DEFAULT NULL,
  `cantidad` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repartidores`
--

CREATE TABLE `repartidores` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `telefono` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutas`
--

CREATE TABLE `rutas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `path` text DEFAULT NULL,
  `tipo` text DEFAULT NULL,
  `grupo` text DEFAULT NULL,
  `orden` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `rfc` text DEFAULT NULL,
  `telefono` text DEFAULT NULL,
  `correo` text DEFAULT NULL,
  `web` text DEFAULT NULL,
  `activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `folio` int(11) DEFAULT NULL,
  `serie_id` int(11) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `descuento` decimal(15,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `monto_recibido` decimal(15,2) DEFAULT NULL,
  `tipo_pago` text DEFAULT NULL,
  `sede_id` int(11) DEFAULT NULL,
  `mesa_nombre` text DEFAULT NULL,
  `mesero_nombre` text DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `tiempo_servicio` int(11) DEFAULT NULL,
  `nombre_negocio` text DEFAULT NULL,
  `direccion_negocio` text DEFAULT NULL,
  `rfc_negocio` text DEFAULT NULL,
  `telefono_negocio` text DEFAULT NULL,
  `tipo_entrega` text DEFAULT NULL,
  `tarjeta_marca_id` int(11) DEFAULT NULL,
  `tarjeta_banco_id` int(11) DEFAULT NULL,
  `boucher` text DEFAULT NULL,
  `cheque_numero` text DEFAULT NULL,
  `cheque_banco_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_descuentos`
--

CREATE TABLE `ticket_descuentos` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `tipo` text DEFAULT NULL,
  `venta_detalle_id` int(11) DEFAULT NULL,
  `porcentaje` decimal(15,2) DEFAULT NULL,
  `monto` decimal(15,2) DEFAULT NULL,
  `motivo` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `catalogo_promo_id` int(11) DEFAULT NULL,
  `creado_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_detalles`
--

CREATE TABLE `ticket_detalles` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(15,2) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `nombre` text DEFAULT NULL,
  `usuario` text DEFAULT NULL,
  `contrasena` text DEFAULT NULL,
  `rol` text DEFAULT NULL,
  `activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_ruta`
--

CREATE TABLE `usuario_ruta` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `ruta_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `mesa_id` int(11) DEFAULT NULL,
  `repartidor_id` int(11) DEFAULT NULL,
  `tipo_entrega` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `estatus` text DEFAULT NULL,
  `entregado` int(11) DEFAULT NULL,
  `estado_entrega` text DEFAULT NULL,
  `fecha_asignacion` datetime DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  `seudonimo_entrega` text DEFAULT NULL,
  `foto_entrega` text DEFAULT NULL,
  `corte_id` int(11) DEFAULT NULL,
  `cajero_id` int(11) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `sede_id` int(11) DEFAULT NULL,
  `propina_efectivo` decimal(15,2) DEFAULT NULL,
  `propina_cheque` decimal(15,2) DEFAULT NULL,
  `propina_tarjeta` decimal(15,2) DEFAULT NULL,
  `promocion_id` int(11) DEFAULT NULL,
  `promocion_descuento` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles`
--

CREATE TABLE `venta_detalles` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(15,2) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL,
  `insumos_descargados` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `entregado_hr` datetime DEFAULT NULL,
  `estado_producto` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles_cancelados`
--

CREATE TABLE `venta_detalles_cancelados` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `venta_detalle_id_original` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(15,2) DEFAULT NULL,
  `insumos_descargados` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `entregado_hr` datetime DEFAULT NULL,
  `estado_producto` text DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `cancelado_por` int(11) DEFAULT NULL,
  `fecha_cancelacion` datetime DEFAULT NULL,
  `motivo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles_log`
--

CREATE TABLE `venta_detalles_log` (
  `_consolidation_id` bigint(20) NOT NULL,
  `_source_database` varchar(255) NOT NULL,
  `_source_alias` varchar(100) NOT NULL,
  `_sync_timestamp` datetime DEFAULT current_timestamp(),
  `_record_hash` varchar(64) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `venta_detalle_id` int(11) DEFAULT NULL,
  `estado_anterior` text DEFAULT NULL,
  `estado_nuevo` text DEFAULT NULL,
  `cambiado_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alineacion`
--
ALTER TABLE `alineacion`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_areas`
--
ALTER TABLE `catalogo_areas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_bancos`
--
ALTER TABLE `catalogo_bancos`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_categorias`
--
ALTER TABLE `catalogo_categorias`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_denominaciones`
--
ALTER TABLE `catalogo_denominaciones`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_folios`
--
ALTER TABLE `catalogo_folios`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_promos`
--
ALTER TABLE `catalogo_promos`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `catalogo_tarjetas`
--
ALTER TABLE `catalogo_tarjetas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `clientes_facturacion`
--
ALTER TABLE `clientes_facturacion`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `conekta_events`
--
ALTER TABLE `conekta_events`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `conekta_payments`
--
ALTER TABLE `conekta_payments`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `cortes_almacen`
--
ALTER TABLE `cortes_almacen`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `cortes_almacen_detalle`
--
ALTER TABLE `cortes_almacen_detalle`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `corte_caja`
--
ALTER TABLE `corte_caja`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `corte_caja_historial`
--
ALTER TABLE `corte_caja_historial`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `desglose_corte`
--
ALTER TABLE `desglose_corte`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `entradas_detalle`
--
ALTER TABLE `entradas_detalle`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `entradas_insumo`
--
ALTER TABLE `entradas_insumo`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `factura_detalles`
--
ALTER TABLE `factura_detalles`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `factura_tickets`
--
ALTER TABLE `factura_tickets`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `fondo`
--
ALTER TABLE `fondo`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `logs_accion`
--
ALTER TABLE `logs_accion`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `log_asignaciones_mesas`
--
ALTER TABLE `log_asignaciones_mesas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `log_cancelaciones`
--
ALTER TABLE `log_cancelaciones`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `log_mesas`
--
ALTER TABLE `log_mesas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `menu_dia`
--
ALTER TABLE `menu_dia`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `mesas`
--
ALTER TABLE `mesas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `movimientos_caja`
--
ALTER TABLE `movimientos_caja`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `movimientos_insumos`
--
ALTER TABLE `movimientos_insumos`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `ofertas_dia`
--
ALTER TABLE `ofertas_dia`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`);

--
-- Indices de la tabla `qrs_insumo`
--
ALTER TABLE `qrs_insumo`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `recetas`
--
ALTER TABLE `recetas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `rutas`
--
ALTER TABLE `rutas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `ticket_descuentos`
--
ALTER TABLE `ticket_descuentos`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `ticket_detalles`
--
ALTER TABLE `ticket_detalles`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `usuario_ruta`
--
ALTER TABLE `usuario_ruta`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `venta_detalles_cancelados`
--
ALTER TABLE `venta_detalles_cancelados`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- Indices de la tabla `venta_detalles_log`
--
ALTER TABLE `venta_detalles_log`
  ADD PRIMARY KEY (`_consolidation_id`),
  ADD KEY `idx_source_alias` (`_source_alias`),
  ADD KEY `idx_sync_timestamp` (`_sync_timestamp`),
  ADD KEY `idx_record_hash` (`_record_hash`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alineacion`
--
ALTER TABLE `alineacion`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_areas`
--
ALTER TABLE `catalogo_areas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_bancos`
--
ALTER TABLE `catalogo_bancos`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_categorias`
--
ALTER TABLE `catalogo_categorias`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_denominaciones`
--
ALTER TABLE `catalogo_denominaciones`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_folios`
--
ALTER TABLE `catalogo_folios`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_promos`
--
ALTER TABLE `catalogo_promos`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_tarjetas`
--
ALTER TABLE `catalogo_tarjetas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes_facturacion`
--
ALTER TABLE `clientes_facturacion`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `conekta_events`
--
ALTER TABLE `conekta_events`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `conekta_payments`
--
ALTER TABLE `conekta_payments`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cortes_almacen`
--
ALTER TABLE `cortes_almacen`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cortes_almacen_detalle`
--
ALTER TABLE `cortes_almacen_detalle`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `corte_caja`
--
ALTER TABLE `corte_caja`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `corte_caja_historial`
--
ALTER TABLE `corte_caja_historial`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `desglose_corte`
--
ALTER TABLE `desglose_corte`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entradas_detalle`
--
ALTER TABLE `entradas_detalle`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entradas_insumo`
--
ALTER TABLE `entradas_insumo`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `factura_detalles`
--
ALTER TABLE `factura_detalles`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `factura_tickets`
--
ALTER TABLE `factura_tickets`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fondo`
--
ALTER TABLE `fondo`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `logs_accion`
--
ALTER TABLE `logs_accion`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `log_asignaciones_mesas`
--
ALTER TABLE `log_asignaciones_mesas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `log_cancelaciones`
--
ALTER TABLE `log_cancelaciones`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `log_mesas`
--
ALTER TABLE `log_mesas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menu_dia`
--
ALTER TABLE `menu_dia`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mesas`
--
ALTER TABLE `mesas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `movimientos_caja`
--
ALTER TABLE `movimientos_caja`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `movimientos_insumos`
--
ALTER TABLE `movimientos_insumos`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ofertas_dia`
--
ALTER TABLE `ofertas_dia`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `qrs_insumo`
--
ALTER TABLE `qrs_insumo`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recetas`
--
ALTER TABLE `recetas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rutas`
--
ALTER TABLE `rutas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tickets`
--
ALTER TABLE `tickets`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ticket_descuentos`
--
ALTER TABLE `ticket_descuentos`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ticket_detalles`
--
ALTER TABLE `ticket_detalles`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_ruta`
--
ALTER TABLE `usuario_ruta`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_detalles_cancelados`
--
ALTER TABLE `venta_detalles_cancelados`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta_detalles_log`
--
ALTER TABLE `venta_detalles_log`
  MODIFY `_consolidation_id` bigint(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
