-- ============================================
-- 04_optimizacion.sql
-- Optimización con Particiones y Clustering
-- ============================================

-- 1. Tabla Particionada por fecha
CREATE TABLE retail_dw.ventas_particionadas
(
    id_venta INT64,
    fecha_venta DATE,
    id_cliente INT64,
    id_producto INT64,
    sucursal STRING,
    monto NUMERIC
)
PARTITION BY fecha_venta;

-- 2. Tabla con Partición + Clustering
CREATE TABLE retail_dw.ventas_cluster
(
    id_venta INT64,
    fecha_venta DATE,
    id_cliente INT64,
    id_producto INT64,
    sucursal STRING,
    monto NUMERIC
)
PARTITION BY fecha_venta
CLUSTER BY sucursal;

-- 3. Verificamos las tablas creadas
SELECT 
    table_name,
    table_type,
    creation_time
FROM retail_dw.INFORMATION_SCHEMA.TABLES
WHERE table_name LIKE 'ventas%'
ORDER BY table_name;

-- ============================================
-- 4. COMPARACIÓN DE RENDIMIENTO
-- ============================================

-- Consulta en tabla sin optimizar (ventas original)

SELECT 
    sucursal,
    COUNT(*) AS num_ventas,
    SUM(monto) AS total_ventas,
    AVG(monto) AS ticket_promedio
FROM retail_dw.ventas
WHERE fecha_venta BETWEEN '2026-01-01' AND '2026-06-01'
GROUP BY sucursal
ORDER BY total_ventas DESC;

-- Consulta en tabla PARTICIONADA (ventas_particionadas)

SELECT 
    sucursal,
    COUNT(*) AS num_ventas,
    SUM(monto) AS total_ventas,
    AVG(monto) AS ticket_promedio
FROM retail_dw.ventas_particionadas
WHERE fecha_venta BETWEEN '2026-01-01' AND '2026-06-01'
GROUP BY sucursal
ORDER BY total_ventas DESC;

-- Consulta en tabla (ventas_cluster)

SELECT 
    sucursal,
    COUNT(*) AS num_ventas,
    SUM(monto) AS total_ventas,
    AVG(monto) AS ticket_promedio
FROM retail_dw.ventas_cluster
WHERE fecha_venta BETWEEN '2026-01-01' AND '2026-06-01'
GROUP BY sucursal
ORDER BY total_ventas DESC;