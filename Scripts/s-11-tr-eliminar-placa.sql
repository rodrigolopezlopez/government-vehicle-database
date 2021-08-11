--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 17/06/2020
--@Descripción: Proyecto Final 'Trigger Delete'

set serveroutput on

create or replace trigger tr_borrar_placa
  before delete
  on placa
  for each row
declare
  v_placa number;

begin 
  select count(*)
  into v_placa
  from vehiculo
  where placa_id = :old.placa_id;

  if v_placa > 0 then
    raise_application_error(-20010,
      'ERROR: Eliminando placa asociada a un vehiculo');
    return;
  else 
    raise_application_error(-20011,
      'ERROR: Eliminando placa que pertenece a la BD');
  end if;
end;
/
show errors