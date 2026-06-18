-- Top 10 Productos

SELECT
    p.producto,
    SUM(v.monto) total_ventas
FROM retail_dw.ventas v
JOIN retail_dw.productos p
ON v.id_producto = p.id_producto
GROUP BY p.producto
ORDER BY total_ventas DESC
LIMIT 10;

-- Ventas por País

SELECT
    c.pais,
    SUM(v.monto) total_ventas
FROM retail_dw.ventas v
JOIN retail_dw.clientes c
ON v.id_cliente = c.id_cliente
GROUP BY c.pais;

-- Ventas Mensuales

SELECT
    EXTRACT(MONTH FROM fecha_venta) mes,
    SUM(monto) ventas
FROM retail_dw.ventas
GROUP BY mes;