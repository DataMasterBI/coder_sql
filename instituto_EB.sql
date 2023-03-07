/* ALUMNO: EMILIANO BLANCO
-- Creacion de una BBDD para un instituto
-- Creacion de Tablas:
-- ALUMNOS, PROFESORES, PADRES, MATERIAS, ACTIVIDADES, FALTAS, AMONESTACIONES,
-- NOTAS, PAGOS_CUOTA, EXPULSADOS, PRECEPTORES.
-- Insercion de datos en las tablas.
*/

-- drop database Instituto

-- Creacion de la BBDD
create schema IF NOT EXISTS  Instituto; 
use Instituto;

-- Creacion de las tablas

create table IF NOT EXISTS padres (
padre_id INT auto_increment not null primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
telefono varchar (15) not null,
direccion varchar (50) not null,
localidad varchar (50) not null
);

create table IF NOT EXISTS alumnos (
alumno_id INT auto_increment not null primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
fecha_nac date not null,
padre_id INT not null,
foreign key (padre_id) references padres(padre_id)
);

create table IF NOT EXISTS profesores (
profesor_id INT auto_increment not null primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
email varchar (100) not null,
telefono varchar(15) not null
);

create table IF NOT EXISTS materias (
materia_id INT auto_increment not null primary key,
nombre_materia varchar(100) not null,
profesor_id INT not null,
cantidad_creditos FLOAT not null,
alumno_id INT not null,
foreign key (profesor_id) references profesores(profesor_id),
foreign key (alumno_id) references alumnos(alumno_id)
);

create table IF NOT EXISTS actividades (
actividad_id INT auto_increment not null primary key,
descripcion varchar(100) not null,
profesor_id INT not null,
alumno_id INT not null,
foreign key (profesor_id) references profesores(profesor_id),
foreign key (alumno_id) references alumnos(alumno_id)
);


create table IF NOT EXISTS faltas (
falta_id INT auto_increment not null primary key,
fecha_falta DATE not null,
padre_id INT not null,
alumno_id INT not null,
foreign key (padre_id) references padres(padre_id),
foreign key (alumno_id) references alumnos(alumno_id)
);

create table IF NOT EXISTS amonestaciones (
amonestacion_id INT auto_increment not null primary key,
fecha_amonestacion DATE not null,
profesor_id INT not null,
alumno_id INT not null,
cantidad_amonestacion tinyint not null,
motivo varchar(300) not null,
padre_id INT not null,
foreign key (profesor_id) references profesores(profesor_id),
foreign key (alumno_id) references alumnos(alumno_id),
foreign key (padre_id) references padres(padre_id)
);


create table IF NOT EXISTS notas (
nota_id INT auto_increment not null primary key,
fecha_nota DATE not null,
alumno_id INT not null,
materia_id INT not null,
profesor_id INT not null,
nota_numerica numeric(10,2),
foreign key (materia_id) references materias(materia_id),
foreign key (alumno_id) references alumnos(alumno_id),
foreign key (profesor_id) references profesores(profesor_id)
);


create table IF NOT EXISTS pagos_cuota (
pago_id INT auto_increment not null primary key,
fecha_pago DATE not null,
alumno_id INT not null,
padre_id INT not null,
num_tarjeta varchar (20)  not null,
vto_tarjeta varchar (5) not null,
codseg_tarjeta int not null,
cuota int not null,
foreign key (alumno_id) references alumnos(alumno_id),
foreign key (padre_id) references padres(padre_id)
);


create table IF NOT EXISTS preceptores (
preceptor_id INT auto_increment not null primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
email varchar (100) not null,
telefono varchar(15) not null
);


create table IF NOT EXISTS expulsados (
expulsion_id INT auto_increment not null primary key,
fecha_expulsion DATE not null,
preceptor_id INT not null,
alumno_id INT not null,
padre_id INT not null,
descripcion varchar (300) not null,
foreign key (alumno_id) references alumnos(alumno_id),
foreign key (padre_id) references padres(padre_id),
foreign key (preceptor_id) references preceptores(preceptor_id)
);


-- Insercion de datos para las tablas 

-- Insercion tabla padres

### INSERCIONES CONTROLADAS

start transaction;

insert into padres (nombre, apellido, telefono, direccion, localidad) values
('Carla', 'Perez', '11-31234567', 'Avenida Directorio 1034 7B', 'CABA'),
('Carlos', 'Lopez', '11-31274989', 'Rosario 134 7A', 'Avellaneda'),
('Alan', 'Acuña', '11-11263413', 'Avenida Belgrano 1854 1B', 'CABA'),
('Federico', 'Rodriguez', '11-21237654', 'Avenida Independencia 1034 7B', 'CABA'),
('Gonzalo', 'Viña', '11-61263452', 'Avenida Maipu 233', 'San Isidro'),
('Javier', 'Milano', '11-23339487', 'Avenida Directorio 22 3A', 'CABA'),
('Analia', 'Ayuso', '11-51334123', 'Avenida Corrientes 2341 4C', 'CABA'),
('Mariana', 'Pineda', '11-86638223', 'Cachimayo 322 5C', 'CABA'),
('Micaela', 'Tarsia', '11-46551244', 'Avenida Mitre 544 3C', 'Avellaneda'),
('Pedro', 'Gonzalez', '11-22392990', 'Moreno 1854 7D', 'CABA'),
('Monica', 'Montalvo', '11-39992376', 'Dardo Rocha 673 1C', 'Avellaneda'),
('Martin', 'Tejeda', '11-30230054', 'Juan Bautista Alberdi 777 1A', 'Vicente Lopez'),
('Yanet', 'Pallares', '11-81285564', 'Avenida La Plata 333 9E','CABA'),
('Diego', 'Garcia', '11-73348222', 'Venezuela 1888 2A', 'CABA'),
('Jonathan', 'Nievas', '11-74448122', 'Avenida Entre Rios 884 2A', 'CABA');

rollback;
-- delete from padres where padre_id=1   ## Elimino un regitro 
commit;


-- Insercion tabla alumnos

### INSERCIONES CONTROLADAS

start transaction;


insert into alumnos (nombre, apellido, fecha_nac, padre_id) values
('Juana', 'Gonzalez', '20100303', 1),
('Martin', 'Navarro', '20101122', 7),
('Vito', 'Rodriguez', '20110804', 4),
('Rodrigo', 'Garcia', '20100522', 14);

savepoint lote_1;

insert into alumnos (nombre, apellido, fecha_nac, padre_id) values
('Fabian', 'Acuña', '20100923', 3),
('Federico', 'Viña', '20100811', 5),
('Mariano', 'Lopez', '20100715', 2),
('Daniela', 'Milano', '20110312', 6);

savepoint lote_2;

insert into alumnos (nombre, apellido, fecha_nac, padre_id) values
('Diego', 'Carrillo', '20110122', 8),
('Maximo', 'Santa Cruz', '20101002', 9),
('Martin', 'Gonzalez', '20130110', 1), 
('Victor', 'Gonzalez', '20101120', 10),
('Gustavo', 'Kolker', '20100529', 11),
('Nicolas', 'Tejeda', '20110622', 12), 
('Martin', 'Musolino', '20110815', 13),
('Emilio', 'Nievas', '20101201', 15),
('Erica', 'Nievas', '20140503', 15),
('Marcelo', 'Rodriguez', '20130316', 4), 
('Pedro', 'Kolker', '20120419', 11),
('Jesus', 'Milano', '20130612', 6),
('Carlos', 'Santa Cruz', '20130722', 9);

rollback;

-- delete from alumnos where alumno_id=1;

-- release savepoint lote_1;

commit;

### FIN DE INSERCIONES CONTROLADAS



/* CONSULTA PARA SABER CUAL ES EL PADRE DEL ALUMNO

select t1.alumno_id, t1.nombre, t1.apellido, t1.padre_id from alumnos as t1 
full join padres as t2 on t1.padre_id=t2.padre_id;

Despues hacer una funcion para mostrar
*/

-- Insercion tabla profesores

insert into profesores (nombre, apellido, email, telefono) values
('Cristina', 'Besada', 'cbesada@gmail.com', 11-38729732),
('Mario', 'Mansilla', 'mmansilla@hotmail.com', 11-21979733),
('Dario', 'Albornoz', 'dalbornoz@gmail.com', 11-31149344),
('Pablo', 'Gimenez', 'pgimenez@outlook.com', 11-38336231),
('Belen', 'Aguero', 'baguero@yahoo.com', 11-18887122),
('Mariano', 'Martinez', 'mmartinez@gmail.com', 11-22299988),
('Carlos', 'Rico', 'crico@yahoo.com', 11-45551122),
('Cristina', 'Cernadas', 'ccernadas@outllok.com', 11-38743298),
('Mariela', 'Darchivio', 'mdarchivio@hotmail.com', 11-91123961),
('Juan Pedro', 'Rosa Alves', 'jpralves@gmail.com', 11-21299832),
('Cristina', 'Besada', 'cbesada@gmail.com', 11-21294349),
('Jose', 'Gorini', 'jgorini@masterweb.com', 11-62300301),
('Mariano', 'Galvan', 'mgalvan@hotmail.com', 11-91294923),
('Daniela', 'Rezzonico', 'drezzonico@gmail.com', 11-21002399),
('Gaspar', 'Geraghty', 'ggeraghty@yahoo.com', 11-22291010);

-- Insercion tabla materias

insert into materias (nombre_materia, profesor_id, cantidad_creditos, alumno_id) values
('Ingles', 1, 6, 1),
('Frances', 4, 6, 2),
('Ingles', 1, 6, 3),
('Ingles', 1, 6, 4),
('Frances', 4, 6, 5),
('Ingles', 1, 6, 6),
('Ingles', 1, 6, 7),
('Frances', 4, 6, 8),
('Ingles', 1, 6, 9),
('Chino mandarin', 8, 6, 10),
('Chino mandarin', 8, 6, 11),
('Ingles', 1, 6, 12),
('Ingles', 1, 6, 13),
('Ingles', 1, 6, 14),
('Aleman', 5, 6, 15),
('Gimnasia', 3, 6, 4),
('Gimnasia', 3, 6, 5),
('Gimnasia', 3, 6, 9),
('Gimnasia', 3, 6, 13),
('Gimnasia', 3, 6, 14),
('Historia', 9, 6, 2),
('Historia', 9, 6, 8),
('Historia', 9, 6, 10),
('Historia', 9, 6, 11);

-- Insercion tabla actividades

insert into actividades (descripcion, profesor_id, alumno_id) values
('Taller de informatica', 9, 1),
('Taller de informatica', 9, 8),
('Taller de informatica', 9, 15),
('Taller de informatica', 9, 4),
('Taller de informatica', 9, 5),
('Taller de dibujo', 11, 7),
('Taller de ajedrez', 12, 12),
('Taller de futbol', 7, 6),
('Taller de gimnasia artistica', 4, 10);

-- Insercion tabla faltas

insert into faltas (fecha_falta, padre_id, alumno_id) values
('20220303', 2, 7),
('20220303', 1, 1),
('20220304', 2, 7),
('20220305', 2, 7),
('20220305', 2, 7),
('20220306', 2, 7),
('20220311', 2, 7),
('20220312', 1, 1),
('20220403', 2, 7),
('20220403', 2, 7),
('20220403', 2, 7);

-- insercion tabla amonestaciones

insert into amonestaciones (fecha_amonestacion, alumno_id, profesor_id, cantidad_amonestacion, motivo, padre_id) values
('20220303', 3, 2, 2, 'Mal comportamiento en clase', 4),
('20220305', 6, 4, 2, 'Pelear con un compañero en el recreo', 5);


-- Insercion tabla actividades

insert into actividades (descripcion, alumno_id, profesor_id) values
('Taller de Ajedrez', 1, 7),
('Taller de Ajedrez', 5, 7),
('Taller de Ajedrez', 8, 7),
('Taller de Ajedrez', 11, 7),
('Taller de Dibujo', 2, 9),
('Taller de Dibujo', 4, 9);

-- Insercion tabla Notas

insert into notas (fecha_nota, alumno_id, materia_id, profesor_id, nota_numerica) values
('20220415', 1, 1, 6, 9),
('20220415', 2, 1, 6, 8),
('20220415', 3, 1, 6, 5),
('20220415', 4, 1, 6, 2),
('20220415', 5, 1, 6, 8),
('20220415', 1, 1, 6, 9.5),
('20220415', 2, 2, 3, 7);

-- Insercion tabla pagos_cuota

insert into pagos_cuota (fecha_pago, alumno_id, padre_id, num_tarjeta, vto_tarjeta, codseg_tarjeta, cuota) values
('20220301', 1, 1, '4545-3500-3500-4545', '03/28', 123, 20000),
('20220301', 2, 7, '4545-3800-3200-1223', '08/24', 126, 15000),
('20220301', 3, 4, '4549-2345-3500-4301', '03/25', 842, 15000),
('20220301', 4, 14, '4549-2345-3500-4301', '03/25', 842, 20000),
('20220301', 5, 3, '4549-2345-3500-4301', '03/25', 842, 18000),
('20220301', 6, 5, '4549-2345-3500-4301', '03/25', 842, 16000),
('20220301', 7, 2, '4549-2345-3500-4301', '03/25', 842, 20000),
('20220301', 8, 6, '4549-2345-3500-4301', '03/25', 842, 25000),
('20220301', 9, 8, '4549-2345-3500-4301', '03/25', 842, 22000),
('20220301', 10, 9, '4549-2345-3500-4301', '03/25', 842, 20000),
('20220301', 11, 1, '4545-3500-3500-4545', '03/28', 123, 20000),
('20220301', 12, 10, '4545-3800-3200-1223', '08/24', 126, 15000),
('20220301', 13, 11, '4549-2345-3500-4301', '03/25', 842, 17000),
('20220301', 14, 12, '4549-2345-3500-4301', '03/25', 842, 20000),
('20220301', 15, 13, '4549-2345-3500-4301', '03/25', 842, 18000),
('20220301', 16, 15, '4549-2345-3500-4301', '03/25', 842, 16000),
('20220301', 17, 15, '4549-2345-3500-4301', '03/25', 842, 20000),
('20220301', 18, 4, '4549-2345-3500-4301', '03/25', 842, 25000),
('20220301', 19, 11, '4549-2345-3500-4301', '03/25', 842, 22000),
('20220301', 20, 6, '4549-2345-3500-4301', '03/25', 842, 23000),
('20220301', 21, 9, '4549-2345-3500-4301', '03/25', 842, 20000);


-- Insercion tabla preceptores

insert into preceptores (nombre, apellido, email, telefono) values
('Roberto', 'Mancini', 'rmancini@gmail.com', '1125548233'),
('Jose', 'Marangoni', 'jmarangoni@gmail.com', '1122303355'),
('Carla', 'Mujica', 'cmujica@hotmail.com', '1130549199'),
('Maria', 'Robledo', 'rrobledo@outllok.com', '1193459922'),
('Maria Jose', 'Iglesias', 'mjiglesias@gmail.com', '1104557733');

-- Insercion tabla expulsados

insert into expulsados (fecha_expulsion, preceptor_id, alumno_id, padre_id, descripcion) values
('20220302', 1, 21, 9, 'Por insultar a un profesor, accion que atenta contra el art. 5 del manual de convivencia del instituto');

select * from pagos_cuota;
/* CREACION DE 5 TABLAS VISTAS */

-- 1ra tabla vista. 
-- Hago un join para guardar una tabla vista con los nombres de los padres de los alumnos
-- Esta tabla vista utiliza las tablas "padres" y "alumnos" y su objetivo es mostrar el nombre del padre
-- de un determinado alumno evitando la manipulacion de tablas por personas no idoneas

create or replace view padres_de_alumnos as
select t1.alumno_id, t1.nombre, t1.apellido, t1.padre_id, t2.nombre as nombre_padre, t2.apellido as apellido_padre from alumnos as t1 
left join padres as t2 on t1.padre_id=t2.padre_id;

select * from padres_de_alumnos;

-- 2da tabla vista
-- Hago un join para guardar que profesores dictan cada materia y sus respectivos datos
-- Esta tabla vista utiliza las tablas "profesores" y "materias" y su objetivo es mostrar el nombre del profesor
-- que dicta una determinada materia evitando la manipulacion de tablas por personas no idoneas.

create or replace view dictado_materias as
select t1.materia_id, t1.nombre_materia, t1.profesor_id, t2.nombre, t2.apellido, t2.telefono 
from materias as t1
left join profesores as t2 on t1.profesor_id = t2.profesor_id;

select * from dictado_materias;

-- 3ra tabla vista
-- Hago un join para guardar que profesores dictan cada actividad extracurricular y sus respectivos datos
-- Esta tabla vista utiliza las tablas "profesores" y "actividades" y su objetivo es mostrar el nombre del profesor
-- que dicta una determinada actividad evitando la manipulacion de tablas por personas no idoneas.

create or replace view dictado_actividades as
select t1.actividad_id, t1.descripcion, t1.profesor_id, t2.nombre, t2.apellido, t2.telefono 
from actividades as t1
left join profesores as t2 on t1.profesor_id = t2.profesor_id;

select * from dictado_actividades;

-- 4ta tabla vista
-- Hago un join para verificar que alumnos son amonestados y cruzarlo con los datos de sus padres para poder
-- ponerlos en conocimiento del comportamiento de sus hijos. Esta vista usa las tablas "amonestaciones" y "padres"


create or replace view control_amonestados as
select t1.fecha_amonestacion, t1.profesor_id, t1.alumno_id, t1.cantidad_amonestacion, t1.motivo, t2.nombre as Nombre_Padre, t2.apellido as Apellido_Padre, t2.telefono
from amonestaciones as t1
left join padres as t2 on t1.padre_id = t2.padre_id;

select * from control_amonestados;

-- 5ta tabla vista
-- Hago un join para cruzar las tablas de alumnos y la de pagos_cuota con la finalidad de controlar
-- que los alumnos esten al corriente de pago. Esta vista utiliza las tablas "alumnos" y "pagos_cuota"

create or replace view control_pagos as
select t1.fecha_pago, t1.alumno_id, t1.padre_id, t1.cuota, t2.nombre as Nombre_Alumno, t2.apellido as Apellido_Alumno
from pagos_cuota as t1
left join alumnos as t2 on t1.alumno_id = t2.alumno_id;

select * from control_pagos;

/* CREACION DE FUNCIONES */


-- Funcion 1
-- FUNCION QUE SUMA TODAS LAS CUOTAS POR DIA PARA CONOCER CUAL ES LA FACTURACION DEL INSTITUTO.
-- UTILIZA LA TABLA "PAGOS_CUOTA" SUMANDO LOS CONCEPTOS POR DIA UTILIZANDO EL ARGUMENTO INGRESADO.

delimiter //
create function facturacion (fecha date) returns int
deterministic
begin
	declare total int;
	set total=(select sum(cuota) from pagos_cuota where fecha_pago = fecha);
	return total;
end ;
//


select sum(cuota) from pagos_cuota where fecha_pago = '2022-03-01'
select * from pagos_cuota
select facturacion('2022-03-01');
drop function facturacion

-- Funcion 2
-- CREO UNA FUNCION PARA QUE SE CONTROLEN LOS ALUMNOS QUE TIENEN FALTAS. 
-- SE UTILIZA LA TABLA "FALTAS" Y SE FILTRA POR EL ARGUMENTO "ALUMNO"

delimiter //
create function controlar_faltas (alumno int) returns int
deterministic
begin
 declare total int;
 set total=(select alumno_id, count(alumno_id) from faltas where alumno_id = alumno);
  return total;
end ;
//

drop function controlar_faltas;
select count(alumno_id) from faltas where alumno_id = 1;
select controlar_faltas(1);
select * from faltas

-- FIN DE LAS FUNCIONES

/* CREACION DE STORE PROCEDURES */

-- 1ER STORE PROCEDURE
-- CREO UN PROCEDIMIENTO ALMACENADO PARA INSERTAR NUEVOS ALUMNOS EN SU CORRESPONDIENTE TABLA
-- Y NO SE PIERDA TIEMPO INNECESARIAMENTE INGRESANDO UNO POR UNO LOS REGISTROS. EL BENEFICIO ES MAYOR
-- CUANDO SE TIENEN MUCHOS REGISTROS PARA INGRESAR, YA QUE LOS INSERTA DE UNA VEZ. 

DELIMITER //
create procedure ingresar_alumno (IN nombre varchar(50), IN apellido varchar(50), IN fecha_nac date, IN padre_id int)
begin
	insert into alumnos values (nombre, apellido, fecha_nac, padre_id);
end
//

CALL ingresar_alumno ('Martina','Gonzalez','20120504',1);
SELECT padre_id, nombre, apellido from padres where padre_id=1
select t1.alumno_id, t1.nombre, t1.apellido, t1.padre_id from alumnos as t1 
left join padres as t2 on t1.padre_id=t2.padre_id;

-- 2DO STORE PROCEDURE
-- CREO UN PROCEDIMIENTO ALMACENADO PARA INSERTAR NUEVOS PADRES EN SU CORRESPONDIENTE TABLA
-- Y NO SE PIERDA TIEMPO INNECESARIAMENTE INGRESANDO UNO POR UNO LOS REGISTROS. EL BENEFICIO ES MAYOR
-- CUANDO SE TIENEN MUCHOS REGISTROS PARA INGRESAR, YA QUE LOS INSERTA DE UNA VEZ. 


DELIMITER //
create procedure ingresar_padre (IN nombre varchar(50), IN apellido varchar(50), IN telefono varchar(15), IN direccion varchar(50), IN localidad varchar(50))
begin
	insert into padres values (nombre, apellido, telefono, direccion, localidad);
end
//

CALL ingresar_padre ('Juan','Bautista','11-55551212','Moreno 2025', 'CABA');

-- Fin del script


