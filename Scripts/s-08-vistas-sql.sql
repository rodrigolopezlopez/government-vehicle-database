--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 12/06/2020
--@Descripción: Proyecto Final 'Vistas'

-- Vista vehiculo_propietario
create or replace view v_vehiculo_propietario(
  num_serie, anio, num_placa, nombre_completo, correo   
) as 
select num_serie, anio, num_placa,
  (ap_paterno || ' ' || ap_materno || '' || nombre), correo
from vehiculo v, placa p, propietario pr 
where v.placa_id = p.placa_id
and v.propietario_id = pr.propietario_id;

-- Vista propietario_licencia
create or replace view v_propietario_licencia(
  nombre_completo, correo, num_licencia, periodo_vigencia
) as 
select (ap_paterno || ' ' || ap_materno || '' || nombre), correo, 
  num_licencia, periodo_vigencia
from propietario p, licencia l 
where p.propietario_id = l.propietario_id; 

-- Vista dispositivo_medicion
create or replace view v_dispositivo_medicion(
  num_serie_vehiculo, num_serie_dispositivo, clave, 
  valor, fecha_registro 
) as 
select v.num_serie, d.num_serie, clave, valor, dm.fecha_registro
from vehiculo v, dispositivo d, dispositivo_medicion dm, tipo_medicion t
where v.dispositivo_id = d.dispositivo_id
and d.dispositivo_id = dm.dispositivo_id
and dm.tipo_medicion_id = t.tipo_medicion_id;
