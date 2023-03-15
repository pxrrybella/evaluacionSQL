#ISABELLA PARRY - COHORTE 4 (HAMILTON) - GENERATION

#Creacion de esquema y tablas
CREATE SCHEMA minimarketJose;

USE minimarketJose;

CREATE TABLE TipoProducto (
	tipoProducto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25)
);

CREATE TABLE Proveedor (
	proveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25),
    rut VARCHAR(15),
    correo VARCHAR(30),
    telefono INTEGER(10)
);

CREATE TABLE Producto (
	producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25),
    precio INTEGER,
    cantidad INTEGER,
    tipoProducto_id INTEGER NOT NULL,
    proveedor_id INTEGER NOT NULL
);

ALTER TABLE Producto
ADD FOREIGN KEY (tipoProducto_id) REFERENCES TipoProducto (tipoProducto_id);

ALTER TABLE Producto
ADD FOREIGN KEY (proveedor_id) REFERENCES Proveedor (proveedor_id);

#Creacion tabla relacional PRODUCTO-PROVEEDOR
CREATE TABLE ProductoProveedor (
	productoProveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	producto_id INTEGER NOT NULL,
    proveedor_id INTEGER NOT NULL
);

ALTER TABLE ProductoProveedor
ADD FOREIGN KEY (producto_id) REFERENCES Producto (producto_id);

ALTER TABLE ProductoProveedor
ADD FOREIGN KEY (proveedor_id) REFERENCES Proveedor (proveedor_id);

CREATE TABLE Boleta (
	boleta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nroBoleta BIGINT,
    fecha DATE,
    total INTEGER
);

#Tabla relacional que almacena cuántos productos se compraron en la boleta
CREATE TABLE ProductoBoleta (
	productoBoleta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	producto_id INTEGER NOT NULL,
    boleta_id INTEGER NOT NULL
);

ALTER TABLE ProductoBoleta
ADD FOREIGN KEY (boleta_id) REFERENCES Boleta (boleta_id);

ALTER TABLE ProductoBoleta
ADD FOREIGN KEY (producto_id) REFERENCES Producto (producto_id);

CREATE TABLE cajaDiario (
	cajaDiario_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha DATE,
    saldoInicial INTEGER,
    saldoFinal INTEGER
);

#Ingreso de datos a tablas
INSERT INTO TipoProducto (nombre) VALUES
("Verduras"),
("Congelados"),
("Helados"),
("Frutas"),
("Pan"),
("Confiteria"),
("Higiene"),
("Bebestibles")
;

INSERT INTO Proveedor (nombre, rut, correo, telefono) VALUES
("ProveedorUno", "11.111.111-1", "proveedor@uno.com", 999999999),
("ProveedorDos", "22.222.222-2", "proveedor@dos.com", 888888888),
("ProveedorTres", "33.333.333-3", "proveedor@tres.com", 777777777),
("ProveedorCuatro", "44.444.444-4", "proveedor@cuatro.com", 666666666)
;

INSERT INTO Producto (nombre, precio, cantidad, tipoProducto_id, proveedor_id) VALUES
("Chocolito", 390, 10, 3, 4),
("Cremino", 290, 15, 3, 4),
("Coca Cola 1L", 850, 30, 8, 2),
("Super 8", 200, 20, 6, 1),
("Golpe", 250, 20, 6, 1),
("Crapulitos", 150, 25, 6, 3),
("Pan de Molde Integral", 1790, 10, 5, 3),
("Toallas Ladysoft", 1590, 10, 7, 4),
("Sachet Head&Shoulders10ml", 200, 10, 7, 1)
;

INSERT INTO Boleta (nroBoleta, fecha,total) VALUES
(555888333111, '2022-03-01', 1850),
(777444555222, '2022-03-02', 9420),
(666555444333, '2022-06-12', 700),
(000999888777, '2022-06-12', 10780),
(777555666777, '2022-07-26', 500),
(333222444111, '2022-07-29', 8750),
(555666222111, '2022-07-29', 1350)
;

INSERT INTO Boleta (nroBoleta, fecha,total) VALUES
(111222333444, '2023-01-24', 2750),
(444555666777, '2023-01-24', 5260),
(777888999000, '2023-01-24', 1500),
(555111222333, '2023-01-25', 12300),
(666777333111, '2023-01-25', 1930),
(999888999000, '2023-01-26', 7250),
(333444111222, '2023-01-26', 850)
;

INSERT INTO ProductoBoleta (producto_id, boleta_id) VALUES
(3, 1),
(4, 1),
(1, 1),
(4, 2),
(4, 2),
(1, 2),
(5, 2),
(5, 2),
(1, 3),
(4, 3)
;

#Consultas a las tablas
SELECT producto.nombre, producto.precio, producto.cantidad
FROM producto
WHERE producto.tipoProducto_id = 7;

SELECT boleta.nroBoleta, boleta.fecha, boleta.total
FROM Boleta
WHERE boleta.total > 5000;

#Consultas a tablas usando JOIN
SELECT producto.nombre, producto.precio, producto.cantidad, proveedor.nombre
FROM producto JOIN proveedor ON producto.proveedor_id = proveedor.proveedor_id
WHERE proveedor.nombre = "ProveedorUno";

#Para la ganancia anual, acá entregará las ganancias del 2022
SELECT SUM(boleta.total)
FROM boleta
WHERE boleta.fecha < '2022-12-31' AND boleta.fecha > '2022-01-01';

#Para la ganancia anual, acá entregará las ganancias del 2023
SELECT SUM(boleta.total)
FROM boleta
WHERE boleta.fecha < '2023-12-31' AND boleta.fecha > '2023-01-01';