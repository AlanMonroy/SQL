/*  Uso de variables con procedimientos
*/

-- CREAR LA TABLA DE LIBROS --
CREATE TABLE libros (ID_LIBRO Integer Primary Key, TITULO varchar2(30), AUTOR varchar2(30), Precio float);
INSERT INTO libros values (1,'El quijote','Miguel de cervantes',454.5);
INSERT INTO libros values (2,'Cien anos de soledad','Gabriel G. Marquez',545.4);
INSERT INTO libros values (3,'El alquimista','Paulo Coehlo',636.3); 

-- CREAR LA TABLA DONDE SE INSERTARA EL DATO TOMADO POR EL PROCEDURE autorLibro --
CREATE TABLE tabla1(titulo varchar2(40), precio number(6,2));

-- Creacion del PROCEDURE --
CREATE OR REPLACE PROCEDURE autorLibro(aTitulo in varchar2) as v_autor varchar2(20);
BEGIN
    /*Selecciona el campo <autor> de la tabla <libros> donde <titulo> sea igual a <aTitulo> y metelo 
    dentro de la variablem <v_autor>*/
    SELECT autor INTO v_autor from libros where titulo=aTitulo;
    
    /* Inserta en <tabla1> lo que consigas de selecciona el <titulo> y precio de la tabla <libros> donde
    <autor> sea igual a la variable <v_autor>*/
    INSERT INTO tabla1 SELECT upper(titulo), precio from libros where autor=v_autor;
END autorLibro;

EXECUTE autorLibro('El quijote');