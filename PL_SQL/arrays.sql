-- USO DE ARRAYS --
DECLARE
	type matriz_nombres is varray(5) of varchar2(20); --Declaramos el array
    type matriz_edades is varray(5) of integer;
	nombres matriz_nombres;	-- Asignamos el array a una variable
	edades matriz_edades;
	total integer;
BEGIN
    nombres:= matriz_nombres('Alan','Victor','Fatima','Luis','Adrian'); --Iniciamos el array con los 5 valores que puede almacenar
    edades:= matriz_edades(24,22,16,40,35);
    total:=nombres.count;
	for f in 1..total loop
        dbms_output.put_line('Nombre: ' || nombres(f) || '	Edad: ' || edades(f));
	end loop;
END