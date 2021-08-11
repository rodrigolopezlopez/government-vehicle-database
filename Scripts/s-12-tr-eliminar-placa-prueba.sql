--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 17/06/2020
--@Descripción: Proyecto Final 'Trigger Delete Prueba'

set serveroutput on

Prompt =================================================
Prompt Prueba 1.
Prompt Eliminando placa con vehiculo asignado
Prompt ==================================================


declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  delete from placa where placa_id = 1;
  raise_application_error(-20001,
    ' ERROR: El trigger debió evitar la eliminacion de la placa');

exception 
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20010 then
      dbms_output.put_line('OK, prueba 1 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/
show errors


Prompt =================================================
Prompt Prueba 2.
Prompt Eliminando una placa de la base de datos
Prompt ==================================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  delete from placa where placa_id = 3;
  raise_application_error(-20001,
    ' ERROR: El trigger debió evitar la eliminacion de la placa');

exception 
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20011 then
      dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/
show errors


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;