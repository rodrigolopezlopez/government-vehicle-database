--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Procedimiento reporte de vehiculos Prueba'

set serveroutput on 

Prompt =================================================
Prompt Prueba 1.
Prompt Generando Reportes 
Prompt ================================================== 
begin
  
  dbms_output.put_line('Generando el reporte de los vehiculos');

  sp_reporte_vehiculo();

  dbms_output.put_line('Reporte generado');

exception 
  when others then 
    dbms_output.put_line('Error al crear el reporte del Vehiculo');
    rollback;
    raise;
end;
/

set lines 256
col num_serie format a20
col propietario format a30
col estatus_vehiculo format a30 
col fecha_estatus format a15

select * from reporte_vehiculo_temporal;

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD 
rollback;
