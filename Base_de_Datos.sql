-- Usuarios
CREATE TABLE Usuarios (
    cedula VARCHAR(20) CONSTRAINT PK_Cedula_Usuarios PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- Proveedores
CREATE TABLE Proveedores (
    id INT IDENTITY(1,1) CONSTRAINT PK_ID_Proveedores PRIMARY KEY,
    nombre VARCHAR(50),
    nom_producto VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    descripcion VARCHAR(80)
);

-- Clientes
CREATE TABLE Clientes (
    cedula VARCHAR(20) CONSTRAINT PK_Cedula_Clientes PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20),
    empresa VARCHAR(50),
    correo VARCHAR(100)
);

CREATE TABLE DireccionesClientes (
    id_direccion INT IDENTITY(1,1) CONSTRAINT PK_ID_DireccionesClientes PRIMARY KEY,
    cedula_cliente VARCHAR(20),
    direccion VARCHAR(80),
    CONSTRAINT FK_Cedula_Clientes_DireccionesClientes FOREIGN KEY (cedula_cliente) REFERENCES Clientes(cedula)
);

CREATE TABLE DireccionesProveedores (
    id_direccion INT IDENTITY(1,1) CONSTRAINT PK_ID_DireccionesProveedores PRIMARY KEY,
    id_proveedor INT,
    direccion VARCHAR(80),
    CONSTRAINT FK_ID_Proveedores_DireccionesProveedores FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id)
);

CREATE TABLE ContactosClientes (
    id_contacto INT IDENTITY(1,1) CONSTRAINT PK_ID_ContactosClientes PRIMARY KEY,
    cedula_cliente VARCHAR(20),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    CONSTRAINT FK_Cedula_Clientes_ContactosClientes FOREIGN KEY (cedula_cliente) REFERENCES Clientes(cedula)
);

CREATE TABLE ContactosProveedores (
    id_contacto INT IDENTITY(1,1) CONSTRAINT PK_ID_ContactosProveedores PRIMARY KEY,
    id_proveedor INT,
    telefono VARCHAR(20),
    correo VARCHAR(100),
    CONSTRAINT FK_ID_Proveedores_ContactosProveedores FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id)
);

CREATE TABLE ContactosUsuarios (
    id_contacto INT IDENTITY(1,1) CONSTRAINT PK_ID_ContactosUsuarios PRIMARY KEY,
    cedula_usuario VARCHAR(20),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    CONSTRAINT FK_Cedula_Usuarios_ContactosUsuarios FOREIGN KEY (cedula_usuario) REFERENCES Usuarios(cedula)
);


-- Facturas
CREATE TABLE Facturas (
    numero_venta INT CONSTRAINT PK_Numero_Venta_Facturas PRIMARY KEY,
    fecha DATETIME,
    monto DECIMAL(10, 2),
    cedula_cliente VARCHAR(20),
    cedula_usuario VARCHAR(20),
    CONSTRAINT FK_Cedula_Clientes_Facturas FOREIGN KEY (cedula_cliente) REFERENCES Clientes(cedula),
    CONSTRAINT FK_Cedula_Usuarios_Facturas FOREIGN KEY (cedula_usuario) REFERENCES Usuarios(cedula)
);

-- Ventas
CREATE TABLE Ventas (
    numero_venta INT CONSTRAINT PK_Numero_Venta_Ventas PRIMARY KEY,
    fecha DATETIME,
    monto DECIMAL(10, 2),
    medio_pago VARCHAR(50),
    cedula_cliente VARCHAR(20),
    cedula_usuario VARCHAR(20),
    CONSTRAINT FK_Cedula_Clientes_Ventas FOREIGN KEY (cedula_cliente) REFERENCES Clientes(cedula),
    CONSTRAINT FK_Cedula_Usuarios_Ventas FOREIGN KEY (cedula_usuario) REFERENCES Usuarios(cedula)
);

-- Productos
CREATE TABLE Productos (
    id_producto INT IDENTITY(1,1) CONSTRAINT PK_ID_Productos PRIMARY KEY,
    marca VARCHAR(50),
    tamanio VARCHAR(50),
    color VARCHAR(50),
    peso DECIMAL(5,2),
    precio DECIMAL(10,2),
    estilo VARCHAR(50),
    descripcion VARCHAR(80)
);

-- DetallesVenta (Nueva tabla para normalizar Ventas)
CREATE TABLE DetallesVenta (
    id_detalle INT IDENTITY(1,1) CONSTRAINT PK_ID_DetallesVenta PRIMARY KEY,
    numero_venta INT,
    id_producto INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    CONSTRAINT FK_Numero_Venta_DetallesVenta FOREIGN KEY (numero_venta) REFERENCES Ventas(numero_venta),
    CONSTRAINT FK_ID_Productos_DetallesVenta FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- CategoriasProductos
CREATE TABLE CategoriasProductos (
    id_categoria INT IDENTITY(1,1) CONSTRAINT PK_ID_CategoriasProductos PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(80)
);

-- Relaci�n entre productos y categor�as (si un producto puede tener varias categor�as)
CREATE TABLE ProductoCategoria (
    id_producto INT,
    id_categoria INT,
    CONSTRAINT PK_ID_ProductoCategoria PRIMARY KEY (id_producto, id_categoria),
    CONSTRAINT FK_ID_Productos_ProductoCategoria FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    CONSTRAINT FK_ID_CategoriasProductos_ProductoCategoria FOREIGN KEY (id_categoria) REFERENCES CategoriasProductos(id_categoria)
);

-- Inserci�n en Usuarios
INSERT INTO Usuarios (cedula, nombre, apellidos, telefono, correo) VALUES
('101010101', 'Ana', 'Mart�nez', '1234-5678', 'ana.martinez@example.com'),
('202020202', 'Luis', 'Gonz�lez', '8765-4321', 'luis.gonzalez@example.com');

-- Inserci�n en Clientes
INSERT INTO Clientes (cedula, nombre, telefono, empresa, correo) VALUES
('303030303', 'Don Hose', '2345-6789', 'AutosDeSegunda', 'contacto@autosdesegunda.com'),
('404040404', 'Corporacion De Ganaderos S.A.', '9876-5432', 'Corporacion De Ganaderos S.A.', 'contacto@Corporacion De Ganaderos S.A.com');

-- Inserci�n en Proveedores
INSERT INTO Proveedores (nombre, nom_producto, direccion, telefono, correo, descripcion) VALUES
('Accesorios Rojas', 'Tapacubos Toyota rojo 67mm', 'Calle la Ezperanza Esprza', '2345-6789', 'contacto@proveedoraOriente.com', 'Distribudor de aacesorios Toyota'),
('Importaciones del Oriente', 'Tapacubos Nissa plata de 63mm', 'Avenida no Vienvenida', '9876-5432', 'contacto@importacionesoriente12.com', 'Importadora de accesorios directos de china');

-- Inserci�n en ContactosClientes
INSERT INTO ContactosClientes (cedula_cliente, telefono, correo) VALUES
('303030303', '2345-6789', 'contacto@autosdesegunda.com'),
('404040404', '9876-5432', 'contacto@Corporacion De Ganaderos S.A.com');

-- Inserci�n en ContactosProveedores
INSERT INTO ContactosProveedores (id_proveedor, telefono, correo) VALUES
(1, '2345-6789', 'contacto@proveedoraOriente.com'),
(2, '9876-5432', 'contacto@importacionesoriente12.com');

-- Inserci�n en ContactosUsuarios
INSERT INTO ContactosUsuarios (cedula_usuario, telefono, correo) VALUES
('101010101', '1234-5678', 'ana.martinez@example.com'),
('202020202', '8765-4321', 'luis.gonzalez@example.com');

-- Inserci�n en DireccionesClientes
INSERT INTO DireccionesClientes (cedula_cliente, direccion) VALUES
('303030303', 'Calle 158, Cartago'),
('404040404', 'Avenida Principal 456, San Jose');

-- Inserci�n en DireccionesProveedores
INSERT INTO DireccionesProveedores (id_proveedor, direccion) VALUES
(1, 'Avenida Siempre Viva 789, Ciudad C'),
(2, 'Calle Nueva 123, Ciudad D');

-- Inserci�n en Facturas
INSERT INTO Facturas (numero_venta, fecha, monto, cedula_cliente, cedula_usuario) VALUES
(1, '2024-01-01 10:00:00', 500.00, '303030303', '101010101'),
(2, '2024-01-02 11:00:00', 750.00, '404040404', '202020202');

-- Inserci�n en Ventas
INSERT INTO Ventas (numero_venta, fecha, monto, medio_pago, cedula_cliente, cedula_usuario) VALUES
(1, '2024-01-01 10:00:00', 500.00, 'Efectivo', '303030303', '101010101'),
(2, '2024-01-02 11:00:00', 750.00, 'Tarjeta', '404040404', '202020202');

-- Inserci�n en Productos
INSERT INTO Productos (marca, tamanio, color, peso, precio, estilo, descripcion) VALUES
('Toyota', '67 mm', 'Rojo', 0.50, 100.00, 'Cl�sico', 'Tapacubos Estilo original color rojo de 67 mm 2000-2019'),
('Nissa', '63 mm', 'Plata', 0.67, 150.00, 'Moderno', 'Tapacubos Estilo B ,color plata de 63 mm 2007-2012');

-- Inserci�n en DetallesVenta
INSERT INTO DetallesVenta (numero_venta, id_producto, cantidad, precio) VALUES
(1, 1, 2, 100.00), -- Venta 1, Producto 1, 2 unidades
(2, 2, 3, 150.00); -- Venta 2, Producto 2, 3 unidades

-- Inserci�n en CategoriasProductos
INSERT INTO CategoriasProductos (nombre, descripcion) VALUES
('Tapacubos', 'Tapacubos para centro de rueda'),
('Toyota', 'Accesorio para autos marca Toyota'),
('NISSA', 'Accesorio para autos marca NIIISAN');

-- Inserci�n en Relaci�n Producto-Categor�a
INSERT INTO ProductoCategoria (id_producto, id_categoria) VALUES
(1, 1), -- Producto 1 en Categor�a 1
(1, 2), -- Producto 1 en Categor�a 2
(2, 1), -- Producto 2 en Categor�a 1
(2, 2); -- Producto 2 en Categor�a 2



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

--- Seleccionar todos los datos de la relaci�n Producto-Categor�a
SELECT * FROM ProductoCategoria;

------------------------------------------8. Realizar un total de 10 script de eliminaci�n y actualizaci�n de datos, (update, delete)con condiciones, sobre las entidades del proyecto,
----------------------------------------- demostrando el dominio de elementos DML.

------------------- Actualizar el nombre de un cliente
UPDATE Clientes
SET nombre = 'Nuevo Nombre'
WHERE cedula = '303030303';

------------------- Eliminar un cliente y sus direcciones asociadas

DELETE FROM DireccionesClientes
WHERE cedula_cliente = '404040404';

DELETE FROM ContactosClientes
WHERE cedula_cliente = '404040404';

DELETE FROM Clientes
WHERE cedula = '404040404';

------------------- Actualizar el tel�fono de un proveedor:

UPDATE ContactosProveedores
SET telefono = '1111-1111'
WHERE id_proveedor = 1;

UPDATE Proveedores
SET telefono = '1111-1111'
WHERE id = 1;


------------------- Eliminar un producto y sus detalles de venta asociados

DELETE FROM DetallesVenta
WHERE id_producto = 2;

DELETE FROM Productos
WHERE id_producto = 2;

------------------- Actualizar el correo electr�nico de un usuario

UPDATE ContactosUsuarios
SET correo = 'nuevo_correo@example.com'
WHERE cedula_usuario = '101010101';

UPDATE Usuarios
SET correo = 'nuevo_correo@example.com'
WHERE cedula = '101010101';

-------------------  Eliminar un contacto de proveedor espec�fico

DELETE FROM ContactosProveedores
WHERE id_contacto = 1;

------------------- Actualizar la descripci�n de un proveedor:

UPDATE Proveedores
SET descripcion = 'Nueva descripci�n'
WHERE id = 1;

------------------- Eliminar una categor�a de productos y sus relaciones asociadas:

DELETE FROM ProductoCategoria
WHERE id_categoria = 1;

DELETE FROM CategoriasProductos
WHERE id_categoria = 1;

-------------------  Actualizar la direcci�n de un cliente:

UPDATE DireccionesClientes
SET direccion = 'Nueva Direcci�n'
WHERE id_direccion = 1;

------------------- Eliminar una venta y sus detalles asociados:

DELETE FROM DetallesVenta
WHERE numero_venta = 1;

DELETE FROM Ventas
WHERE numero_venta = 1;


-----------------------9. Debe crear un m�nimo de consultas para reportes en los cuales se demuestre el uso de
-----------------------joins, condiciones y funciones de agregaci�n, (sentencias vistas en clase). 
-------------------------10. Cada una de las consultas anteriores debe est� formada por un m�nimo de 3 entidades, las
-------------------------consultas con uso de menos entidades no ser�n consideradas calificables



---------------Cantidad de productos vendidos por cliente:
SELECT c.nombre AS Nombre_Cliente, COUNT(dv.id_detalle) AS Cantidad_Productos_Vendidos
FROM Clientes c
JOIN Ventas v ON c.cedula = v.cedula_cliente
JOIN DetallesVenta dv ON v.numero_venta = dv.numero_venta
GROUP BY c.nombre;


------------------Total de ventas mensuales por usuario:
SELECT MONTH(v.fecha) AS Mes, YEAR(v.fecha) AS A�o, u.nombre AS Nombre_Usuario, SUM(v.monto) AS Total_Ventas
FROM Ventas v
JOIN Usuarios u ON v.cedula_usuario = u.cedula
GROUP BY MONTH(v.fecha), YEAR(v.fecha), u.nombre;


------------------Promedio de precio de los productos por categor�a:
SELECT cp.nombre AS Categoria, AVG(p.precio) AS Promedio_Precio
FROM CategoriasProductos cp
JOIN ProductoCategoria pc ON cp.id_categoria = pc.id_categoria
JOIN Productos p ON pc.id_producto = p.id_producto
GROUP BY cp.nombre;

------------------Total de ventas por marca de producto:
SELECT p.marca AS Marca, SUM(dv.cantidad) AS Total_Vendido
FROM Productos p
JOIN DetallesVenta dv ON p.id_producto = dv.id_producto
GROUP BY p.marca;


--------------------Total de ventas realizadas en efectivo por cliente:

SELECT c.nombre AS Nombre_Cliente, SUM(v.monto) AS Total_Ventas_Efectivo
FROM Clientes c
JOIN Ventas v ON c.cedula = v.cedula_cliente
WHERE v.medio_pago = 'Efectivo'
GROUP BY c.nombre;

------------------Precio m�ximo de los productos por marca:
SELECT p.marca AS Marca, MAX(p.precio) AS Precio_Maximo
FROM Productos p
GROUP BY p.marca;

---------------Cantidad de productos vendidos por categor�a:

SELECT cp.nombre AS Categoria, COUNT(dv.id_detalle) AS Cantidad_Productos_Vendidos
FROM CategoriasProductos cp
JOIN ProductoCategoria pc ON cp.id_categoria = pc.id_categoria
JOIN Productos p ON pc.id_producto = p.id_producto
JOIN DetallesVenta dv ON p.id_producto = dv.id_producto
GROUP BY cp.nombre;

---------------------Total de ventas por cliente y medio de pago

SELECT c.nombre AS Cliente, v.medio_pago AS Medio_de_Pago, SUM(v.monto) AS Total_Ventas
FROM Clientes c
JOIN Ventas v ON c.cedula = v.cedula_cliente
GROUP BY c.nombre, v.medio_pago;
