-- ============================================
-- 05_materialized_view.sql
-- Materialized View para mejorar rendimiento
-- ============================================

-- 1. Creamos la Materialized View
CREATE MATERIALIZED VIEW retail_dw.mv_ventas_producto AS
SELECT
    id_producto,
    SUM(monto) total_ventas
FROM retail_dw.ventas
GROUP BY id_producto;

-- 2. Verificamos que se creó correctamente
SELECT 
    table_name,
    table_type,
    creation_time
FROM retail_dw.INFORMATION_SCHEMA.TABLES
WHERE table_name = 'mv_ventas_producto';

-- 3. Consultamos la Materialized View
SELECT *
FROM retail_dw.mv_ventas_producto
ORDER BY total_ventas DESC
LIMIT 10;

-- ============================================
-- COMPARACIÓN DE RENDIMIENTO
-- ============================================

-- Consulta  (sin Materialized View)

SELECT
    id_producto,
    SUM(monto) total_ventas
FROM retail_dw.ventas
GROUP BY id_producto
ORDER BY total_ventas DESC
LIMIT 10;

-- Consulta con Materialized View

SELECT
    id_producto,
    total_ventas
FROM retail_dw.mv_ventas_producto
ORDER BY total_ventas DESC
LIMIT 10;