--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Trigger Insert Prueba'


set serveroutput on

Prompt =================================================
Prompt Prueba 1.
Prompt Insertando una medicion que genera una notificacion
Prompt ==================================================


declare 
  v_registro number;
  v_notificacion_id number;

begin 
  
  select notificacion_seq.nextval
  into v_notificacion_id
  from dual;
  
  insert into DISPOSITIVO_MEDICION (DISPOSITIVO_MEDICION_ID, VALOR, 
    FECHA_REGISTRO, DISPOSITIVO_ID, TIPO_MEDICION_ID, NOTIFICACION_ID) 
  values (dispositivo_medicion_seq.nextval, 100, sysdate, 60, 1, 
    v_notificacion_id);

  select count(*)
  into v_registro
  from notificacion
  where notificacion_id = v_notificacion_id;

  if v_registro = 1 then
    dbms_output.put_line('Notificacion_id: '||v_notificacion_id);
    dbms_output.put_line('OK, prueba 1 exitosa.');
  else 
    dbms_output.put_line('No se inserto el registro en la tabla notificacion');
  end if;

end;
/
show errors 

select n.notificacion_id, n.fecha_envio, n.num_notificacion
from notificacion n, dispositivo_medicion d 
where n.notificacion_id = d.notificacion_id
and dispositivo_id = 60
and tipo_medicion_id = 1;

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;

