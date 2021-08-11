--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Procedimiento registro de vehiculos'

set serveroutput on 

create or replace procedure sp_crea_vehiculo(
  p_vehiculo_id in out number,
  p_num_serie in varchar2,
  p_anio in number,
  p_es_publico in number,
  p_es_carga in number,
  p_es_particular in number,
  p_placa_id in out number,
  p_num_placa in varchar2,
  p_entidad_nombre in varchar2,
  p_modelo_id in number,
  p_propietario_id in number,
  p_dispositivo_id in out number,
  p_num_serie_dispositivo in varchar2,
  p_num_bolsas_aire number default null,
  p_frenos_abs number default null,
  p_tipo_transmision_id number default null,
  p_cap_toneladas number default null,
  p_cap_m_cubico number default null,
  p_num_remolques number default null,
  p_num_parados number default null,
  p_num_sentados number default null,
  p_tipo_licencia_id number default null
) is 

-- Variables
v_fecha_estatus date := sysdate;
v_fecha_inicio date := sysdate;
v_fecha_fin date := sysdate;
v_fecha_asignacion date := sysdate;
v_fecha_registro date:= sysdate;
v_estatus_vehiculo_id number := 1;
v_entidad_id number;

begin 
  -- Creando id para el vehiculo
  select vehiculo_seq.nextval 
  into p_vehiculo_id
  from dual;

  -- Creando id para el dispositivo
  select dispositivo_seq.nextval 
  into p_dispositivo_id
  from dual;

  -- Bloque para crear una placa nueva
  begin 
    -- Encontrando el id de entidad
    select entidad_id 
    into v_entidad_id 
    from entidad 
    where nombre = p_entidad_nombre;

    -- Creando id para la placa
    select placa_seq.nextval 
    into p_placa_id
    from dual;

    -- Insertando una nueva placa 
    insert into PLACA (PLACA_ID, NUM_PLACA, FECHA_ASIGNACION, ENTIDAD_ID) 
    values (p_placa_id, p_num_placa, v_fecha_asignacion, v_entidad_id);
  exception
    when no_data_found then 
      dbms_output.put_line('El nombre ingresado de la entidad es incorrecto'); 
      raise; 
  end;

  -- Insertando un nuevo dispositivo
  insert into DISPOSITIVO (DISPOSITIVO_ID, NUM_SERIE, FECHA_REGISTRO) 
  values (p_dispositivo_id, p_num_serie_dispositivo, v_fecha_registro);    

  dbms_output.put_line('Registrando Vehiculo');

  -- Insertando en la tabla vehiculo
  insert into VEHICULO (VEHICULO_ID, NUM_SERIE, ANIO, ES_PUBLICO, ES_CARGA, 
    ES_PARTICULAR, FECHA_ESTATUS, FECHA_INICIO, PLACA_ID, MODELO_ID, 
    PROPIETARIO_ID, ESTATUS_VEHICULO_ID, DISPOSITIVO_ID) 
  values (p_vehiculo_id, p_num_serie, p_anio, p_es_publico, p_es_carga, 
    p_es_particular, v_fecha_estatus, v_fecha_inicio, p_placa_id, p_modelo_id, 
    p_propietario_id, v_estatus_vehiculo_id, p_dispositivo_id);

  -- Insertando entrada al historico estatus
  insert into HISTORICO_ESTATUS_VEHICULO (HISTORICO_ESTATUS_VEHICULO_ID, 
    FECHA_ESTATUS, ESTATUS_VEHICULO_ID, VEHICULO_ID) 
  values (historico_estatus_vehiculo_seq.nextval, v_fecha_estatus, 
    v_estatus_vehiculo_id, p_vehiculo_id);

  -- Insertando entrada al historico propietario
  insert into HISTORICO_VEHICULO_PROPIETARIO (HISTORICO_VEHICULO_PROPIETARIO_ID, 
    FECHA_INICIO, FECHA_FIN, VEHICULO_ID, PROPIETARIO_ID) 
  values (historico_vehiculo_propietario_seq.nextval, v_fecha_inicio, v_fecha_fin, 
    p_vehiculo_id, p_propietario_id);

  -- Validando el tipo
  if p_es_publico = 1 and p_es_carga = 0 and p_es_particular = 0 then 
    insert into VEHICULO_PUBLICO(VEHICULO_ID, NUM_PARADOS, NUM_SENTADOS, 
      TIPO_LICENCIA_ID) 
    values (p_vehiculo_id, p_num_parados, p_num_sentados, p_tipo_licencia_id);

  elsif p_es_publico = 0 and p_es_carga = 1 and p_es_particular = 0 then
    insert into VEHICULO_CARGA (VEHICULO_ID, CAP_TONELADAS, CAP_M_CUBICO, 
       NUM_REMOLQUES) 
    values (p_vehiculo_id, p_cap_toneladas, p_cap_m_cubico, p_num_remolques);

  elsif p_es_publico = 0 and p_es_carga = 0 and p_es_particular = 1 then
    insert into VEHICULO_PARTICULAR (VEHICULO_ID, NUM_BOLSAS_AIRE, FRENOS_ABS, 
      TIPO_TRANSMISION_ID) 
    values (p_vehiculo_id, p_num_bolsas_aire, p_frenos_abs, p_tipo_transmision_id);

  elsif p_es_publico = 0 and p_es_carga = 1 and p_es_particular = 1 then
    -- Insertando registro en dos tablas
    insert into VEHICULO_CARGA (VEHICULO_ID, CAP_TONELADAS, CAP_M_CUBICO, 
      NUM_REMOLQUES) 
    values (p_vehiculo_id, p_cap_toneladas, p_cap_m_cubico, p_num_remolques);

    insert into VEHICULO_PARTICULAR (VEHICULO_ID, NUM_BOLSAS_AIRE, FRENOS_ABS, 
      TIPO_TRANSMISION_ID) 
    values (p_vehiculo_id, p_num_bolsas_aire, p_frenos_abs, p_tipo_transmision_id);
  end if;

exception
  when others then 
    dbms_output.put_line('ERROR: No se inserto el vehiculo, existe un error en los datos');
    raise;

end;
/
show errors
