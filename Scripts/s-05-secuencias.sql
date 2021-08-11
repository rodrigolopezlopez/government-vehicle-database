--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 10/06/2020
--@Descripción: Proyecto Final 'Secuencias'

--1. Entidad
create sequence entidad_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle; 

--2. Placa
create sequence placa_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle; 

--3. Marca
create sequence marca_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle; 

--4. Modelo
create sequence modelo_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--5. Propietario
create sequence propietario_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--6. Puntos Negativos
create sequence puntos_negativos_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle; 
--7. Descripcion Falta
create sequence descripcion_falta_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--8. Licencia
create sequence licencia_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;

--9. Dispositivo
create sequence dispositivo_seq
  start with 50 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--10. Tipo Medicion
create sequence tipo_medicion_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--11. Notificacion
create sequence notificacion_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--12. Dispositivo Medicion
create sequence dispositivo_medicion_seq
  start with 1 
  increment by 1 
  nominvalue
  nomaxvalue
  nocycle;  

--13.Verificacion 
create sequence verificacion_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--14. Verificacion_medicion
create sequence verificacion_medicion_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--15. Estatus_vehiculo
create sequence estatus_vehiculo_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--16. Vehiculo 
create sequence vehiculo_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--17. Historico estatus vehiculo 
create sequence historico_estatus_vehiculo_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--18. Historico vehiculo propietario
create sequence historico_vehiculo_propietario_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--19. Cuota Anual 
create sequence cuota_anual_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--20. Tipo transmision
create sequence tipo_transmision_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--21. Tipo licencia
create sequence tipo_licencia_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;

--22. Vehiculo log
create sequence vehiculo_log_seq
  start with 1
  increment by 1
  nominvalue
  nomaxvalue
  nocycle;
  