--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Procedimiento registro de vehiculos Prueba'

set serveroutput on 

alter trigger tr_actualiza_propietario disable;

Prompt =================================================
Prompt Prueba 1.
Prompt Vehiculo publico 
Prompt ==================================================
declare
  v_vehiculo_id number;
  v_dispositivo_id number;
  v_placa_id number;
begin

  dbms_output.put_line('Registrando Vehiculo');
  dbms_output.put_line('========  Datos Generales  ========');
  dbms_output.put_line('Num de serie: 2D4RN3246BR92DTE6');
  dbms_output.put_line('Anio: 2010');
  dbms_output.put_line('Entidad: ZACATECAS');
  dbms_output.put_line('Tipo: Publico');


  sp_crea_vehiculo(
    p_vehiculo_id             =>    v_vehiculo_id,
    p_num_serie               =>    '2D4RN3246BR92DTE6',
    p_anio                    =>    2010,
    p_es_publico              =>    1,
    p_es_carga                =>    0,
    p_es_particular           =>    0,
    p_placa_id                =>    v_placa_id,
    p_num_placa               =>    'D2H57DUA2L',
    p_entidad_nombre          =>    'ZACATECAS', 
    p_modelo_id               =>    1, 
    p_propietario_id          =>    50,
    p_dispositivo_id          =>    v_dispositivo_id,
    p_num_serie_dispositivo   =>    '2U9AH5R3WRT612176',
    p_num_parados             =>    5,
    p_num_sentados            =>    20,
    p_tipo_licencia_id        =>    3
    );

  dbms_output.put_line('El vehiculo se registro correctamente 
    con los siguientes datos: ');
  dbms_output.put_line('Vehiculo_id : '   || v_vehiculo_id ||
                      ' Dispositivo_id: ' || v_dispositivo_id ||
                      ' Placa_id: '       || v_placa_id
    );

exception 
  when others then 
    dbms_output.put_line('Error al crear el Vehiculo');
    rollback;
    raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Vehiculo carga
Prompt ==================================================
declare
  v_vehiculo_id number;
  v_dispositivo_id number;
  v_placa_id number;
begin

  dbms_output.put_line('Registrando Vehiculo');
  dbms_output.put_line('========  Datos Generales  ========');
  dbms_output.put_line('Num de serie: R24RSA2461192DHDE');
  dbms_output.put_line('Anio: 2015');
  dbms_output.put_line('Entidad: CHIAPAS');
  dbms_output.put_line('Tipo: Carga');


  sp_crea_vehiculo(
    p_vehiculo_id             =>    v_vehiculo_id,
    p_num_serie               =>    'R24RSA2461192DHDE',
    p_anio                    =>    2015,
    p_es_publico              =>    0,
    p_es_carga                =>    1,
    p_es_particular           =>    0,
    p_placa_id                =>    v_placa_id,
    p_num_placa               =>    'AAH34DUHOL',
    p_entidad_nombre          =>    'CHIAPAS', 
    p_modelo_id               =>    3, 
    p_propietario_id          =>    54,
    p_dispositivo_id          =>    v_dispositivo_id,
    p_num_serie_dispositivo   =>    '1U9E11R3WRT612FER',
    p_cap_toneladas           =>    100,
    p_cap_m_cubico            =>    20
    );

  dbms_output.put_line('El vehiculo se registro correctamente 
    con los siguientes datos: ');
  dbms_output.put_line('Vehiculo_id : '   || v_vehiculo_id    ||
                      ' Dispositivo_id: ' || v_dispositivo_id ||
                      ' Placa_id: '       || v_placa_id
    );

exception 
  when others then 
    dbms_output.put_line('Error al crear el Vehiculo');
    rollback;
    raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Vehiculo particular 
Prompt ==================================================
declare
  v_vehiculo_id number;
  v_dispositivo_id number;
  v_placa_id number;
begin

  dbms_output.put_line('Registrando Vehiculo');
  dbms_output.put_line('========  Datos Generales  ========');
  dbms_output.put_line('Num de serie: SJERSAAWQ1192D127');
  dbms_output.put_line('Anio: 2018');
  dbms_output.put_line('Entidad: GUERRERO');
  dbms_output.put_line('Tipo: Particular');


  sp_crea_vehiculo(
    p_vehiculo_id             =>    v_vehiculo_id,
    p_num_serie               =>    'SJERSAAWQ1192D127',
    p_anio                    =>    2018,
    p_es_publico              =>    0,
    p_es_carga                =>    0,
    p_es_particular           =>    1,
    p_placa_id                =>    v_placa_id,
    p_num_placa               =>    '5N93KOUGYT',
    p_entidad_nombre          =>    'GUERRERO', 
    p_modelo_id               =>    6, 
    p_propietario_id          =>    82,
    p_dispositivo_id          =>    v_dispositivo_id,
    p_num_serie_dispositivo   =>    '58424VRDETT61AQFR',
    p_num_bolsas_aire         =>    7,
    p_frenos_abs              =>    1,
    p_tipo_transmision_id     =>    1
    );

  dbms_output.put_line('El vehiculo se registro correctamente 
    con los siguientes datos: ');
  dbms_output.put_line('Vehiculo_id : '   || v_vehiculo_id    ||
                      ' Dispositivo_id: ' || v_dispositivo_id ||
                      ' Placa_id: '       || v_placa_id
    );

exception 
  when others then 
    dbms_output.put_line('Error al crear el Vehiculo');
    rollback;
    raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 4.
Prompt Vehiculo particular - carga 
Prompt ==================================================
declare
  v_vehiculo_id number;
  v_dispositivo_id number;
  v_placa_id number;
begin

  dbms_output.put_line('Registrando Vehiculo');
  dbms_output.put_line('========  Datos Generales  ========');
  dbms_output.put_line('Num de serie: F8H9GP69N611922K8P');
  dbms_output.put_line('Anio: 2012');
  dbms_output.put_line('Entidad: HIDALGO');
  dbms_output.put_line('Tipo: Carga y Particular');

  sp_crea_vehiculo(
    p_vehiculo_id             =>    v_vehiculo_id,
    p_num_serie               =>    'F8H9GP69N611922K8P',
    p_anio                    =>    2012,
    p_es_publico              =>    0,
    p_es_carga                =>    1,
    p_es_particular           =>    1,
    p_placa_id                =>    v_placa_id,
    p_num_placa               =>    '99G44DUHAW',
    p_entidad_nombre          =>    'HIDALGO', 
    p_modelo_id               =>    3, 
    p_propietario_id          =>    54,
    p_dispositivo_id          =>    v_dispositivo_id,
    p_num_serie_dispositivo   =>    '1U9ET4R3WRT612DER',
    p_cap_toneladas           =>    45,
    p_cap_m_cubico            =>    2,
    p_num_remolques           =>    1,
    p_num_bolsas_aire         =>    4,
    p_frenos_abs              =>    0,
    p_tipo_transmision_id     =>    2
    );

  dbms_output.put_line('El vehiculo se registro correctamente 
    con los siguientes datos: ');
  dbms_output.put_line('Vehiculo_id : '   || v_vehiculo_id    ||
                      ' Dispositivo_id: ' || v_dispositivo_id ||
                      ' Placa_id: '       || v_placa_id
    );

exception 
  when others then 
    dbms_output.put_line('Error al crear el Vehiculo');
    rollback;
    raise;
end;
/
show errors

col num_serie format a20

select v.vehiculo_id, num_serie, es_carga, es_particular, 
  es_publico 
from vehiculo v 
left join vehiculo_publico p 
on v.vehiculo_id = p.vehiculo_id
left join vehiculo_particular pr 
on v.vehiculo_id = pr.vehiculo_id
left join vehiculo_carga c 
on v.vehiculo_id = c.vehiculo_id
where num_serie = '2D4RN3246BR92DTE6'
or num_serie = 'R24RSA2461192DHDE'
or num_serie = 'SJERSAAWQ1192D127'
or num_serie = 'F8H9GP69N611922K8P';


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD 
rollback;
