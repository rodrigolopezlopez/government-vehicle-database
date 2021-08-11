--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Trigger Update'

set serveroutput on

create or replace trigger tr_actualizar_notificacion
  before update of fecha_envio
  on notificacion
  for each row

begin 
  if :old.num_notificacion = 3 then 
    raise_application_error(-20010,
      'Se ha alcanzado el maximo numero de notificaciones');
  else 
    :new.num_notificacion := :new.num_notificacion + 1;
  end if;
end;
/
show errors