-- CREAR TABLA LIBROS2 (Practica video 16)-- 
create table libros2(
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

/*_______________________________TRIGGERS VIDEO 16____________________________*/
create or replace trigger tr_ingresoLibros 
before insert on libros2 -- definimos el control antes de cada insert en la tabla libros
begin
    insert into control values(user,sysdate); -- Accion que hara, en este caso una insercion del usuaro y fecha en tabla control
end tr_ingresoLibros;

select * from control;
insert into libros2 values(100,'Uno','Richard Bach','Planeta',25);

--Buscar los triggers --
select * from user_triggers where trigger_name='tr_ingresiLibros';

/*_______________________________________TRIGGERS(insert) VIDEO 17___________________________________*/
create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  seccion varchar2(20)
 );

create table control(
    usuario varchar2(30),
    fecha date
);
--------------------------------------------------------------------------------------------------------------
create or replace trigger tr_ingresaEmpleados 
before insert on empleados 
for each row -- CON ESTA INDICACION EL INDICACIONES DENTRO DEL BEGIN SE EJECUTARAN EN TODAS LAS FILAS DE LA TABLA
begin
    insert into control values(user,sysdate);
end tr_ingresaEmpleados; 

insert into empleados values('22333444','ACOSTA','Ana','Secretaria');
insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria');
insert into empleados values('22999000','FUENTES','Federico','Sistemas');
insert into empleados values('22555666','CASEROS','Carlos','Contaduria');
insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas');
insert into empleados values('23666777','JUAREZ','Juan','Contaduria');

select * from control;

/*______________________________________TRIGGER(delete) VIDEO 18_____________________________*/
create table alumnos(
    legajo varchar2(4) not null,
    documento varchar2(8) not null,
    nombre varchar2(30) not null,
    curso number(1) not null,
    materia varchar2(15) not null,
    nota_final number(3,2) not null
    );

insert into alumnos values('A234','23333333','LOPEZ ANA',5,'MATEMATICA',9);
insert into alumnos values('A345','24444444','GARCIA CARLOS',6,'MATEMATICA',8.5);
insert into alumnos values('A457','26666666','PEREZ FABIAN',6,'LENGUA',3.2);
insert into alumnos values('A348','25555555','PEREZ PATRICIA',6,'LENGUA',7.85);
insert into alumnos values('A123','22222222','PEREZ PATRICIA',5,'MATEMATICAS',9);
insert into alumnos values('A124','32222222','GONZALES JOSE',5,'BIOLOGIA',9);
insert into alumnos values('A124','32222222','GONZALES JOSE',5,'MATEMATICAS',8);
-----------------------------------------------------------------------------------------------
create or replace trigger tr_borradoAlumnos
before delete on alumnos for each row
begin
    insert into control values(user,sysdate);
end tr_borradoAlumnos;

delete from alumnos where curso=5;
select * from control;

/*__________________________________________TRIGGER(update) VIDEO 19____________________________________________*/
create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  seccion varchar2(20),
  sueldo number(8,2)
 );

create table control(
    usuario varchar2(30),
    fecha date
);

insert into empleados values('22333444','ACOSTA','Ana','Secretaria',500);
insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
insert into empleados values('22999000','FUENTES','Federico','Sistemas',680);
insert into empleados values('22555666','CASEROS','Carlos','Contaduria',900);
insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas',1200);
insert into empleados values('23666777','JUAREZ','Juan','Contaduria',1000);
-------------------------------------------------------------------------------------------------------------
create or replace trigger tr_actualizar 
before update on empleados
for each row
begin
    insert into control values(user, sysdate);
end tr_actualizar;