USE el_mercadeo;

-- Insertar Categorías y Proveedores
INSERT INTO categoria_producto (id_categoria, nombre) VALUES
  (1, 'Víveres'),
  (2, 'Lácteos y Huevos');

INSERT INTO proveedor (nit, nombre, telefono) VALUES
  ('900111222', 'Distribuidores Diana', '6012223344'),
  ('900333444', 'Lácteos Alquería', '6013334455');

-- Insertar Productos
INSERT INTO producto (codigo_barras, nombre, precio_actual, stock, id_categoria, nit_proveedor) VALUES
  ('770111111', 'Arroz Diana 1kg', 4500, 120, 1, '900111222'),
  ('770222222', 'Frijol Rojo 500g', 5500, 50, 1, '900111222'),
  ('770333333', 'Leche Alquería 1L', 4200, 80, 2, '900333444'),
  ('770444444', 'Huevos AA x30', 16500, 30, 2, '900333444');

-- Insertar Clientes, Cajeros, Cajas y Métodos de Pago
INSERT INTO cliente (id_cliente, documento, nombre, telefono, correo, fecha_inscripcion) VALUES
  (101, '101234567', 'Juan Pérez', '3001234567', 'juan@correo.com', '2024-05-10'),
  (102, '109876543', 'Diana Castro', '3159876543', 'diana@correo.com', '2025-08-20');

INSERT INTO cajero (id_cajero, nombre, telefono) VALUES
  (501, 'María López', '3110001122'),
  (502, 'Pedro Ramírez', '3205556677');

INSERT INTO caja (numero_caja, ubicacion) VALUES
  (1, 'Entrada Principal'),
  (2, 'Pasillo Central');

INSERT INTO metodo_pago (id_metodo, tipo_pago) VALUES
  (1, 'Efectivo'),
  (2, 'Tarjeta de Crédito/Débito'),
  (3, 'Transferencia');

-- Insertar Ventas (Encabezados)
INSERT INTO venta (numero_factura, fecha, hora, total, id_cliente, id_cajero, numero_caja, id_metodo) VALUES
  (2001, '2026-11-12', '08:30:00', 14500, 101, 501, 1, 1),
  (2002, '2026-11-12', '09:15:00', 29100, 102, 502, 2, 2);

-- Insertar Detalle de Ventas (Productos facturados)
INSERT INTO detalle_venta (numero_factura, codigo_barras, cantidad, precio_unitario) VALUES
  (2001, '770111111', 2, 4500),
  (2001, '770222222', 1, 5500),
  (2002, '770333333', 3, 4200),
  (2002, '770444444', 1, 16500);

-- ------------------------------------------------------
-- CONSULTAS DE PRUEBA
-- ------------------------------------------------------

-- Prueba 1: Ver las facturas con el nombre del cliente y el cajero
SELECT v.numero_factura, v.fecha, c.nombre AS cliente, ca.nombre AS cajero, v.total
FROM venta v
LEFT JOIN cliente c ON c.id_cliente = v.id_cliente
JOIN cajero ca ON ca.id_cajero = v.id_cajero;

-- Prueba 2: Ver el detalle completo de la factura 2001 con los nombres de los productos
SELECT dv.numero_factura, p.nombre AS producto, dv.cantidad, dv.precio_unitario, (dv.cantidad * dv.precio_unitario) AS subtotal
FROM detalle_venta dv
JOIN producto p ON dv.codigo_barras = p.codigo_barras
WHERE dv.numero_factura = 2001;