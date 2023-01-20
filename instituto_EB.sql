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
nota_numerica numeric(2,2),
foreign key (materia_id) references materias(materia_id),
foreign key (alumno_id) references alumnos(alumno_id),
foreign key (profesor_id) references profesores(profesor_id)
);

create table IF NOT EXISTS pagos_cuota (
pago_id INT auto_increment not null primary key,
fecha_pago DATE not null,
alumno_id INT not null,
padre_id INT not null,
num_tarjeta numeric(16,0) not null,
vto_tarjeta DATE not null,
codseg_tarjeta numeric(3,0),
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
foreign key (alumno_id) references alumnos(alumno_id),
foreign key (padre_id) references padres(padre_id),
foreign key (preceptor_id) references preceptores(preceptor_id)
);

-- Insercion de datos para las tablas 

-- Insercion tabla alumnos

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
