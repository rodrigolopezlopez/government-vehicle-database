--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 10/06/2020
--@Descripción: Proyecto Final 'Tabla Temporal'

--Tabla para realizar reportes 
create global temporary table reporte_vehiculo_temporal (
  vehiculo_id          number(10,0)  not null,
  num_serie            varchar2(40)  not null,
  propietario          varchar2(120) not null,
  estatus_vehiculo     varchar2(80)  not null,
  fecha_estatus        date          not null
) on commit preserve rows;

--Modelo: Tabla para realizar reportes de cuantas coches hay por marca
create global temporary table reporte_marca_temporal(
  modelo_id   number(10, 0)  not null, 
  nombre      varchar2(40)   not null,
  marca_id    number(10, 0)  not null
) on commit preserve rows;
