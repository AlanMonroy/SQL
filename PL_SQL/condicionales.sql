begin
    if a>b then
        dbms_output.put_line('a es mayor que b');
    elsif (b>a) then
        dbms_output.put_line('b es mayor que a');
    else
        dbms_output.put_line('Son iguales');