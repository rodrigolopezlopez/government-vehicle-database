--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 11/06/2020
--@Descripción: Proyecto Final 'Indices'

--4. Modelo - Nombre
create unique index modelo_nombre_iuk on modelo(lower(nombre));

--5. Propietario - Nombre Completo
create index propietario_nombre_completo_ix on 
  propietario(upper(ap_paterno), upper(ap_materno), upper(nombre));

--8. Licencia - Propietario FK
create index licencia_propietario_ix on licencia(propietario_id);

--11. Notificacion - Notificacion - Num Notificacion
create unique index notificacion_num_notificacion_iuk 
  on notificacion(notificacion_id, num_notificacion);

--11. Notificacion - Fecha Envio
create index notificacion_fecha_envio_ix  
  on notificacion(fecha_envio);
 
--12. Dispositivo Medicion - Dispositivo FK
create index dispositivo_medicion_dispositivo_ix 
  on dispositivo_medicion(dispositivo_id);

--12. Dispositivo Medicion - Tipo Medicion FK
create index dispositivo_medicion_tipo_medicion_ix 
  on dispositivo_medicion(tipo_medicion_id);

--12. Dispositivo Medicion - Notificacion FK
create index dispositivo_medicion_notificacion_ix 
  on dispositivo_medicion(notificacion_id);

--13. Verificacion - Fecha Registro
create index verificacion_fecha_verificacion_ix 
  on verificacion(fecha_verificacion);

--14. Verificacion_medicion - Fecha Registro
create index verificacion_medicion_fecha_verificacion_ix 
  on verificacion_medicion(fecha_verificacion);

--14. Verificacion_medicion - Tipo Medicion FK 
create index verificacion_medicion_tipo_medicion_ix 
  on verificacion_medicion(tipo_medicion_id);

--14. Verificacion_medicion - Verificacion FK
create index verificacion_medicion_verificacion_ix 
  on verificacion_medicion(verificacion_id);

--16. Vehiculo - NUM_SERIE
create index vehiculo_num_serie_ix on vehiculo(lower(num_serie));

--16. Vehiculo - Modelo FK
create index vehiculo_modelo_ix on vehiculo(modelo_id);

--16. Vehiculo - Propietario FK
create index vehiculo_propietario_ix on vehiculo(propietario_id);

--16. Vehiculo - Estatus Vehiculo FK
create index vehiculo_estatus_vehiculo_ix on vehiculo(estatus_vehiculo_id);

--19. Cuota Anual - Vehiculo FK
create index cuota_anual_vehiculo_ix on cuota_anual(vehiculo_id);
