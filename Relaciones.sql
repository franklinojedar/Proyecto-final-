USE el_mercadeo;

-- Relaciones de la tabla PRODUCTO
ALTER TABLE producto 
  ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_producto (id_categoria),
  ADD CONSTRAINT fk_producto_proveedor FOREIGN KEY (nit_proveedor) REFERENCES proveedor (nit);

-- Relaciones de la tabla VENTA
ALTER TABLE venta 
  ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  ADD CONSTRAINT fk_venta_cajero  FOREIGN KEY (id_cajero) REFERENCES cajero (id_cajero),
  ADD CONSTRAINT fk_venta_caja    FOREIGN KEY (numero_caja) REFERENCES caja (numero_caja),
  ADD CONSTRAINT fk_venta_metodo  FOREIGN KEY (id_metodo) REFERENCES metodo_pago (id_metodo);

-- Relaciones de la tabla DETALLE_VENTA
ALTER TABLE detalle_venta 
  ADD CONSTRAINT fk_detalle_venta_venta FOREIGN KEY (numero_factura) REFERENCES venta (numero_factura),
  ADD CONSTRAINT fk_detalle_venta_producto FOREIGN KEY (codigo_barras) REFERENCES producto (codigo_barras);