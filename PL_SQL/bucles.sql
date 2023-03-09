-- BUCLE WHILE --
DECLARE
    tabla number:= 3; --Tabla de multiplicar
	conteo number:=0;
	resultado number;
BEGIN
    while conteo <= 10 loop
    	resultado:= tabla * conteo;
    	dbms_output.put_line(tabla || 'x' || conteo || ' = ' || resultado);
		conteo:= conteo + 1;
	end loop;
END;

-- BUCLE FOR --
DECLARE
    numero number(2);
BEGIN
    for numero in 1..10 loop
    	dbms_output.put_line('2x' || numero || ' = ' || (numero*2));
	end loop;
END;

-- BUCLES ANIDADOS --
DECLARE
    bucle1 number:=0;
	bucle2 number;
BEGIN
    loop
    	dbms_output.put_line('----------------------------------');
		dbms_output.put_line('Valor del bucle externo: ' || bucle1);
		dbms_output.put_line('----------------------------------');
		bucle2:=0;
		loop
            dbms_output.put_line('Valor del bucle anidado: ' || bucle2);
			bucle2:=bucle2 + 1;
			exit when bucle2 = 5;
		end loop;
    bucle1:= bucle1 + 1;
	exit when bucle1 = 3;
	end loop;
END;

--USO DE LOOP CON UN CONDICIONAL
DECLARE 
    valor number :=10; 
begin 
    loop 
    	dbms_output.put_line(valor); 
		valor := valor + 10; 
		if valor > 20 then 
            exit; 
		end if; 
    end loop; 
	dbms_output.put_line('Valor final es: ' || valor); 
end;

--LO MISMO QUE LA DECLARACION ANTERIOR PERO CON EL CONDICIONAL ABREVIADO
DECLARE 
    valor number :=10; 
begin 
    loop 
    	dbms_output.put_line(valor); 
		valor := valor + 10; 
		exit when valor > 50;
    end loop; 
	-- VALOR FINAL
	dbms_output.put_line('Valor final es: ' || valor); 
end;