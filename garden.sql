-- Base de datos de la empresa Garden

create database if not exists garden;
use garden;

-- Creación de la tabla gama_producto
CREATE TABLE gama_producto(
	idGama VARCHAR(50),
	descripcionTexto TEXT,
	descripcionHTML TEXT,
	imagen VARCHAR(256),
	CONSTRAINT pk_id_gama_producto PRIMARY KEY(idGama)
);

-- Creación de la tabla País
CREATE TABLE pais(
	idPais INT AUTO_INCREMENT,
	nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pk_id_pais PRIMARY KEY(idPais)
);

-- Creación de la tabla Región
CREATE TABLE region(
	idRegion INT AUTO_INCREMENT,
	nombre VARCHAR(100) NOT NULL,
	fkIdPais INT NOT NULL,
	CONSTRAINT pk_id_region PRIMARY KEY(idRegion),
	CONSTRAINT fk_id_region_pais FOREIGN KEY(fkIdPais) REFERENCES pais(idPais)
);

-- Creación de la tabla Región
CREATE TABLE ciudad(
	idCiudad INT AUTO_INCREMENT,
	nombre VARCHAR(100) NOT NULL,
	codPostal VARCHAR(11) NOT NULL,
	fkIdRegion INT NOT NULL,
	CONSTRAINT pk_id_ciudad PRIMARY KEY(idCiudad),
	CONSTRAINT fk_id_ciudad_region FOREIGN KEY(fkIdRegion) REFERENCES region(idRegion)
);

-- Creación de la tabla Proveedor
CREATE TABLE proveedor(
	idProveedor INT AUTO_INCREMENT,
	nombre varchar(50) NOT NULL,
	nit VARCHAR(13) UNIQUE,
	fkIdCiudad INT,
	email VARCHAR(50) UNIQUE,
	CONSTRAINT pk_id_proveedor PRIMARY KEY(idProveedor),
	CONSTRAINT fk_id_ciudad_ciudad FOREIGN KEY(fkIdCiudad) REFERENCES ciudad(idCiudad)
);

-- Creación Tipo_Telefono_Proveedor
CREATE TABLE tipoTelefono(
	idTipoTelefono  INT AUTO_INCREMENT,
	tipo VARCHAR(20),
	CONSTRAINT pk_id_tipo_telefono PRIMARY KEY(idTipoTelefono)
);


-- Creación Teléfonos Proveedores
CREATE TABLE telefonoProveedor(
	idTelefProveedor INT AUTO_INCREMENT,
	numero VARCHAR(20),
	fkIdTipoTelefono INT,
	fkIdProveedor INT,
	CONSTRAINT pk_id_telef_proveedor PRIMARY KEY(idTelefProveedor),
	CONSTRAINT fk_id_proveedor_telef FOREIGN KEY(fkIdProveedor) REFERENCES proveedor(idProveedor),
	CONSTRAINT fk_id_tipo_telef_proveedor FOREIGN KEY(fkIdTipoTelefono) REFERENCES tipoTelefono(idTipoTelefono)
);


-- Creación de la tabla producto
CREATE TABLE producto(
	codigoProducto VARCHAR(15),
	nombre VARCHAR(70)  NOT NULL,
	fkIdGama VARCHAR(50) NOT NULL,
	dimensiones VARCHAR(25),
	descripcion TEXT,
	CONSTRAINT pk_codigo_producto PRIMARY KEY(codigoProducto),
	CONSTRAINT fk_id_gama_producto FOREIGN KEY(fkIdGama) REFERENCES gama_producto(idGama)
);



-- Creación de la tabla productoProveedor
CREATE TABLE productoProveedor(
	fkCodigoProducto VARCHAR(15) NOT NULL,
	fkIdProveedor INT NOT NULL,
	cantidaEnStock SMALLINT(6) NOT NULL,
	precioVenta DECIMAL(15, 2) NOT NULL,
	precioProveedor DECIMAL(15,2),
	CONSTRAINT pk_producto_proveedor PRIMARY KEY(fkCodigoProducto, fkIdProveedor),
	CONSTRAINT fk_codigo_producto_proveedor FOREIGN KEY(fkCodigoProducto) REFERENCES producto(codigoProducto),
	CONSTRAINT fk_id_proveedor_producto FOREIGN KEY(fkIdProveedor) REFERENCES proveedor(idProveedor)
	
);

-- Creación de la tabla tipoDireccion
CREATE TABLE tipoDireccion(
	idTipoDireccion INT AUTO_INCREMENT,
	tipo VARCHAR(20),
	CONSTRAINT pk_id_tipo_direccion PRIMARY KEY(idTipoDireccion)
);

-- Creación de la tabla Oficina
CREATE TABLE oficina(
	codigoOficina VARCHAR(10),
	nombre VARCHAR(50),
	CONSTRAINT pk_codigo_oficina PRIMARY KEY(codigoOficina)
);


-- Creación de la tabla direccionOficina
CREATE TABLE direccionOficina(
	idDireccion INT AUTO_INCREMENT,
	direccion VARCHAR(100),
	fkIdCiudad INT,
	fkIdTipoDireccion INT,
	fkCodigoOficina VARCHAR(10),
	CONSTRAINT pk_codigo_producto PRIMARY KEY(idDireccion),
	CONSTRAINT fk_id_ciudad_direccion_oficina FOREIGN KEY(fkIdCiudad) REFERENCES ciudad(idCiudad),
	CONSTRAINT fk_id_tipo_direccion_oficina FOREIGN KEY(fkIdTipoDireccion) REFERENCES tipoDireccion(idTipoDireccion),
	CONSTRAINT fk_id_codigo_oficina_direccion FOREIGN KEY(fkCodigoOficina) REFERENCES oficina(codigoOficina)
);

-- Creación de la tabla telefonoCliente
CREATE TABLE telefonoOficina(
	idTelefOficina INT AUTO_INCREMENT,
	numero VARCHAR(20),
	fkIdTipoTelefono INT,
	fkCodigoOficina VARCHAR(10),
	CONSTRAINT pk_id_telefoficina PRIMARY KEY(idTelefOficina),
	CONSTRAINT fk_id_oficina_telef FOREIGN KEY(fkCodigoOficina) REFERENCES oficina(codigoOficina),
	CONSTRAINT fk_id_tipo_telef_oficina FOREIGN KEY(fkIdTipoTelefono) REFERENCES tipoTelefono(idTipoTelefono)
);


-- cargoEmpleado
CREATE TABLE cargoEmpleado(
	idCargoEmpleado INT,
	cargo VARCHAR(50) NOT NULL,
	CONSTRAINT pk_cargo_empleado PRIMARY KEY(idCargoEmpleado)
);

-- Creación de la tabla empleado
CREATE TABLE empleado(
	codigoEmpleado INT(11),
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50),
	extension VARCHAR(10) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	fkCodigoOficina VARCHAR(10),
	fkCodigoJefe INT(11),
	fkCargoEmpleado INT,
	CONSTRAINT pk_codigo_empleado PRIMARY KEY(CodigoEmpleado),
	CONSTRAINT fk_id_codigo_jefe_empleado FOREIGN KEY(fkCodigoJefe) REFERENCES empleado(codigoEmpleado),
	CONSTRAINT fk_id_codigo_oficina_empleado FOREIGN KEY(fkCodigoOficina) REFERENCES oficina(codigoOficina),
	CONSTRAINT fk_id_cargo_empleado FOREIGN KEY(fkCargoEmpleado) REFERENCES cargoEmpleado(idCargoEmpleado)
);

-- Creación de la tabla formaPago
CREATE TABLE formaPago(
	idFormaPago INT AUTO_INCREMENT,
	formaDePago VARCHAR(25) NOT NULL,
	CONSTRAINT pk_id_forma_pago PRIMARY KEY(idFormaPago)
);

-- Creación de la tabla cliente
CREATE TABLE cliente(
	codigoCliente INT(11),
	nombreCliente VARCHAR(50),
	fkCodigoEMpleadoRepVentas INT(11),
	limiteCredito DECIMAL(15, 2),
	CONSTRAINT pk_codigo_cliente PRIMARY KEY(codigoCliente),
	CONSTRAINT fk_empleado_codigo_cliente FOREIGN KEY(fkCodigoEMpleadoRepVentas) REFERENCES empleado(codigoEmpleado)	
);

-- Creación de la tabla telefonoCliente
CREATE TABLE telefonoCliente(
	idTelefCliente INT AUTO_INCREMENT,
	numero VARCHAR(20),
	fkIdTipoTelefono INT,
	fkIdCliente INT,
	CONSTRAINT pk_id_telef_cliente PRIMARY KEY(idTelefCliente),
	CONSTRAINT fk_id_cliente_telef FOREIGN KEY(fkIdCliente) REFERENCES cliente(codigoCliente),
	CONSTRAINT fk_id_tipo_telef_cliente FOREIGN KEY(fkIdTipoTelefono) REFERENCES tipoTelefono(idTipoTelefono)
);

-- Creación de la tabla direccionCliente
CREATE TABLE direccionCliente(
	idDireccionCliente INT AUTO_INCREMENT,
	direccion VARCHAR(100),
	fkIdCiudad INT,
	fkIdTipoDireccion INT,
	fkCodigoCliente INT(11),
	CONSTRAINT pk_id_direccion_cliente PRIMARY KEY(idDireccionCliente),
	CONSTRAINT fk_id_ciudad_direccion_cliente FOREIGN KEY(fkIdCiudad) REFERENCES ciudad(idCiudad),
	CONSTRAINT fk_id_tipo_direccion_cliente FOREIGN KEY(fkIdTipoDireccion) REFERENCES tipoDireccion(idTipoDireccion),
	CONSTRAINT fk_id_codigo_cliente_direccion FOREIGN KEY(fkCodigoCliente) REFERENCES cliente(codigoCliente)
);

-- Creación de la tabla formaPago
CREATE TABLE pago(
	idTransaccion VARCHAR(40),
	fkCodigoCliente INT(11),
	fkIdFormaPago INT NOT NULL,
	fechaPago DATE NOT NULL,
	total DECIMAL(15,2) NOT NULL,
	CONSTRAINT pk_pago PRIMARY KEY(idTransaccion, fkCodigoCliente),
	CONSTRAINT fk_codigo_cliente_pago FOREIGN KEY(fkCodigoCliente) REFERENCES cliente(codigoCliente),
	CONSTRAINT fk_id_forma_pago FOREIGN KEY(fkIdFormaPago) REFERENCES formaPago(idFormaPago)
);

-- Creación de la tabla clienteContacto
CREATE TABLE clienteContacto(
	idContactoCliente INT AUTO_INCREMENT,
	nombreContacto VARCHAR(50) NOT NULL,
	apellidoContacto VARCHAR(50) NOT NULL,
	email VARCHAR(200) NOT NULL UNIQUE,
	fkCodigoCliente INT(11) NOT NULL,
	CONSTRAINT pk_ContactoCliente PRIMARY KEY(idContactoCliente),
	CONSTRAINT fk_codigo_contacto_cliente FOREIGN KEY(fkCodigoCliente) REFERENCES cliente(codigoCliente)
);

-- Creación de tabla telefonoContactoCliente
CREATE TABLE telefonoContactoCliente(
	idTelefContactoCliente INT AUTO_INCREMENT,
	numero VARCHAR(20),
	fkIdTipoTelefono INT,
	fkIdContactoCliente INT,
	CONSTRAINT pk_id_telef_contacto_cliente PRIMARY KEY(idTelefContactoCliente),
	CONSTRAINT fk_id_Contacto_Cliente_Telef FOREIGN KEY(fkIdContactoCliente) REFERENCES clienteContacto(idContactoCliente),
	CONSTRAINT fk_id_tipo_telef_contacto_cliente FOREIGN KEY(fkIdTipoTelefono) REFERENCES tipoTelefono(idTipoTelefono)
);

-- creación de la tabla estadoPedido
CREATE TABLE estadoPedido(
	idEstadoPedido INT AUTO_INCREMENT,
	estado VARCHAR(25) NOT NULL,
	CONSTRAINT pk_id_estado_pedido PRIMARY KEY(idEstadoPedido)
);


-- creación de la tabla pedido
CREATE TABLE pedido(
	codigoPedido INT(11),
	fechaPedido DATE NOT NULL,
	fechaEsperada DATE NOT NULL,
	fechaEntrega DATE,
	fkIdEstado INT NOT NULL,
	comentarios TEXT,
	fkCodigoCliente INT(11) NOT NULL,
	CONSTRAINT pk_id_codigo_pedido PRIMARY KEY(codigoPedido),
	CONSTRAINT fk_id_estado_contacto_cliente FOREIGN KEY(fkIdEstado) REFERENCES estadoPedido(idEstadoPedido),
	CONSTRAINT fk_codigo_cliente_pedido FOREIGN KEY(fkCodigoCliente) REFERENCES cliente(codigoCliente)	
);

-- Creación de la tabla detallePedido
CREATE TABLE detallePedido(
	fkCodigoPedido INT(11) NOT NULL,
	fkCodigoProducto VARCHAR(15) NOT NULL,
	cantidad INT(11) NOT NULL,
	precioUnidad DECIMAL(15,2) NOT NULL,
	numeroLinea SMALLINT(6) NOT NULL,
	CONSTRAINT pk_id_detalle_pedido PRIMARY KEY(fkCodigoPedido, fkCodigoProducto),
	CONSTRAINT fk_id_codigo_pedido_detalle FOREIGN KEY(fkCodigoPedido) REFERENCES pedido(codigoPedido),
	CONSTRAINT fk_id_codigo_producto_detalle FOREIGN KEY(fkCodigoProducto) REFERENCES producto(codigoProducto)
);

-- INSERCIONES EN LAS TABLAS
-- Inserciones en la tabla pais
insert into pais(nombre)
values ('España'), ('Colombia'), ('México');

-- inserciones en la tabla region
insert into region(nombre, fkIdPais)
values 	('Andalucía', 1),
	('Aragón', 1),
	('Cataluña', 1),
	('Comunidad de Madrid', 1),
	('Santander', 2),
	('Valle del Cauca', 2),
	('Antioquia', 2),
	('Estado de México', 3),
	('Hidalgo', 3),
	('Ciudad de México', 3);
	
-- Inserciones en la tabla ciudad
insert into ciudad(nombre, codPostal, fkIdregion)
values	('Sevilla', '41001', 1),
	('Zaragoza', '50001', 2),
	('Barcelona', '08001', 3),
	('Madrid', '28001', 4),
	('Bucaramanga', '680001', 5),
	('Cali', '760000', 6),
	('Medellín', '050001', 7),
	('Toluca de Lerdo', '50000', 8),
	('Pachuca de Soto', '42000', 9),
	('Ciudad de México', '01000', 10);


-- inserciones en la tabla oficina
insert into oficina(codigoOficina, nombre)
values 	('OFCSEVESP', 'Oficina Sevilla'),
	('OFCZARESP', 'Oficina Zaragoza'),
	('OFCBARESP', 'Oficina Barcelona'),
	('OFCMADESP','Oficina Madrid'),
	('OFCBUCCOL','Oficina Bucaramanga'),
	('OFCCALCOL','Oficina Cali'),
	('OFCMEDCOL','Oficina Medellín'),
	('OFCTOLMEX','Oficina Toluca de Lerdo'),
	('OFCPACMEX','Oficina Pachuca'),
	('OFCCDMXMEX','Oficina Ciudad de México');

-- inserciones en la tabla  tipoDireccion
insert into tipoDireccion(tipo)
values 	('Despacho'),
	('Facturación'),
	('Entrega');

-- inserciones en la tabla direccionOficina 
insert into direccionOficina(direccion, fkIdCiudad, fkIdTipoDireccion, fkCodigoOficina)
values	('Paseo Las Delicias S/N 41012', 1, 1, 'OFCSEVESP'),
	('Pl. de Ntra. Sra. del Pilar, 18, Casco Antiguo', 2, 1, 'OFCZARESP'),
	('Pl. de Sant Jaume, 1, Ciutat Vella' , 3 , 1 , 'OFCBARESP'),
	('C. de Montalbán, 1, Retiro' , 4 , 1 , 'OFCMADESP'),
	( 'Cra. 11 #34-52, García Rovira', 5, 1, 'OFCBUCCOL'),
	('Centro Administrativo Municipal, Av. 2 Nte. #10 - 70, San Pedro' , 6, 1, 'OFCCALCOL'),
	('Cl 44 #52 - 165, La Candelaria', 7, 1, 'OFCMEDCOL'),
	('Av. Independencia 207, Centro', 8, 1, 'OFCTOLMEX'),
	( 'General, Gral. Pedro Ma Anaya 1, Centro', 9, 1, 'OFCPACMEX'),
	( 'P.za de la Constitución 2, Centro Histórico', 10, 1, 'OFCCDMXMEX');

-- inserciones en la tabla tipoTelefono
insert into tipoTelefono(tipo)
values	('Mòvil'),
	('Fijo'),
	('Fax');

-- Inserciones en la tabla telefonoOficina
insert into telefonoOficina(numero, fkIdTipoTelefono, fkCodigoOficina)
values 	('+34955010010', 2, 'OFCSEVESP'),
	('+34976721100', 2, 'OFCZARESP'),
	('+34934027000', 2, 'OFCBARESP'),
	('+34915298210', 2, 'OFCMADESP'),
	('+576076337000', 2, 'OFCBUCCOL'),
	('+576025247778', 2, 'OFCCALCOL'),
	('+576044310482', 2, 'OFCMEDCOL'),
	('+527222761900', 2, 'OFCTOLMEX'),
	('+527717171500', 2, 'OFCPACMEX'),
	('+525553458027', 2, 'OFCCDMXMEX');

-- Inserciones en la tabla cargoEmpleado
insert into cargoEmpleado(idCargoEmpleado, cargo)
values	(1, 'CEO'),
	(2, 'Gerente de Contabiliad'),
	(3, 'Asesor Contable'),
	(4, 'Auxiliar Contable'),
	(5, 'Gerente de Tesorería'),
	(6, 'Tesorero'),
	(7, 'Jefe de Ventas'),
	(8, 'Asesor de ventas'),
	(9, 'Gerente de Logìstíca'),
	(10, 'Auxiliar de Logística');

-- Inserciones en la tabla empleado
insert into empleado
values	(10, 'Carlos Jhoan', 'Aguilar', 'Galvis', '00', 'carlosjhoanaguilar@gmail.com',  'OFCBUCCOL', NULL, 1),
	(21, 'Luis Alfonso', 'Gómez', 'Mancilla', '01', 'luisgomezmancilla@gmail.com',  'OFCBUCCOL', 10, 2),
	(32, 'Javier Augusto', 'Galvis', 'Chacón', '02', 'javieraugustochacon@gmail.com',  'OFCTOLMEX', 21, 3),
	(43, 'Julio César', 'Galvis', 'Chacón', '03', 'juliogalvischacon@gmail.com',  'OFCPACMEX', 32, 4),
	(51, 'Sandra Patricia', 'González', 'Amador', '04', 'sandraGonzalezAmador@gmail.com',  'OFCCALCOL', 10, 5),
	(65, 'Clara Milena', 'Aguilar', 'Bella', '05', 'bellaAguilarClara@gmail.com',  'OFCBARESP', 51, 6),
	(71, 'Juan David', 'Gómez', 'Benavides', '06', 'eliezerJuanGomez@gmail.com',  'OFCCDMXMEX', 10, 7),
	(87, 'Ángela', 'Gutierrez', 'Arango', '07', 'gutierrezarangoangela@gmail.com',  'OFCMADESP', 71, 8),
	(97, 'Daniel', 'Tobón', 'Comba', '08', 'pepsimanCombaDani@gmail.com',  'OFCMEDCOL', 71, 8),
	(107, 'María', 'Correa', 'Martínez', '09', 'martinezjulianamaria@gmail.com',  'OFCMEDCOL', 71, 8),
	(117, 'Mario', 'Galvis', 'Olago', '10', 'galvismarioolago@gmail.com',  'OFCZARESP', 71, 8);

insert into empleado
values	(120, 'José Mauricio', 'Manosalva', 'Buitrago', '11', 'buitragomanosalva2023@gmail.com',  NULL, 10, 9),
	(121, 'Karen Julieth', 'Quintero', 'Hernández', '12', 'karenquintero199403@gmail.com', NULL, 120, 10);

-- Inserciones en la tabla cliente
insert into cliente
values	(001, 'EXPLOTACIONES AGRICOLAS VALJIMENO S.L.', 87, 150000000.0),
	(002, 'AGRO-Spain Ingenieros', 117, 110000000.0),
	(003, 'Agropecuària de Moià', NULL, 50000000.0),
	(004, 'Compo Iberia SL', 97, 75000000),
	(005, 'Central Agroindustrial Mexiquense S.A. de C.V.', 87, 25000000.0),
	(006, 'Punto Verde Agro Toluca', 107, 15000000.0),
	(007, 'AGROPECUARIA RIO FRIO LTDA', 97, 10000000.0),
	(008, 'Casagro', NULL, 5000000);

insert into cliente
values	(9, 'JARDÍN MADRILEÑO', 87, 90000.0);

insert into cliente
values	(10, 'INDUSTRIAL JARDINERA DE MADRID', 97, 15000000.0);

insert into cliente
values	(11, 'ARBUSTO ROBUSTO', 117, 35000000.0),
	(12, 'JARDÍN TRASERO', 117, 35000000.0);
	
-- Inserciones en la tabla direccionCliente
insert into direccionCliente(direccion, fkIdCiudad, fkIdTipoDireccion, fkCodigoCliente)
values 	('Pl. de Cuba, 5', 1, 3, 1),
	('Av. San Francisco Javier, 9', 1, 3, 2),
	('Ronda de la Univ., 14, 1º 2ª, Eixample', 3, 3, 3),
	('Av. Diagonal, 188, 3º B, Sant Martí', 3, 3, 4),
	('Sor Juana I. de La C. 305, Barrio de Sta Clara', 8, 3, 5), 
	('Sor Juana I. de La C. 310, Barrio de Sta Clara', 8, 2, 5),
	('José María Luis Mora 990, Ocho Cedros', 8, 3, 6),
	('Aurora. Santander #21 - 57', 5, 3, 7),
	('Carrera 35 #52-45, Cabecera', 5, 2, 7),
	('Av. Quebrada Seca #18 - 77, Comuna 4 Occidental', 5, 3, 7);

insert into direccionCliente(direccion, fkIdCiudad, fkIdTipoDireccion, fkCodigoCliente)
values 	('Pl. Juan de DIos, 13', 4, 3, 9);

insert into direccionCliente(direccion, fkIdCiudad, fkIdTipoDireccion, fkCodigoCliente)
values 	('Av. Barteau Sánchez, 3ª', 4, 3, 10);

-- Inserciones en la tabla estadoPedido
insert into estadoPedido(estado)
values 	('Creado'),
	('En tránsito'),
	('Entregado'),
	('Destinatario ausente'),
	('Pendiente de recogida'),
	('En devolución'),
	('Retenido en aduanas');

insert into estadoPedido(estado)
values 	('Rechazado');
	
-- Inserciones en la tabla formaPago
insert into formaPago(formaDePago)
values 	('Efectivo'),
	('Tarjeta débito'),
	('Tarjeta crédito'),
	('Cheque'),
	('Transferencia de pago');

insert into formaPago(formaDePago)
values 	('Paypal');

-- Inserciones en la tabla pago
insert into pago
values	('ABC25654321', 1, 5, '2008-06-12', 5250000.0),
	('CDE21351646', 4, 4, '2008-01-25', 4000000.0),
	('AFE32354554', 1, 3, '2010-07-15', 9000000.0),
	('CDG25465335', 8, 5, '2007-01-25', 2500000.0),
	('CDH32468745', 1, 1, '2008-04-17', 3750000.0),
	('CHJ68634668', 2, 4, '2008-05-17', 1070000.0),
	('DGC20235456', 3, 3, '2011-04-17', 5750000.0),
	('DGE26598324', 5, 5, '2008-10-20', 4000000.0),
	('AVZ00222000', 6, 1, '2008-08-18', 12000000.0),
	('DGA06506501', 7, 5, '2020-04-17', 7500000.0);

insert into pago
values	('FFG13213213', 1, 5, '2008-11-30', 4500000.0);

insert into pago
values	('AHJ51215055', 1, 6, '2008-07-02', 3540000.0),
	('FGH51651654', 2, 6, '2008-03-14', 2560000.0),
	('AHV51515654', 6, 6, '2008-09-17', 5150000.0),
	('ALK54545654', 3, 6, '2008-01-10', 10582000.0);

-- Inserciones en la tabla pedido
insert into pedido
values 	(1, '2008-05-30', '2008-07-20', '2008-07-23', 3, 'Pedido entregado con éxito auqnue tarde', 1),
	(2, '2007-11-30', '2008-04-20', '2008-05-02', 3, 'Pedido entregado con garantía', 2),
	(3, '2011-03-15', '2011-05-02', NULL, 2, 'Pedido en camino', 3),
	(4, '2007-12-20', '2008-02-20', '2008-02-20', 3, 'Cliente recibión satisfactoriamente', 4),
	(5, '2008-08-13', '2008-10-21', '2008-10-23', 3, 'Entregado. Inconvenientes al descargar', 5),
	(6, '2008-08-10', '2008-09-21', '2008-09-19', 3, 'Entregado. Cliente satisfecho', 6),
	(7, '2020-03-09', '2020-06-18', NULL, 1, 'Pedido recién realizado', 7),
	(8, '2006-10-31', '2007-04-03', '2007-04-23', 3, 'Tuvimos inconvenientes en el transporte, pero se entregó exitosamente.',8);

insert into pedido
values 	(9, '2009-09-30', '2009-10-20', NULL, 8, 'No coincide con lo que el cliente pidió', 1),
	(10, '2009-07-15', '2009-08-18', NULL, 8, 'No coincide con lo que el cliente pidió', 2),
	(11, '2009-06-10', '2009-08-21', NULL, 8, 'No coincide con lo que el cliente pidió', 3),
	(12, '2009-09-30', '2009-11-25', NULL, 8, 'No coincide con lo que el cliente pidió', 4);

insert into pedido
values 	(13, '2011-10-30', '2012-01-05', '2012-01-04', 3, 'Entrega exitosa', 1),
	(14, '2010-03-15', '2010-08-07', '2010-08-04', 3, 'Entrega exitosa', 2),
	(15, '2011-10-30', '2012-01-10', '2012-01-09', 3, 'Entrega exitosa', 3),
	(16, '2011-10-21', '2012-01-20', '2010-01-15', 3, 'Entrega exitosa', 4);

insert into pedido
values 	(17, '2023-11-30', '2024-02-14', NULL, 1, 'Pedido recién creado', 9),
	(18, '2024-04-15', '2024-06-10', NULL, 2, 'Va llegando al cliente', 10);

-- Inserciones en la tabla gama_producto
insert into gama_producto
values ('ORNAMENTALES', 'Las plantas de ornato, o plantas ornamentales, no son un tipo ni una familia concreta dentro del género de plantas. Se trata de cualquier planta que cultivemos y cuidemos con el propósito de embellecer o hacer más estético un lugar o espacio determinado.', 'Plantas para embellecer', './ornamental.jpg');

insert into gama_producto
values	('FRUTALES', 'Todo lo relacionado con àrboles frutales, ya sea: semillas, ramamles de siembra, injertos', 'árboles frutales', './frutal.jpg'),
	('HERRAMIENTAS', 'Aquí se dispondrán todas las herramientas manuales y eléctricas para el uso del cuidado de cultivos y de jardines', 'herramientas', './herramienta.jpg'); 

-- Inserciones en la tabla producto
insert into producto
values	(1, 'Helecho A', 'ORNAMENTALES', '30cm de altura', 'Planta de exterior'),
	(2, 'Helecho B', 'ORNAMENTALES', '25cm de altura', 'Planta de exterior'),
	(3, 'Helecho C', 'ORNAMENTALES', '30cm de altura', 'Planta de exterior'),
	(4, 'Begonia A', 'ORNAMENTALES', NULL, 'Planta de exterior'),
	(5, 'Begonia B', 'ORNAMENTALES', '15 cm', 'Planta de exterior'),
	(6, 'Begonia C', 'ORNAMENTALES', '18 cm', 'Planta de exterior');

insert into producto
values	(7, 'Semilla Naranja', 'FRUTALES', NULL, 'Sembrarse en terreno seco'),
	(8, 'Semilla Maracuyá', 'FRUTALES', NULL, 'Sembrarse en terreno seco'),
	(9, 'Semilla Mandarina', 'FRUTALES', NULL, 'Sembrarse en terreno húmedo'),
	(10, 'Semilla Mora castilla', 'FRUTALES', NULL, 'Sembrarse en terreno páramo'),
	(11, 'Semilla Curuba', 'FRUTALES', NULL, 'Sembrarse en terreno seco'),
	(12, 'Semilla Chirimoya', 'FRUTALES', NULL, 'Sembrarse en terreno seco o húmedo'),
	(13, 'Tijera De Poda Jardinería Mango Cubierto', 'HERRAMIENTAS', 'Largo 20cm', 'Herramientas manual para cortar arbustos'),
	(14, 'Guadañadora Podadora Trabajo Pesado Gasolina', 'HERRAMIENTAS' , '150cm de largo', 'Podadora de combustible para usarse con árboles grandes o en cultivos de hoja pesada como el maíz');

ALTER TABLE producto
ADD imagen VARCHAR(50);

UPDATE producto
SET imagen = './helechoA.jpg'
WHERE codigoProducto = 1;

UPDATE producto
SET imagen = './semillmorcas.jpg'
WHERE codigoProducto = 10;

UPDATE producto
SET imagen = './semillcur.jpg'
WHERE codigoProducto = 11;

UPDATE producto
SET imagen = './semillchir.jpg'
WHERE codigoProducto = 12;

UPDATE producto
SET imagen = './tijmangcub.jpg'
WHERE codigoProducto = 13;

UPDATE producto
SET imagen = './guadpodpes.jpg'
WHERE codigoProducto = 14;

UPDATE producto
SET imagen = './helechoB.jpg'
WHERE codigoProducto = 2;

UPDATE producto
SET imagen = './helechoC.jpg'
WHERE codigoProducto = 3;

UPDATE producto
SET imagen = './begoniaA.jpg'
WHERE codigoProducto = 4;

UPDATE producto
SET imagen = './begoniaB.jpg'
WHERE codigoProducto = 5;

UPDATE producto
SET imagen = './begoniaC.jpg'
WHERE codigoProducto = 6;

UPDATE producto
SET imagen = './semillnar.jpg'
WHERE codigoProducto = 7;

UPDATE producto
SET imagen = './semillmar.jpg'
WHERE codigoProducto = 8;

UPDATE producto
SET imagen = './semillman.jpg'
WHERE codigoProducto = 9;

-- Inserciones en la tabla proveedor
insert into proveedor(nombre, nit, fkIdCiudad, email)
values	('SEVILLA PLANTAS S.A', 'SA10021012', 1, 'sevilla_plantasSA@gmail.com'),
	('JARDIN EDÉN ZARAGOZA', 'SZ21321321', 2, 'edenjardin@gmail.com'),
	('ORNAMENTALES CATALUÑA', 'SB54615912', 3, 'catalunyaornamentales@gmail.com'),
	('ROSITAS DE KYOTO S.A', 'SM2351565', 4, 'rositasdekyoto@gmail.com'),
	('MIS PLANTOTAS BUACARAMANGA', 'BUC21354654', 5, 'misplantotasbucara@gmail.com'),
	('VERDE COBRIZO', 'CAL21354654', 6, 'verdecobrizo@gmail.com'),
	('JARDÍN DE TEPEYEC', 'MED54654564', 7, 'jardintepeyec@gmail.com'),
	('ORQUÍDEA JUÁREZ', 'TOL51654154', 8, 'orquideajuarez@gmail.com'),
	('ROSITAS DON HIDALGO', 'PACH3524687', 9, 'rositadonhidalgo@gmail.com'),
	('MACETONES FEDERAL', 'CDMX354654', 10, 'macetonesfederal@gmail.com');
	
-- inserciones en la tabla productoProveedor
insert into productoProveedor
values	(1, 1, 125, 15000.0, 9000.0),
	(1, 6, 109, 13000.0, 8500.0),
	(2, 5, 135, 11000.0, 7500.0),
	(4, 8, 102, 9500, 7500.0),
	(4, 4, 108, 12500.0, 10500.0),
	(3, 2, 136, 6500.0, 3500.0);

insert into productoProveedor
values	(7, 2, 1200, 1200.0, 750.0),
	(8, 2, 2000, 850.0, 450.0),
	(9, 10, 1750, 980.0, 475.0),
	(10, 4, 1855, 845.0, 425.0),
	(11, 8, 560, 925.0, 630.0),
	(11, 6, 750, 925.0, 615.0),
	(12, 5, 645, 553.0, 365.0),
	(13, 3, 120, 65000.0, 45000.0),
	(14, 5, 50, 1200000.0, 750000.0);

-- Inserciones en la tabla detallePedido
insert into detallePedido
values	(1, 2, 25, 11000.0, 2),
	(1, 7, 150,1200.0, 3),
	(1, 13, 2, 65000.0, 4),
	(5, 1, 10, 15000.0, 2),
	(5, 9, 75, 980.0, 3),
	(5, 14, 2, 1200000.0, 4),
	(6, 4, 5, 9500.0, 2),
	(6, 10, 125, 845.0, 2);
