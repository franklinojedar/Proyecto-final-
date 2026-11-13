DROP DATABASE IF EXISTS el_mercadeo;
CREATE DATABASE el_mercadeo
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE el_mercadeo;

-- 1. CATEGORIA_PRODUCTO
CREATE TABLE categoria_producto (
  id_categoria  INT         NOT NULL,
  nombre        VARCHAR(80) NOT NULL,
  CONSTRAINT pk_categoria_producto PRIMARY KEY (id_categoria),
  CONSTRAINT uq_categoria_producto_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

-- 2. PROVEEDOR
CREATE TABLE proveedor (
  nit       VARCHAR(15)  NOT NULL,
  nombre    VARCHAR(100) NOT NULL,
  telefono  VARCHAR(20)  NULL,
  CONSTRAINT pk_proveedor PRIMARY KEY (nit)
) ENGINE=InnoDB;

-- 3. PRODUCTO
CREATE TABLE producto (
  codigo_barras  VARCHAR(20)   NOT NULL,
  nombre         VARCHAR(100)  NOT NULL,
  precio_actual  DECIMAL(10,2) NOT NULL,
  stock          INT           NOT NULL DEFAULT 0,
  id_categoria   INT           NOT NULL,
  nit_proveedor  VARCHAR(15)   NOT NULL,
  CONSTRAINT pk_producto PRIMARY KEY (codigo_barras),
  CONSTRAINT ck_producto_precio CHECK (precio_actual > 0),
  CONSTRAINT ck_producto_stock CHECK (stock >= 0)
) ENGINE=InnoDB;

-- 4. CLIENTE
CREATE TABLE cliente (
  id_cliente        INT          NOT NULL,
  documento         VARCHAR(20)  NOT NULL,
  nombre            VARCHAR(100) NOT NULL,
  telefono          VARCHAR(20)  NULL,
  correo            VARCHAR(100) NULL,
  fecha_inscripcion DATE         NULL,
  CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT uq_cliente_documento UNIQUE (documento)
) ENGINE=InnoDB;

-- 5. CAJERO
CREATE TABLE cajero (
  id_cajero INT          NOT NULL,
  nombre    VARCHAR(100) NOT NULL,
  telefono  VARCHAR(20)  NULL,
  CONSTRAINT pk_cajero PRIMARY KEY (id_cajero)
) ENGINE=InnoDB;

-- 6. CAJA
CREATE TABLE caja (
  numero_caja INT         NOT NULL,
  ubicacion   VARCHAR(50) NOT NULL,
  CONSTRAINT pk_caja PRIMARY KEY (numero_caja)
) ENGINE=InnoDB;

-- 7. METODO_PAGO
CREATE TABLE metodo_pago (
  id_metodo INT         NOT NULL,
  tipo_pago VARCHAR(30) NOT NULL,
  CONSTRAINT pk_metodo_pago PRIMARY KEY (id_metodo),
  CONSTRAINT uq_metodo_pago_tipo UNIQUE (tipo_pago)
) ENGINE=InnoDB;

-- 8. VENTA
CREATE TABLE venta (
  numero_factura INT           NOT NULL,
  fecha          DATE          NOT NULL,
  hora           TIME          NOT NULL,
  total          DECIMAL(10,2) NOT NULL,
  id_cliente     INT           NULL,
  id_cajero      INT           NOT NULL,
  numero_caja    INT           NOT NULL,
  id_metodo      INT           NOT NULL,
  CONSTRAINT pk_venta PRIMARY KEY (numero_factura),
  CONSTRAINT ck_venta_total CHECK (total >= 0)
) ENGINE=InnoDB;

-- 9. DETALLE_VENTA
CREATE TABLE detalle_venta (
  numero_factura  INT           NOT NULL,
  codigo_barras   VARCHAR(20)   NOT NULL,
  cantidad        INT           NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  CONSTRAINT pk_detalle_venta PRIMARY KEY (numero_factura, codigo_barras),
  CONSTRAINT ck_detalle_venta_cantidad CHECK (cantidad > 0),
  CONSTRAINT ck_detalle_venta_precio CHECK (precio_unitario > 0)
) ENGINE=InnoDB;