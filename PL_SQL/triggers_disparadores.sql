-- CREAR TABLA LIBROS2 (Practica CLASE 16)-- 
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

/*_______________________________TRIGGERS CLASE 16____________________________*/
create or replace trigger tr_ingresoLibros 
before insert on libros2 -- definimos el control antes de cada insert en la tabla libros
begin
    insert into control values(user,sysdate); -- Accion que hara, en este caso una insercion del usuaro y fecha en tabla control
end tr_ingresoLibros;

select * from control;
insert into libros2 values(100,'Uno','Richard Bach','Planeta',25);

--Buscar los triggers --
select * from user_triggers where trigger_name='tr_ingresiLibros';

/*_______________________________________TRIGGERS(insert) CLASE 17___________________________________*/
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

/*______________________________________TRIGGER(delete) CLASE 18_____________________________*/
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

/*__________________________________________TRIGGER(update) CLASE 19____________________________________________*/
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

select * from empleados;
update empleados set sueldo=sueldo+(sueldo*0.1) where seccion='Secretaria';
select * from control;

/*__________________________________TRIGGER (insert, update y delete) CLASE 20 _______________________________*/
create table control_empleados(
    usuario varchar2(20),
    fecha date,
    arccion varchar2(20)
);
----------------------------------------------------------------------------------------------------------------
create or replace trigger tr_control_empleados
before insert or update or delete on empleados
begin
    if inserting then
        insert into control_empleados values(user,sysdate,'registro');
    end if;
    if deleting then
        insert into control_empleados values(user,sysdate,'borrado');
    end if;
    if updating then
        insert into control_empleados values(user,sysdate,'actualizacion');
    end if;
end tr_control_empleados;

insert into empleados values('22333444','ACOSTA','Ana','Secretaria',500);
insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
delete from empleados where documento='22333444';
update empleados set apellido='RODRIGUEZ',nombre='Alan' where documento='22777888';
select * from empleados;
select * from control_empleados order by fecha;
/*_______________________________________________TRIGGER :NEW :OLD (CLASE 21)_________________________________________________*/
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar(20),
  precio number(6,2)
 );
create table ofertas(
  codigo number(6),
  precio number(6,2),
  usuario varchar2(20),
  fecha date
 );
 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

---------------------------------------------------------------------------------------------------------------
-- Uso de  NEW --
create or replace trigger tr_ingresaLibros
before insert on libros for each row
begin
    if(:new.precio<=30) then
        insert into ofertas values(:new.codigo,:new.precio,user,sysdate);
    end if;
end tr_ingresaLibros;

insert into libros values(155,'El gato con botas','Gaskin','Planeta',28);

-- Uso de NEW y OLD --
create or replace trigger tr_actualizarOfertas
before update of precio on libros for each row -- of precio no parece afectar si lo pongo o quito para este caso, obviamente sirve para realizar la comprobacion solo en caso de que sea afectado el campo precio
begin
    if(:old.precio<=30) and (:new.precio>30) then   --si el precio anterior esta debajo del limite y el nuevo esta por encima se debe eliminar de las ofertas
        delete from ofertas where codigo=:old.codigo;
    end if;
    if(:old.precio>30) and (:new.precio<=30) then   --si el precio anterior es mayor del limite y el nuevo es menor entonces se agrega a las ofertas
        insert into ofertas values(:new.codigo,:new.precio,user,sysdate);
    end if;
end tr_actualizarOfertas;

update libros set precio=25 where codigo = 120;
select * from ofertas;

/*________________________________TRIGGERS CON WHERE e IF (CLASE 22)________________________*/
create table empleados(
  documento char(8),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  sueldo number(8,2)
 );
create table control(
  usuario varchar2(30),
  fecha date,
  documento char(8),
  antiguosueldo number(8,2),
  nuevosueldo number(8,2)
 ); 
insert into empleados values('22333444','ACOSTA','Ana','Secretaria',500);
insert into empleados values('22555666','CASEROS','Carlos','Contaduria',900);
insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
insert into empleados values('22999000','FUENTES','Federico','Sistemas',680);
insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas',1200);
insert into empleados values('23666777','JUAREZ','Juan','Contaduria',1000);
----------------------------------------------------------------------------------------------------------
-- When --
create or replace trigger tr_aumentar_sueldo
before update of sueldo on empleados for each row when(new.sueldo>old.sueldo)
begin
    insert into control values(user,sysdate,:old.documento,:old.sueldo,:new.sueldo);
end tr_aumentar_sueldo;

select * from control;
update empleados set sueldo=600 where documento=22333444;

-- if --
create or replace trigger tr_validar_sueldo
before insert on empleados for each row
begin
    :new.apellido:=upper(:new.apellido);
    if :new.sueldo is null then
        :new.sueldo:=0;
    end if;
end tr_validar_sueldo;

insert into empleados values('2566777','Lopez','Luisa','Secretaria',null);
select * from empleados; 

-- DESHABILITAR UN TRIGGER CLASE 23--
select trigger_name,triggering_event,table_name,status from user_triggers where table_name='Empleados';
alter trigger tr_aumentar_sueldo disable; --enable

/*___________________Manejo de excepsiones con triggers (clase 24)_________________________*/
drop table empleados;
drop table control;

create table empleados(
    documento char(8),
    apellido varchar2(30),
    nombre varchar2(30),
    domicilio varchar2(30),
    seccion varchar2(20),
    sueldo number(8,2)
);

create table control(
    usuario varchar2(30),
    fecha date,
    operacion varchar2(30)
);

insert into empleados values('22222222','Acosta','Ana','Avellaneda 11','Secretaria',1800);
insert into empleados values('23333333','Bustos','Betina','Bulnes 22','Gerencia',5000);
insert into empleados values('24444444','Caseres','Carlos','Colon 333','Contaduria',3000);
----------------------------------------
create or replace trigger tr_control_empleados
before insert or update or delete on empleados for each row
begin
    if(:new.sueldo>500) then
        raise_application_error(-20000,'SUELDO NO PUEDE SUPERAR LOS $5000.00');
    end if;
    insert into control values(user,sysdate,'INSERCION');
    dbms_output.put_line('1');
    if(:old.seccion='Gerencia') then
        raise_application_error(-20000,'No se puede eliminar puesto de gerencia');
    end if;
    dbms_output.put_line('2');
    insert into control values(user,sysdate,'BORRADO');
    if updating('Documento') then
        raise_application_error(-2000,'No se puede actualizar numero de documentos');
    end if;
end tr_control_empleados;

insert into empleados values('56985555','Suarez','Manuel','Calle 3ra No. 54','Informatica',9000);
delete from empleados where seccion='Gerencia';
