-- Usuarios
CREATE TABLE Usuarios (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- Clientes
CREATE TABLE Clientes (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20),
    empresa VARCHAR(50),
    correo VARCHAR(100)
);

-- Facturas
CREATE TABLE Facturas (
    numero_venta INT PRIMARY KEY,
    fecha DATETIME,
    monto DECIMAL(10, 2),
    cedula_cliente VARCHAR(20) FOREIGN KEY REFERENCES Clientes(cedula),
    cedula_usuario VARCHAR(20) FOREIGN KEY REFERENCES Usuarios(cedula)
);

-- Ventas
CREATE TABLE Ventas (
    numero_venta INT PRIMARY KEY,
    fecha DATETIME,
    monto DECIMAL(10, 2),
    medio_pago VARCHAR(50),
    cedula_cliente VARCHAR(20) FOREIGN KEY REFERENCES Clientes(cedula),
    cedula_usuario VARCHAR(20) FOREIGN KEY REFERENCES Usuarios(cedula)
);

-- DetallesVenta (Nueva tabla para normalizar Ventas)
CREATE TABLE DetallesVenta (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    numero_venta INT FOREIGN KEY REFERENCES Ventas(numero_venta),
    id_producto INT FOREIGN KEY REFERENCES Productos(id_producto),
    cantidad INT,
    precio DECIMAL(10, 2)
);

-- Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    marca VARCHAR(50),
    tamanio VARCHAR(50),
    color VARCHAR(50),
    peso DECIMAL(5,2),
    precio DECIMAL(10,2),
    estilo VARCHAR(50),
    descripcion TEXT
);

-- Proveedores
CREATE TABLE Proveedores (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50),
    nom_producto VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    descripcion TEXT
);

-- Contactos
CREATE TABLE Contactos (
    id_contacto INT PRIMARY KEY IDENTITY(1,1),
    tipo_contacto VARCHAR(50), -- 'cliente', 'proveedor', 'empleado'
    id_referencia INT, -- ID de Cliente, Proveedor o Usuario dependiendo del tipo
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- Direcciones
CREATE TABLE Direcciones (
    id_direccion INT PRIMARY KEY IDENTITY(1,1),
    tipo_direccion VARCHAR(50), -- 'cliente', 'proveedor'
    id_referencia INT,
    direccion TEXT
);

-- CategoriasProductos
CREATE TABLE CategoriasProductos (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    descripcion TEXT
);

-- Relación entre productos y categorías (si un producto puede tener varias categorías)
CREATE TABLE ProductoCategoria (
    id_producto INT FOREIGN KEY REFERENCES Productos(id_producto),
    id_categoria INT FOREIGN KEY REFERENCES CategoriasProductos(id_categoria),
    PRIMARY KEY (id_producto, id_categoria)
);
