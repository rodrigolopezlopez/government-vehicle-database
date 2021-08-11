--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Trigger Update Prueba'
 
Prompt copiando imagenes
!rm -rf /tmp/bd
!mkdir -p /tmp/bd
!chmod 777 /tmp/bd
!cp imagenes/licencia-* /tmp/bd
!chmod 755 /tmp/bd/licencia-*

Prompt =================================================
Prompt Prueba 1.
Prompt Actualizando la fecha de envio de una notificacion con numero igual a 3
Prompt ==================================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  update notificacion 
  set fecha_envio = sysdate
  where notificacion_id = 1;
  raise_application_error(-20001,
    ' ERROR: El trigger debió evitar la actualización de la fecha de envio');

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
Prompt Actualizando la fecha de envio de una notificacion con numero menor a 3
Prompt ==================================================

declare
  v_num_notificacion_anterior number;
  v_num_notificacion_nuevo number;

begin

  select num_notificacion
  into v_num_notificacion_anterior
  from notificacion
  where notificacion_id = 5;

  update notificacion 
  set fecha_envio = sysdate
  where notificacion_id = 5;

  select num_notificacion
  into v_num_notificacion_nuevo
  from notificacion
  where notificacion_id = 5;

  if v_num_notificacion_anterior + 1 = v_num_notificacion_nuevo then 
    dbms_output.put_line('OK, prueba 2 Exitosa.');
  else 
     raise_application_error(-20002,
    ' ERROR: El trigger debió aumentar en uno el numero de notificacion');
  end if; 

end;
/
show errors

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
