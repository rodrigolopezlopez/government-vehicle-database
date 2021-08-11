--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 15/06/2020
--@Descripción: Proyecto Final 'Consultas'

set lines 256
set trimout on
set tab off

--1. Utilizando Álgebra relacional 
/*
Se desea mostrar el identificador, numero de serie, año y id del estatus de
todos los vehiculos a excepción de los que estén 'En Regla' 
(estatus_vehiculo_id = 1). 
*/

select vehiculo_id, num_serie, anio, estatus_vehiculo_id
from vehiculo 
minus 
(
  select vehiculo_id, num_serie, anio, estatus_vehiculo_id
  from vehiculo
  where estatus_vehiculo_id = 1
);

--2. Utilizando Outer join 
/*
Se desea mostrar el numero de placa, fecha de asignacion, nombre de la 
entidad a la  que pertenecen cada una, y el id del vehiculo (en caso de que 
aplique), para todas las placas registradas en la base de datos, sin importar 
si está asociadas a un vehiculo o no.
*/

select p.num_placa, p.fecha_asignacion, e.nombre as entidad, v.vehiculo_id 
from entidad e 
join placa p 
on e.entidad_id = p.entidad_id
left join vehiculo v
on p.placa_id = v.placa_id;

--3. Utilizando funciones de agregacion y subconsulta en from
/*
Se desea conocer el importe total pagado por los propietarios en todas sus 
cuotas anuales, al igual que los datos de los propietarios (nombre completo, 
RFC y su correo) y los datos del vehiculo asociado (num_serie, año, marca, 
modelo) para los vehiculos que son de carga y particulares a la vez. 
*/

SET NUMWIDTH 9
col nombre_completo format a25 
col marca format a9 
col modelo format a12
col RFC format a14 
col num_serie format a18 
col correo format a24 
column importe_total heading 'IMPORTE|TOTAL'
column propietario_id heading 'PROPIETARIO|ID'
column vehiculo_id heading 'VEHICULO|ID'

select p.propietario_id, (p.nombre || ' ' || p.ap_paterno || ' ' || 
  p.ap_materno) as nombre_completo, p.RFC, p.correo, v.vehiculo_id, v.num_serie, 
  v.anio, ma.descripcion as marca, mo.nombre as modelo, q.importe_total
from vehiculo v 
join propietario p 
on v.propietario_id = p.propietario_id 
join 
(
  select vehiculo_id, sum(importe) as importe_total
  from cuota_anual
  group by vehiculo_id
) q 
on q.vehiculo_id = v.vehiculo_id
join modelo mo
on v.modelo_id = mo.modelo_id
join marca ma 
on ma.marca_id = mo.marca_id
where v.es_particular = 1 
and v.es_carga = 1
and v.es_publico = 0;

--4. Involucrando tabla externa 
/*
Se desea consultar la informacion de los dispositivos que están fuera de 
funcionamiento por alguna razón, estos dispositivos se encuentran en la tabla 
externa dispositivo_antiguo_ext  
*/

select *
from dispositivo_antiguo_ext;

--5. Utilizando sinonimos 
/*
Antes de que los programadores del software comiencen a desarrollar, utilizan 
los sinónimos creados anteriormente. Para probar el funcionamiento de la base 
de datos realizan la siguiente consulta en donde les interesa conocer la 
historia de los propietarios con vehiculos particulares que sean del año 2015 en 
adelante. Los datos de inetres son : id, nombre completo y RFC del propietario, 
id, num_serie y año del vehiculo y finalmente el id del estatus y la fecha en la 
que se registró el status. 
*/
col nombre_completo format a28
col RFC format a14 
col num_serie format a18
col estatus format a27
column propietario_id heading 'PROPIETARIO|ID'
column vehiculo_id heading 'VEHICULO|ID'

select p.propietario_id, (p.nombre || ' ' || p.ap_paterno || ' ' || 
  p.ap_materno) as nombre_completo, p.RFC, v.vehiculo_id, v.num_serie, v.anio,
  s.clave as estatus, h.fecha_estatus
from XX_PROPIETARIO p
join XX_VEHICULO v
on p.propietario_id = v.propietario_id 
join XX_HISTORICO_ESTATUS_VEHICULO h 
on v.vehiculo_id = h.vehiculo_id 
join XX_ESTATUS_VEHICULO s 
on h.estatus_vehiculo_id = s.estatus_vehiculo_id
where v.anio >= 2015
and v.es_particular = 1
and v.es_carga = 0
and v.es_publico = 0;


--6. Utilizando vista 
/*
Se desea realizar la consulta de las mediciones de los contaminantes con 
clave 'HC'. Para facilitar el acceso a estos datos, se creó la vista 
v_dispositivo_medicion.
*/

select *
from v_dispositivo_medicion 
where clave = 'HC';

--7. Utilizando Having 
/*
Se desea conocer a los propietarios (identificador, nombre, apellido_paterno, 
apellido_materno, correo) que tengan más de dos vehiculos registrados en la base 
de datos, a aquellos propietarios se les mandaran sus notificaciones de sus 
vehiculos de forma conjunta. 
*/
col correo format a30  
col nombre_completo format a30

select p.propietario_id,(p.nombre || ' ' || p.ap_paterno || ' ' || p.ap_materno) 
  as nombre_completo, p.correo, q.num_vehiculos
from propietario p
join 
(
  select p.propietario_id, count(*) as num_vehiculos
  from vehiculo v
  join propietario p 
  on v.propietario_id = p.propietario_id
  group by p.propietario_id
  having count(*) > 1
)q 
on p.propietario_id = q.propietario_id;

--8. Involucrando Tabla temporal
/*
Se desea conocer la marca de vehiculos que tiene mas modelos registrados al 
momento de cargar los datos en la base de datos
*/

col marca format a25 col marca format a25 

select r.marca_id, ma.descripcion as marca, count(*) as num_modelos
from reporte_marca_temporal r
join marca ma 
on ma.marca_id = r.marca_id 
group by r.marca_id, ma.descripcion
order by 1;

