-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 21-10-2025 a las 22:40:10
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
-- Base de datos: `restaurante_espejo`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desarchivar_transaccion` (IN `p_ticket_id` INT)   BEGIN
  DECLARE v_src VARCHAR(64) DEFAULT 'restaurante_espejo';
  DECLARE v_venta_id INT;
  DECLARE v_dst_has_ticket_propinas INT DEFAULT 0;

  
  SET @sql = CONCAT('SELECT venta_id FROM ', v_src, '.tickets WHERE id=? LIMIT 1');
  PREPARE s0 FROM @sql; SET @p := p_ticket_id; EXECUTE s0 USING @p; DEALLOCATE PREPARE s0;

  
  SET @q = CONCAT('SELECT venta_id INTO @ven FROM ', v_src, '.tickets WHERE id=', p_ticket_id, ' LIMIT 1');
  PREPARE s0b FROM @q; EXECUTE s0b; DEALLOCATE PREPARE s0b;
  SET v_venta_id = @ven;
  SET @ven = NULL;

  IF v_venta_id IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ticket no existe en espejo';
  END IF;

  
  SET @ARCHIVE_MODE = 1;

  START TRANSACTION;

  

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.ventas ',
    'SELECT * FROM ', v_src, '.ventas WHERE id=?'
  );
  PREPARE s1 FROM @sql; SET @p := v_venta_id; EXECUTE s1 USING @p; DEALLOCATE PREPARE s1;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.venta_detalles ',
    '(id, venta_id, producto_id, cantidad, precio_unitario, insumos_descargados, created_at, entregado_hr, estado_producto, observaciones) ',
    'SELECT id, venta_id, producto_id, cantidad, precio_unitario, insumos_descargados, created_at, entregado_hr, estado_producto, observaciones ',
    'FROM ', v_src, '.venta_detalles WHERE venta_id=?'
  );
  PREPARE s2 FROM @sql; SET @p := v_venta_id; EXECUTE s2 USING @p; DEALLOCATE PREPARE s2;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.venta_detalles_log ',
    'SELECT * FROM ', v_src, '.venta_detalles_log ',
    'WHERE venta_detalle_id IN (SELECT id FROM ', v_src, '.venta_detalles WHERE venta_id=?)'
  );
  PREPARE s3 FROM @sql; SET @p := v_venta_id; EXECUTE s3 USING @p; DEALLOCATE PREPARE s3;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.venta_detalles_cancelados ',
    'SELECT * FROM ', v_src, '.venta_detalles_cancelados WHERE venta_id=?'
  );
  PREPARE s4 FROM @sql; SET @p := v_venta_id; EXECUTE s4 USING @p; DEALLOCATE PREPARE s4;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.tickets ',
    'SELECT * FROM ', v_src, '.tickets WHERE venta_id=?'
  );
  PREPARE s5 FROM @sql; SET @p := v_venta_id; EXECUTE s5 USING @p; DEALLOCATE PREPARE s5;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.ticket_detalles ',
    '(id, ticket_id, producto_id, cantidad, precio_unitario) ',
    'SELECT id, ticket_id, producto_id, cantidad, precio_unitario ',
    'FROM ', v_src, '.ticket_detalles ',
    'WHERE ticket_id IN (SELECT id FROM ', v_src, '.tickets WHERE venta_id=?)'
  );
  PREPARE s6 FROM @sql; SET @p := v_venta_id; EXECUTE s6 USING @p; DEALLOCATE PREPARE s6;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.ticket_descuentos ',
    '(id, ticket_id, tipo, venta_detalle_id, porcentaje, monto, motivo, usuario_id, catalogo_promo_id, creado_en) ',
    'SELECT id, ticket_id, tipo, venta_detalle_id, porcentaje, monto, motivo, usuario_id, catalogo_promo_id, creado_en ',
    'FROM ', v_src, '.ticket_descuentos ',
    'WHERE ticket_id IN (SELECT id FROM ', v_src, '.tickets WHERE venta_id=?)'
  );
  PREPARE s6b FROM @sql; SET @p := v_venta_id; EXECUTE s6b USING @p; DEALLOCATE PREPARE s6b;

  
  SELECT COUNT(*) INTO v_dst_has_ticket_propinas
  FROM information_schema.tables
  WHERE table_schema = 'restaurante' AND table_name = 'ticket_propinas';

  IF v_dst_has_ticket_propinas > 0 THEN
    BEGIN
      DECLARE CONTINUE HANDLER FOR 1146 BEGIN END;  
      SET @sql = CONCAT(
        'INSERT IGNORE INTO restaurante.ticket_propinas ',
        'SELECT * FROM ', v_src, '.ticket_propinas ',
        'WHERE ticket_id IN (SELECT id FROM ', v_src, '.tickets WHERE venta_id=?)'
      );
      PREPARE s6c FROM @sql; SET @p := v_venta_id; EXECUTE s6c USING @p; DEALLOCATE PREPARE s6c;
    END;
  END IF;

  
  SET @sql = CONCAT(
    'INSERT IGNORE INTO restaurante.log_cancelaciones ',
    'SELECT * FROM ', v_src, '.log_cancelaciones ',
    'WHERE venta_id=? OR venta_detalle_id IN (SELECT id FROM ', v_src, '.venta_detalles WHERE venta_id=?)'
  );
  PREPARE s7 FROM @sql; SET @p := v_venta_id; EXECUTE s7 USING @p, @p; DEALLOCATE PREPARE s7;

  COMMIT;
  SET @ARCHIVE_MODE = NULL;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_cancelaciones`
--

CREATE TABLE `log_cancelaciones` (
  `id` int(11) NOT NULL,
  `tipo` enum('venta','detalle') NOT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `venta_detalle_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `total_anterior` decimal(10,2) DEFAULT NULL,
  `subtotal_detalle` decimal(10,2) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `folio` int(11) NOT NULL,
  `serie_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `fecha` datetime DEFAULT current_timestamp(),
  `usuario_id` int(11) DEFAULT NULL,
  `monto_recibido` decimal(10,2) DEFAULT 0.00,
  `tipo_pago` enum('efectivo','boucher','cheque') DEFAULT 'efectivo',
  `sede_id` int(11) DEFAULT NULL,
  `mesa_nombre` varchar(50) DEFAULT NULL,
  `mesero_nombre` varchar(100) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `tiempo_servicio` int(11) DEFAULT NULL COMMENT 'Minutos de servicio',
  `nombre_negocio` varchar(100) DEFAULT NULL,
  `direccion_negocio` text DEFAULT NULL,
  `rfc_negocio` varchar(20) DEFAULT NULL,
  `telefono_negocio` varchar(20) DEFAULT NULL,
  `tipo_entrega` enum('mesa','domicilio','rapido') DEFAULT 'mesa',
  `tarjeta_marca_id` int(11) DEFAULT NULL,
  `tarjeta_banco_id` int(11) DEFAULT NULL,
  `boucher` varchar(50) DEFAULT NULL,
  `cheque_numero` varchar(50) DEFAULT NULL,
  `cheque_banco_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tickets`
--

INSERT INTO `tickets` (`id`, `venta_id`, `folio`, `serie_id`, `total`, `descuento`, `fecha`, `usuario_id`, `monto_recibido`, `tipo_pago`, `sede_id`, `mesa_nombre`, `mesero_nombre`, `fecha_inicio`, `fecha_fin`, `tiempo_servicio`, `nombre_negocio`, `direccion_negocio`, `rfc_negocio`, `telefono_negocio`, `tipo_entrega`, `tarjeta_marca_id`, `tarjeta_banco_id`, `boucher`, `cheque_numero`, `cheque_banco_id`) VALUES
(168, 145, 2042, NULL, 230.00, 23.00, '2025-08-30 21:28:29', NULL, 230.00, 'efectivo', 1, 'Venta rápida', 'Javier Emanuel lopez lozano', NULL, '2025-08-30 21:28:29', 0, 'Forestal', 'Blvd. Luis Donaldo Colosio #317, Fracc. La Forestal ', 'VEAJ9408188U9', '618 322 2352', 'rapido', NULL, NULL, NULL, NULL, NULL),
(173, 150, 2047, NULL, 404.00, 0.00, '2025-08-30 21:32:31', NULL, 500.00, 'efectivo', 1, 'Mesa 4', 'juan hernesto ortega Almanza', NULL, '2025-08-30 21:32:31', 0, 'Forestal', 'Blvd. Luis Donaldo Colosio #317, Fracc. La Forestal ', 'VEAJ9408188U9', '618 322 2352', 'mesa', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_descuentos`
--

CREATE TABLE `ticket_descuentos` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `tipo` enum('cortesia','porcentaje','monto_fijo') NOT NULL,
  `venta_detalle_id` int(11) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `motivo` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `catalogo_promo_id` int(11) NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ticket_descuentos`
--

INSERT INTO `ticket_descuentos` (`id`, `ticket_id`, `tipo`, `venta_detalle_id`, `porcentaje`, `monto`, `motivo`, `usuario_id`, `catalogo_promo_id`, `creado_en`) VALUES
(26, 168, 'porcentaje', NULL, 10.00, 23.00, NULL, NULL, 0, '2025-08-30 13:28:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticket_detalles`
--

CREATE TABLE `ticket_detalles` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `precio_unitario`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ticket_detalles`
--

INSERT INTO `ticket_detalles` (`id`, `ticket_id`, `producto_id`, `cantidad`, `precio_unitario`) VALUES
(247, 168, 15, 2, 115.00),
(255, 173, 17, 1, 119.00),
(256, 173, 39, 1, 165.00),
(257, 173, 123, 3, 40.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `mesa_id` int(11) DEFAULT NULL,
  `repartidor_id` int(11) DEFAULT NULL,
  `tipo_entrega` enum('mesa','domicilio','rapido') DEFAULT 'mesa',
  `usuario_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT 0.00,
  `estatus` enum('activa','cerrada','cancelada') DEFAULT 'activa',
  `entregado` tinyint(1) DEFAULT 0,
  `estado_entrega` enum('pendiente','en_camino','entregado') DEFAULT 'pendiente',
  `fecha_asignacion` datetime DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  `seudonimo_entrega` varchar(100) DEFAULT NULL,
  `foto_entrega` varchar(255) DEFAULT NULL,
  `corte_id` int(11) DEFAULT NULL,
  `cajero_id` int(11) DEFAULT NULL,
  `observacion` text DEFAULT NULL,
  `sede_id` int(11) DEFAULT NULL,
  `propina_efectivo` decimal(10,2) NOT NULL,
  `propina_cheque` decimal(10,2) NOT NULL,
  `propina_tarjeta` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `fecha`, `mesa_id`, `repartidor_id`, `tipo_entrega`, `usuario_id`, `total`, `estatus`, `entregado`, `estado_entrega`, `fecha_asignacion`, `fecha_inicio`, `fecha_entrega`, `seudonimo_entrega`, `foto_entrega`, `corte_id`, `cajero_id`, `observacion`, `sede_id`, `propina_efectivo`, `propina_cheque`, `propina_tarjeta`) VALUES
(145, '2025-08-30 13:23:24', NULL, NULL, 'rapido', 2, 230.00, 'cerrada', 0, 'pendiente', NULL, NULL, NULL, NULL, NULL, 67, 1, '', 1, 0.00, 0.00, 0.00),
(150, '2025-08-30 13:32:06', 4, NULL, 'mesa', 4, 404.00, 'cerrada', 0, 'pendiente', NULL, NULL, NULL, NULL, NULL, 67, 1, '', 1, 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles`
--

CREATE TABLE `venta_detalles` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `precio_unitario`) STORED,
  `insumos_descargados` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `entregado_hr` datetime DEFAULT NULL,
  `estado_producto` enum('pendiente','en_preparacion','listo','entregado') DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta_detalles`
--

INSERT INTO `venta_detalles` (`id`, `venta_id`, `producto_id`, `cantidad`, `precio_unitario`, `insumos_descargados`, `created_at`, `entregado_hr`, `estado_producto`, `observaciones`) VALUES
(282, 145, 15, 2, 115.00, 1, '2025-08-30 13:23:24', '2025-08-30 13:26:39', 'entregado', NULL),
(290, 150, 17, 1, 119.00, 1, '2025-08-30 13:32:06', '2025-08-30 13:32:12', 'entregado', NULL),
(291, 150, 39, 1, 165.00, 1, '2025-08-30 13:32:06', '2025-08-30 13:32:14', 'entregado', NULL),
(292, 150, 123, 3, 40.00, 1, '2025-08-30 13:32:06', '2025-08-30 13:32:16', 'entregado', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles_cancelados`
--

CREATE TABLE `venta_detalles_cancelados` (
  `id` int(11) NOT NULL,
  `venta_detalle_id_original` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `insumos_descargados` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `entregado_hr` datetime DEFAULT NULL,
  `estado_producto` enum('pendiente','en_preparacion','listo','entregado') DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL,
  `cancelado_por` int(11) DEFAULT NULL,
  `fecha_cancelacion` datetime DEFAULT current_timestamp(),
  `motivo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_detalles_log`
--

CREATE TABLE `venta_detalles_log` (
  `id` int(11) NOT NULL,
  `venta_detalle_id` int(11) NOT NULL,
  `estado_anterior` enum('pendiente','en_preparacion','listo','entregado') DEFAULT NULL,
  `estado_nuevo` enum('pendiente','en_preparacion','listo','entregado') NOT NULL,
  `cambiado_en` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `venta_detalles_log`
--

INSERT INTO `venta_detalles_log` (`id`, `venta_detalle_id`, `estado_anterior`, `estado_nuevo`, `cambiado_en`) VALUES
(343, 282, 'pendiente', 'en_preparacion', '2025-08-30 13:26:29'),
(352, 282, 'en_preparacion', 'listo', '2025-08-30 13:26:36'),
(356, 282, 'listo', 'entregado', '2025-08-30 13:26:39'),
(370, 290, 'pendiente', 'en_preparacion', '2025-08-30 13:32:09'),
(371, 291, 'pendiente', 'en_preparacion', '2025-08-30 13:32:10'),
(372, 292, 'pendiente', 'en_preparacion', '2025-08-30 13:32:11'),
(373, 290, 'en_preparacion', 'listo', '2025-08-30 13:32:11'),
(374, 290, 'listo', 'entregado', '2025-08-30 13:32:12'),
(375, 291, 'en_preparacion', 'listo', '2025-08-30 13:32:13'),
(376, 291, 'listo', 'entregado', '2025-08-30 13:32:14'),
(377, 292, 'en_preparacion', 'listo', '2025-08-30 13:32:15'),
(378, 292, 'listo', 'entregado', '2025-08-30 13:32:16');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `log_cancelaciones`
--
ALTER TABLE `log_cancelaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ticket_descuentos`
--
ALTER TABLE `ticket_descuentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ticket_detalles`
--
ALTER TABLE `ticket_detalles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `venta_detalles`
--
ALTER TABLE `venta_detalles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `venta_detalles_cancelados`
--
ALTER TABLE `venta_detalles_cancelados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `venta_detalles_log`
--
ALTER TABLE `venta_detalles_log`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
