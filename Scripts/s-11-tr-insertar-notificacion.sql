--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Trigger Insert'

set serveroutput on

create or replace trigger tr_insertar_notificacion
  after insert
  on dispositivo_medicion
  for each row

begin 
  
  if :new.notificacion_id is not null then 
    insert into notificacion(notificacion_id, num_notificacion, fecha_envio)
    values(:new.notificacion_id, 1, sysdate);
  end if; 

end; 
/
show errors
