--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 16/06/2020
--@Descripción: Proyecto Final 'Trigger Insert'

set serveroutput on

create or replace trigger tr_insertar_licencia
  before insert
  on licencia
  for each row

declare
  v_num_licencias number;

begin
  select count(*) 
  into v_num_licencias
  from 
  (
    select propietario_id, licencia_id
    from licencia 
    minus 
    select propietario_id, licencia_anterior_id
    from licencia
  )q                      
  where q.propietario_id = :new.propietario_id;
  
  -- Ya esta en el limite de licencias permitidas
  if v_num_licencias = 3 then 
    raise_application_error(-20010,'El propietario no puede tener mas de 3 
      licencias al mismo tiempo');
    return;
  -- Aún se le pueden registrar mas licencias
  else 
    dbms_output.put_line('El propietario registro una nueva licencia');
    dbms_output.put_line('Numero de licencia: ' || :new.num_licencia);
  end if;
end;
/
show errors
