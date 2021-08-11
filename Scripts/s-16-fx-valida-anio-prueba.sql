--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final 'Funcion Valida Anio Prueba'

set serveroutput on

Prompt =================================================
Prompt Prueba 1.
Prompt Vehiculo que ya no puede circular 
Prompt ==================================================

declare
  v_bandera number;
  v_anio  number;
begin 
  select anio 
  into v_anio 
  from vehiculo
  where vehiculo_id = 1; 

  v_bandera := valida_anio(v_anio);

  dbms_output.put_line('Año: ' || v_anio);

  if v_bandera = 1 then 
    dbms_output.put_line('El vehiculo ya no puede circular todos los dias');
  elsif v_bandera = 0 then
    dbms_output.put_line('El vehiculo aun puede circular todos los dias');
  end if; 
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Vehiculo que puede circular 
Prompt ==================================================

declare
  v_bandera number;
  v_anio  number;
begin 
  select anio 
  into v_anio 
  from vehiculo
  where vehiculo_id = 10; 

  v_bandera := valida_anio(v_anio);

  dbms_output.put_line('Año: ' || v_anio);

  if v_bandera = 1 then 
    dbms_output.put_line('El vehiculo ya no puede circular todos los dias');
  elsif v_bandera = 0 then
    dbms_output.put_line('El vehiculo aun puede circular todos los dias');
  end if; 
end;
/
show errors