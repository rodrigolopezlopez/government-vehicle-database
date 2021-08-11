--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 16/06/2020
--@Descripción: Proyecto Final 'Compound Trigger Vehiculo Carga'

create or replace trigger tr_actualizar_vehiculo_carga
  for update of cap_toneladas on vehiculo_carga 
  compound trigger

  type vehiculo_actualizado_type is record (
    vehiculo_log_id vehiculo_log.vehiculo_log_id%type,
    vehiculo_id vehiculo_log.vehiculo_id%type,
    cap_toneladas_anterior vehiculo_log.cap_toneladas_anterior%type,
    cap_toneladas_nuevo vehiculo_log.cap_toneladas_nuevo%type,
    fecha_actualizacion vehiculo_log.fecha_actualizacion%type,
    usuario_actualiza vehiculo_log.usuario_actualiza%type
  );

  type cap_toneladas_list_type is table of vehiculo_actualizado_type;

  cap_toneladas_list cap_toneladas_list_type := cap_toneladas_list_type();

  before each row is 

  v_usuario varchar2(60) := sys_context('USERENV','SESSION_USER');
  v_fecha date := sysdate;
  v_index number;

  begin 
    cap_toneladas_list.extend;

    v_index := cap_toneladas_list.last;

    cap_toneladas_list(v_index).vehiculo_log_id := vehiculo_log_seq.nextval;
    cap_toneladas_list(v_index).vehiculo_id := :new.vehiculo_id;
    cap_toneladas_list(v_index).cap_toneladas_anterior := :old.cap_toneladas;
    cap_toneladas_list(v_index).cap_toneladas_nuevo := :new.cap_toneladas;
    cap_toneladas_list(v_index).fecha_actualizacion := v_fecha;
    cap_toneladas_list(v_index).usuario_actualiza := v_usuario;
  end before each row;

  after statement is 

  begin 

  forall i in cap_toneladas_list.first .. cap_toneladas_list.last
    insert into vehiculo_log(vehiculo_log_id, vehiculo_id, 
      cap_toneladas_anterior, cap_toneladas_nuevo, fecha_actualizacion, 
      usuario_actualiza)
    values(cap_toneladas_list(i).vehiculo_log_id, 
      cap_toneladas_list(i).vehiculo_id, 
      cap_toneladas_list(i).cap_toneladas_anterior, 
      cap_toneladas_list(i).cap_toneladas_nuevo, 
      cap_toneladas_list(i).fecha_actualizacion, 
      cap_toneladas_list(i).usuario_actualiza);

  end after statement;
end;
/
show errors
