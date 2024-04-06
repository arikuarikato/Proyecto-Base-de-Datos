--- Usuarios
CREATE TABLE Usuarios (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

--- Proveedores
CREATE TABLE Proveedores (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50),
    nom_producto VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    descripcion VARCHAR(80)
);

--- Clientes
CREATE TABLE Clientes (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20),
    empresa VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE DireccionesClientes (
    id_direccion INT PRIMARY KEY IDENTITY(1,1),
    cedula_cliente VARCHAR(20) FOREIGN KEY REFERENCES Clientes(cedula),
    direccion VARCHAR(80)
);

CREATE TABLE DireccionesProveedores (
    id_direccion INT PRIMARY KEY IDENTITY(1,1),
    id_proveedor INT FOREIGN KEY REFERENCES Proveedores(id),
    direccion VARCHAR(80)
);

CREATE TABLE ContactosClientes (
    id_contacto INT PRIMARY KEY IDENTITY(1,1),
    cedula_cliente VARCHAR(20) FOREIGN KEY REFERENCES Clientes(cedula),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

CREATE TABLE ContactosProveedores (
    id_contacto INT PRIMARY KEY IDENTITY(1,1),
    id_proveedor INT FOREIGN KEY REFERENCES Proveedores(id),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

CREATE TABLE ContactosUsuarios (
    id_contacto INT PRIMARY KEY IDENTITY(1,1),
    cedula_usuario VARCHAR(20) FOREIGN KEY REFERENCES Usuarios(cedula),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);


--- Facturas
CREATE TABLE Facturas (
    numero_venta INT PRIMARY KEY,
    fecha DATETIME,
    monto DECIMAL(10, 2),
    cedula_cliente VARCHAR(20) FOREIGN KEY REFERENCES Clientes(cedula),
    cedula_usuario VARCHAR(20) FOREIGN KEY REFERENCES Usuarios(cedula)
);

--- Ventas
CREATE TABLE Ventas (
    numero_venta INT PRIMARY KEY,
    fecha DATETIME,
    monto DECIMAL(10, 2),
    medio_pago VARCHAR(50),
    cedula_cliente VARCHAR(20) FOREIGN KEY REFERENCES Clientes(cedula),
    cedula_usuario VARCHAR(20) FOREIGN KEY REFERENCES Usuarios(cedula)
);

--- Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    marca VARCHAR(50),
    tamanio VARCHAR(50),
    color VARCHAR(50),
    peso DECIMAL(5,2),
    precio DECIMAL(10,2),
    estilo VARCHAR(50),
    descripcion VARCHAR(80)
);

--- DetallesVenta (Nueva tabla para normalizar Ventas)
CREATE TABLE DetallesVenta (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    numero_venta INT FOREIGN KEY REFERENCES Ventas(numero_venta),
    id_producto INT FOREIGN KEY REFERENCES Productos(id_producto),
    cantidad INT,
    precio DECIMAL(10, 2)
);

--- CategoriasProductos
CREATE TABLE CategoriasProductos (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    descripcion VARCHAR(80)
);

--- Relación entre productos y categorías (si un producto puede tener varias categorías)
CREATE TABLE ProductoCategoria (
    id_producto INT FOREIGN KEY REFERENCES Productos(id_producto),
    id_categoria INT FOREIGN KEY REFERENCES CategoriasProductos(id_categoria),
    PRIMARY KEY (id_producto, id_categoria)
);

-----Insercion de datos 

--- Inserción en Usuarios
INSERT INTO Usuarios (cedula, nombre, apellidos, telefono, correo) VALUES
('101010101', 'Ana', 'Martínez', '1234-5678', 'ana.martinez@example.com'),
('202020202', 'Luis', 'González', '8765-4321', 'luis.gonzalez@example.com');

--- Inserción en Clientes
INSERT INTO Clientes (cedula, nombre, telefono, empresa, correo) VALUES
('303030303', 'Don Hose', '2345-6789', 'AutosDeSegunda', 'contacto@autosdesegunda.com'),
('404040404', 'Corporacion De Ganaderos S.A.', '9876-5432', 'Corporacion De Ganaderos S.A.', 'contacto@Corporacion De Ganaderos S.A.com');

--- Inserción en Proveedores
INSERT INTO Proveedores (nombre, nom_producto, direccion, telefono, correo, descripcion) VALUES
('Accesorios Rojas', 'Tapacubos Toyota rojo 67mm', 'Calle la Ezperanza Esprza', '2345-6789', 'contacto@proveedoraOriente.com', 'Distribudor de aacesorios Toyota'),
('Importaciones del Oriente', 'Tapacubos Nissa plata de 63mm', 'Avenida no Vienvenida', '9876-5432', 'contacto@importacionesoriente12.com', 'Importadora de accesorios directos de china');

--- Inserción en ContactosClientes
INSERT INTO ContactosClientes (cedula_cliente, telefono, correo) VALUES
('303030303', '2345-6789', 'contacto@autosdesegunda.com'),
('404040404', '9876-5432', 'contacto@corporacionganaderos.com');

--- Inserción en ContactosProveedores
INSERT INTO ContactosProveedores (id_proveedor, telefono, correo) VALUES
(1, '2345-6789', 'contacto@proveedoraOriente.com'),
(2, '9876-5432', 'contacto@importacionesoriente12.com');

--- Inserción en ContactosUsuarios
INSERT INTO ContactosUsuarios (cedula_usuario, telefono, correo) VALUES
('101010101', '1234-5678', 'ana.martinez@example.com'),
('202020202', '8765-4321', 'luis.gonzalez@example.com');

--- Inserción en DireccionesClientes
INSERT INTO DireccionesClientes (cedula_cliente, direccion) VALUES
('303030303', 'Calle 158, Cartago'),
('404040404', 'Avenida Principal 456, San Jose');

--- Inserción en DireccionesProveedores
INSERT INTO DireccionesProveedores (id_proveedor, direccion) VALUES
(1, 'Avenida Siempre Viva 789, Ciudad C'),
(2, 'Calle Nueva 123, Ciudad D');

--- Inserción en Facturas
INSERT INTO Facturas (numero_venta, fecha, monto, cedula_cliente, cedula_usuario) VALUES
(1, '2024-01-01 10:00:00', 500.00, '303030303', '101010101'),
(2, '2024-01-02 11:00:00', 750.00, '404040404', '202020202');

--- Inserción en Ventas
INSERT INTO Ventas (numero_venta, fecha, monto, medio_pago, cedula_cliente, cedula_usuario) VALUES
(1, '2024-01-01 10:00:00', 500.00, 'Efectivo', '303030303', '101010101'),
(2, '2024-01-02 11:00:00', 750.00, 'Tarjeta', '404040404', '202020202');

--- Inserción en Productos
INSERT INTO Productos (marca, tamanio, color, peso, precio, estilo, descripcion) VALUES
('Toyota', '67 mm', 'Rojo', 0.50, 100.00, 'Clásico', 'Tapacubos Estilo original color rojo de 67 mm 2000-2019'),
('Nissa', '63 mm', 'Plata', 0.67, 150.00, 'Moderno', 'Tapacubos Estilo B ,color plata de 63 mm 2007-2012');

--- Inserción en DetallesVenta
INSERT INTO DetallesVenta (numero_venta, id_producto, cantidad, precio) VALUES
(1, 1, 2, 100.00), -- Venta 1, Producto 1, 2 unidades
(2, 2, 3, 150.00); -- Venta 2, Producto 2, 3 unidades

--- Inserción en CategoriasProductos
INSERT INTO CategoriasProductos (nombre, descripcion) VALUES
('Tapacubos', 'Tapacubos para centro de rueda'),
('Toyota', 'Accesorio para autos marca Toyota'),
('NISSA', 'Accesorio para autos marca NIIISAN');

--- Inserción en Relación Producto-Categoría
INSERT INTO ProductoCategoria (id_producto, id_categoria) VALUES
(1, 1), -- Producto 1 en Categoría 1
(1, 2), -- Producto 2 en Categoría 2
(2, 1), -- Producto 2 en Categoría 2
(2, 2); -- Producto 2 en Categoría 2



----Consulta de los datos 

--- Seleccionar todos los datos de Usuarios
SELECT * FROM Usuarios;

--- Seleccionar todos los datos de Clientes
SELECT * FROM Clientes;

--- Seleccionar todos los datos de Facturas
SELECT * FROM Facturas;

--- Seleccionar todos los datos de Ventas
SELECT * FROM Ventas;

--- Seleccionar todos los datos de Productos
SELECT * FROM Productos;

--- Seleccionar todos los datos de DetallesVenta
SELECT * FROM DetallesVenta;

--- Seleccionar todos los datos de Proveedores
SELECT * FROM Proveedores;

--- Seleccionar todos los datos de Contactos clientes
SELECT c.nombre, cc.telefono, cc.correo
FROM ContactosClientes cc
JOIN Clientes c ON cc.cedula_cliente = c.cedula;

--- Seleccionar todos los datos de Contactos proveedores
SELECT p.nombre, cp.telefono, cp.correo
FROM ContactosProveedores cp
JOIN Proveedores p ON cp.id_proveedor = p.id;

--- Seleccionar todos los datos de Contactos Usarios
SELECT u.nombre, u.apellidos, cu.telefono, cu.correo
FROM ContactosUsuarios cu
JOIN Usuarios u ON cu.cedula_usuario = u.cedula;

--- Seleccionar todos los datos de Direcciones clientes
SELECT c.nombre, dc.direccion
FROM DireccionesClientes dc
JOIN Clientes c ON dc.cedula_cliente = c.cedula;

--- Seleccionar todos los datos de Direcciones proveedores

SELECT p.nombre, dp.direccion
FROM DireccionesProveedores dp
JOIN Proveedores p ON dp.id_proveedor = p.id;

--- Seleccionar todos los datos de CategoriasProductos
SELECT * FROM CategoriasProductos;

--- Seleccionar todos los datos de la relación Producto-Categoría
SELECT * FROM ProductoCategoria;




