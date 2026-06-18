-- Tabla Clientes:

CREATE TABLE IF NOT EXISTS retail_dw.clientes (
    id_cliente INT64,
    nombre STRING,
    pais STRING
);

-- Tabla Productos:

CREATE TABLE IF NOT EXISTS retail_dw.productos (
    id_producto INT64,
    producto STRING,
    categoria STRING
);

-- Tabla Ventas:

CREATE TABLE IF NOT EXISTS retail_dw.ventas (
    id_venta INT64,
    fecha_venta DATE,
    id_cliente INT64,
    id_producto INT64,
    sucursal STRING,
    monto NUMERIC
);





