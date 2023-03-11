-- CREAR LA TABLA DE LIBROS --
CREATE TABLE libros (ID_LIBRO Integer Primary Key, TITULO varchar2(30), AUTOR varchar2(30), Precio float);
INSERT INTO libros values (1,'El quijote','Miguel de cervantes',454.5);
INSERT INTO libros values (2,'Cien anos de soledad','Gabriel G. Marquez',545.4);
INSERT INTO libros values (3,'El alquimista','Paulo Coehlo',636.3);

-- CREAR TABLA EMPLEADOS --
create table EMPLEADOS (
    NOMBRE varchar2(30),
    DOCUMENTO varchar2(30),
    APELLIDO varchar2(30),
    SUELDO number,
    FECHA_INGRESO date
);

-- INSERTAR VALUES EN TABLA EMPLEADOS --
INSERT INTO EMPLEADOS VALUES ('Juan','222222','Perez',300,'10-OCT-1980');
INSERT INTO EMPLEADOS VALUES ('Luis','223333','Lopez',300,'12-MAY-1998');
INSERT INTO EMPLEADOS VALUES ('Marta','224444','Perez',500,'25-AUG-1990');
INSERT INTO EMPLEADOS VALUES ('Susana','225555','Garcia',400,'05-MAY-2000');
INSERT INTO EMPLEADOS VALUES ('Jose Maria','226666','Morales',400,'10-OCT-2005');

/*_____________________________CREAR TABLA LIBROS2 (Practica video 16)________________________________*/ 
create table libros2 (
    codigo number(6), 
    titulo varchar2(40), 
    autor varchar2(30), 
    editorial varchar(20),
    precio number(6,2)
);

create table control(
    usuario varchar2(30),
    fecha date
);

/*_________________________________(Practica video 17)___________________________________*/
create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  seccion varchar2(20)
 );
 
insert into empleados values('22333444','ACOSTA','Ana','Secretaria');
insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria');
insert into empleados values('22999000','FUENTES','Federico','Sistemas');
insert into empleados values('22555666','CASEROS','Carlos','Contaduria');
insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas');
insert into empleados values('23666777','JUAREZ','Juan','Contaduria');