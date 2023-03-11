/* Funciones
    CASE
*/
create or replace function f_prueba(valor number) return number is
begin
    return valor*2;
end;

SELECT f_prueba(2) as prueba from dual;

-- CREAR UNA FUNCION QUE AGREGUE DEVUELVA EL COSTO SEGUN EL PRECIO --
create or replace function f_costo(valor number) return varchar is
costo varchar(20);
begin
    costo:='';
    if valor<=500 then
        costo:='economico';
    else
        costo:='costoso';
    end if;
    RETURN costo;
end;

select titulo, autor, precio, f_costo(precio) as COSTO from libros;

-- FUNCION CON CASE --
create or replace function diaSemana(dia_numero int) return varchar2 is
dia varchar2(25);
begin
    dia:='';
    case dia_numero
        when 1 then dia:='Lunes';
        when 2 then dia:='Martes';
        when 3 then dia:='Miercoles';
        when 4 then dia:='Jueves';
        when 5 then dia:='Viernes';
        when 6 then dia:='Sabado';
        when 7 then dia:='Domingo';
        else dia:='Numero incorrecto';
    end case;
    return dia;
end;

select diaSemana(8) as "Dia de la semana" from dual;

----------------------------------------------------------------------
create or replace function f_trimestre(fecha date)
   return varchar2
 is
  mes varchar2(20);
  trimestre number;
 begin
   mes:=extract(month from fecha);
   trimestre:=4;
   case mes
     when 1 then trimestre:=1;
     when 2 then trimestre:=1;
     when 3 then trimestre:=1;
     when 4 then trimestre:=2;
     when 5 then trimestre:=2;
     when 6 then trimestre:=2;
     when 7 then trimestre:=3;
     when 8 then trimestre:=3;
     when 9 then trimestre:=3;
     when 10 then trimestre:=4;
     when 11 then trimestre:=4;
     when 12 then trimestre:=4;
   end case;
   return trimestre;
 end;
 
select f_trimestre(to_date('07/07/2021','dd/mm/yyyy')) as TRIMESTRE from dual;