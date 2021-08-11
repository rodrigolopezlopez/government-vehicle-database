--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 16/06/2020
--@Descripción: Proyecto Final 'Compound Trigger Vehiculo Carga Prueba'


set serveroutput on

Prompt =================================================
Prompt Prueba 1.
Prompt Actualizando un solo registro de vehiculo carga
Prompt ==================================================


declare
v_registro number;

begin
  update vehiculo_carga
  set cap_toneladas = 10
  where vehiculo_id = 66;

  select count(*)
  into v_registro
  from vehiculo_log 
  where vehiculo_id = 66
  and cap_toneladas_nuevo = 10
  and fecha_actualizacion = sysdate;

  if v_registro > 0 then 
    dbms_output.put_line('Registro insertado en VEHICULO_LOG correctamente');
    dbms_output.put_line('OK, prueba 1 Exitosa.');
  else 
    raise_application_error(-20001,
    ' ERROR: El trigger no inserto el registro en VEHICULO_LOG');
  end if;

exception 
  when others then
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Actualizando un grupo de registros de vehiculo carga
Prompt ==================================================


declare
v_registro number;

begin
  update vehiculo_carga
  set cap_toneladas = 20
  where vehiculo_id between 66 and 70;

  select count(*)
  into v_registro
  from vehiculo_log 
  where vehiculo_id between 66 and 70
  and cap_toneladas_nuevo = 20
  and fecha_actualizacion = sysdate;

  if v_registro = 5 then 
    dbms_output.put_line('Registros insertados en VEHICULO_LOG correctamente');
    dbms_output.put_line('OK, prueba 2 Exitosa.');
  else 
    raise_application_error(-20002,
    ' ERROR: El trigger no inserto los registros en VEHICULO_LOG');
  end if;
  
exception 
  when others then
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
end;
/
show errors


col usuario_actualiza format a20;

select *
from vehiculo_log;

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;