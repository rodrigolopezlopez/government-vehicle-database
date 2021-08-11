--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Procedimiento reporte de vehiculos'

set serveroutput on

create or replace procedure sp_reporte_vehiculo is


cursor cur_reporte_vehiculo is 
  select vehiculo_id, num_serie, (nombre || ' ' || ap_paterno || ' ' || 
    ap_materno) as nombre_completo_propietario, clave, fecha_estatus
  from vehiculo v, propietario p, estatus_vehiculo e
  where v.estatus_vehiculo_id = e.estatus_vehiculo_id
  and v.propietario_id = p.propietario_id;

begin 
  for r in cur_reporte_vehiculo loop
    insert into reporte_vehiculo_temporal(vehiculo_id, num_serie, propietario,
      estatus_vehiculo, fecha_estatus)
    values(r.vehiculo_id, r.num_serie, r.nombre_completo_propietario, r.clave,
      r.fecha_estatus);
  end loop;

exception
  when no_data_found then 
      dbms_output.put_line('El vehiculo_id ingresado es incorrecto'); 
      raise; 
end;
/
show errors




