--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 16/06/2020
--@Descripción: Proyecto Final 'Trigger Update'

set serveroutput on 

create or replace trigger tr_actualiza_propietario 
  for update of propietario_id on vehiculo 
  compound trigger 

  before each row is 
  --declare 
    v_hist_anterior_id number;
    v_hist_nuevo_id number;
    v_propietario_anterior_id number;
    v_propietario_nuevo_id number;
    v_vehiculo_id number; 
    v_fecha_inicio date;
  begin 
    --Inicializamos variables
    v_propietario_anterior_id := :old.propietario_id;
    v_propietario_nuevo_id := :new.propietario_id;
    v_vehiculo_id := :old.vehiculo_id;

    --Validamos que no sea el mismo propietario 
    if v_propietario_nuevo_id = v_propietario_anterior_id then 
      raise_application_error(-20050,
      'No se pudo actualizar, el propietario a asignar es el mismo 
      que el propietario actual');
    end if;

    --Obtenemos el id del historico_propietario para el propietario a actualizar 
    select historico_vehiculo_propietario_id into v_hist_anterior_id
    from historico_vehiculo_propietario 
    where vehiculo_id = v_vehiculo_id
    and propietario_id = v_propietario_anterior_id;

    dbms_output.put_line('Vehiculo a actualizar: ' || :old.vehiculo_id);    
    dbms_output.put_line('Propietario anterior: ' || :old.propietario_id);
    dbms_output.put_line('Nuevo propietario: ' || :new.propietario_id);  

    --Actualizamos el historico del propietario actual
    --Cambiamos la fecha fin a sysdate para indicar que el periodo terminó
    update historico_vehiculo_propietario 
    set fecha_fin = sysdate
    where historico_vehiculo_propietario_id = v_hist_anterior_id;

  end before each row;

  after each row is 
  --declare 
    v_hist_nuevo_id number;
    v_propietario_nuevo_id number;
    v_vehiculo_id number; 
  begin 
    --Inicializamos variables
    v_propietario_nuevo_id := :new.propietario_id;
    v_vehiculo_id := :new.vehiculo_id; 
    
    --Insertamos registro en el historico para el nuevo propietario
    select historico_vehiculo_propietario_seq.nextval into v_hist_nuevo_id 
    from dual;

    dbms_output.put_line('Insertando nuevo propietario en el historico del 
      vehiculo');

    insert into historico_vehiculo_propietario(historico_vehiculo_propietario_id, 
      fecha_inicio, fecha_fin, propietario_id, vehiculo_id)
    values (v_hist_nuevo_id, sysdate, sysdate, v_propietario_nuevo_id, 
      v_vehiculo_id);

  end after each row;

  after statement is 
  begin
    --Actualizamos la fecha inicio en vehiculo
    update vehiculo 
    set fecha_inicio = sysdate;
    
  end after statement;

  end;
  / 
  show errors; 


