--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 16/06/2020
--@Descripción: Proyecto Final 'Prueba de Trigger Update'

set serveroutput on 

Prompt =======================================
Prompt Prueba 1.
prompt Cambio de Propietario valido   
Prompt ========================================
declare 
  v_propietario_actual_id number;
  v_propietario_nuevo_id number;
begin 

  v_propietario_nuevo_id := 2;

  update vehiculo
  set propietario_id = 2
  where vehiculo_id = 1;

  select propietario_id into v_propietario_actual_id 
  from vehiculo 
  where vehiculo_id = 1;

  if v_propietario_nuevo_id = v_propietario_actual_id then 
    dbms_output.put_line('OK, prueba 1 exitosa.');
  else 
    raise_application_error(-20080, 
      'ERROR. No se pudo actualizar el proietario.');
  end if;
 
end;
/
show errors

Prompt =======================================
Prompt Prueba 2.
prompt Propietario nuevo igual al actual  
Prompt ========================================
declare 
  v_codigo number;
  v_mensaje varchar2(1000);
begin 
  update vehiculo
  set propietario_id = 2
  where vehiculo_id = 1;

  raise_application_error(-20080, 'ERROR. El trigger permite actualizar
    actualizar el mismo propietario.');

exception 
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20050 then
      dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/
show errors

--Sentencias para validar resultados

select vehiculo_id, propietario_id, fecha_inicio, fecha_fin 
from historico_vehiculo_propietario 
where vehiculo_id = 1;

select vehiculo_id, fecha_inicio, propietario_id 
from vehiculo 
where vehiculo_id = 1;

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD 
rollback;
