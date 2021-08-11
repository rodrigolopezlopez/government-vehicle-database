--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 04/06/2020
--@Descripción: Proyecto Final 'Entidades'

Promp Conectando a usuario lm_proy_admin 
connect lm_proy_admin/malo

--1. Entidad
create table entidad(
  entidad_id   number(10, 0)  not null, 
  clave        varchar2(10)   not null,
  nombre       varchar2(40)   not null,
  constraint entidad_clave_uk unique(clave), 
  constraint entidad_pk primary key(entidad_id)           
);

--2. Placa
create table placa(
  placa_id          number(10, 0)  not null, 
  num_placa         varchar2(10)   not null, 
  fecha_asignacion  date           not null, 
  entidad_id        number(10, 0)  not null, 
  constraint placa_num_placa_uk unique(num_placa),
  constraint placa_entidad_id_fk foreign key(entidad_id)
    references entidad(entidad_id), 
  constraint placa_pk primary key(placa_id)   
);

--3. Marca
create table marca(
  marca_id      number(10, 0)  not null, 
  clave         varchar2(10)   not null, 
  descripcion   varchar2(80)   not null,
  constraint marca_clave_uk unique(clave), 
  constraint marca_pk primary key(marca_id)
);

--4. Modelo
create table modelo(
  modelo_id   number(10, 0)  not null, 
  nombre      varchar2(40)   not null,
  marca_id    number(10, 0)  not null, 
  constraint modelo_marca_id_fk foreign key(marca_id)
    references marca(marca_id), 
  constraint modelo_pk primary key(modelo_id)  
);

--5. Propietario
create table propietario (
  propietario_id     number(10,0)  not null,
  nombre             varchar2(40)  not null,
  ap_paterno         varchar2(40)  not null,
  ap_materno         varchar2(40)  not null,
  RFC                varchar2(40)      null,
  correo             varchar2(40)  not null,
  constraint propietario_RFC_uk unique(RFC),
  constraint propietario_correo_uk unique(correo),
  constraint propietario_pk primary key(propietario_id)
);

--6. Puntos Negativos
create table puntos_negativos (
  puntos_negativos_id  number(10,0)  not null, 
  fecha_puntos         date          not null,
  cantidad_puntos      number(2,0)   not null,
  PDF                  blob          not null, 
  propietario_id       number(10,0)  not null, 
  constraint puntos_negativos_pk primary key(puntos_negativos_id),
  constraint puntos_negativos_propietario_id_fk
    foreign key(propietario_id) references propietario(propietario_id) 
);

--7. Descripcion Falta
create table descripcion_falta(
  descripcion_falta_id  number(10,0)  not null,
  descripcion           varchar2(80)  not null, 
  puntos_negativos_id   number(10,0)  not null,
  constraint descripcion_falta_pk primary key(descripcion_falta_id),
  constraint descripcion_falta_puntos_negativos_id_fk 
    foreign key(puntos_negativos_id) 
    references puntos_negativos(puntos_negativos_id)
);

--8. Licencia 
create table licencia (
  licencia_id           number(10,0)  not null,
  num_licencia          varchar2(40)  not null,
  foto                  blob          not null,
  firma                 blob              null,
  huella_der            blob              null,
  huella_izq            blob              null,
  periodo_vigencia      number(10,0)  not null,
  licencia_anterior_id  number(10,0)      null,
  propietario_id        number(10,0)  not null,
  constraint licencia_pk primary key(licencia_id),
  constraint licencia_licencia_anterior_id_fk 
    foreign key(licencia_anterior_id) references licencia(licencia_id),
  constraint licencia_propietario_id_fk 
    foreign key(propietario_id) references propietario(propietario_id),
  constraint licencia_num_licencia_uk unique(num_licencia)
);

--9. Dispositivo
create table dispositivo(
  dispositivo_id  number(10,0)  not null,
  num_serie       varchar2(40)  not null,
  fecha_registro  date          not null, 
  constraint dispositivo_pk primary key(dispositivo_id),
  constraint dispositivo_num_serie_uk unique(num_serie)
);

--10. Tipo Medicion
create table tipo_medicion(
  tipo_medicion_id  number(10,0)  not null,
  clave             varchar2(40)  not null,
  nombre            varchar2(40)  not null,
  constraint tipo_medicion_pk primary key(tipo_medicion_id),
  constraint tipo_medicion_clave_uk unique(clave)
);

--11. Notificacion
create table notificacion(
  notificacion_id   number(10,0)  not null,
  num_notificacion  number(1,0)   not null,
  fecha_envio       date          not null,
  constraint notificacion_pk primary key(notificacion_id),
  constraint notificacion_num_notificacion_chk 
    check(num_notificacion in (1,2,3))  
);

--12. Dispositivo Medicion
create table dispositivo_medicion(
  dispositivo_medicion_id  number(10,0)  not null,
  valor                    number(10,4)  not null,
  fecha_registro           date          not null,
  dispositivo_id           number(10,0)  not null,
  tipo_medicion_id         number(10,0)  not null,
  notificacion_id          number(10,0)      null, 
  constraint dispositivo_medicion_pk primary key(dispositivo_medicion_id),
  constraint dispositivo_medicion_dispositivo_id_fk 
    foreign key(dispositivo_id) references dispositivo(dispositivo_id),
  constraint dispositivo_medicion_tipo_medicion_id_fk 
    foreign key(tipo_medicion_id) references tipo_medicion(tipo_medicion_id),
  constraint dispositivo_medicion_notificacion_id_fk 
    foreign key(notificacion_id) references notificacion(notificacion_id),
  constraint dispositivo_medicion_valor_chk 
    check((valor between 0 and 1) and (tipo_medicion_id = 2) or 
    tipo_medicion_id = 1 or tipo_medicion_id = 3 or tipo_medicion_id = 4) 
);

--13. Verificacion
create table verificacion(
  verificacion_id     number(10,0)  not null,
  folio               varchar2(13)  not null,
  fecha_verificacion  date          not null,
  notificacion_id     number(10,0)  not null,
  constraint verificacion_pk primary key(verificacion_id),
  constraint verificacion_notificacion_id_fk 
    foreign key(notificacion_id) references notificacion(notificacion_id),
  constraint verificacion_folio_uk unique(folio),
  constraint verificacion_notificacion_id_uk unique(notificacion_id)
);

--14. Verificacion Medicion
create table verificacion_medicion(
  verificacion_medicion_id  number(10,0)  not null,
  valor                     number(10,4)  not null,
  fecha_verificacion        date          not null,
  tipo_medicion_id          number(10,0)  not null,
  verificacion_id           number(10,0)  not null,
  constraint verificacion_medicion_pk primary key(verificacion_medicion_id),
  constraint verificacion_medicion_tipo_medicion_id_fk 
    foreign key(tipo_medicion_id) references tipo_medicion(tipo_medicion_id),
  constraint verificacion_medicion_verificacion_id_fk 
    foreign key(verificacion_id) references verificacion(verificacion_id),
  constraint verificacion_medicion_valor_chk 
    check((valor between 0 and 1) and (tipo_medicion_id = 2) or 
    tipo_medicion_id = 1 or tipo_medicion_id = 3 or tipo_medicion_id = 4)
);

--15. Estatus_vehiculo
create table estatus_vehiculo(
  estatus_vehiculo_id   number(10, 0)  not null, 
  clave           varchar2(80)    not null, 
  constraint estatus_vehiculo_pk primary key(estatus_vehiculo_id)
);

--16. Vehiculo
create table vehiculo(
  vehiculo_id           number(10, 0)  not null,
  num_serie             varchar2(40)   not null, 
  anio                  number(4)      not null,
  fecha_estatus         date           default sysdate, 
  fecha_inicio          date           not null,
  es_publico            number(1, 0)   not null, 
  es_carga              number(1, 0)   not null,
  es_particular         number(1, 0)   not null,
  placa_id              number(10, 0)  not null, 
  modelo_id             number(10, 0)  not null, 
  propietario_id        number(10, 0)  not null, 
  estatus_vehiculo_id   number(10, 0)  not null, 
  dispositivo_id        number(10, 0)  not null, 
  constraint vehiculo_num_serie_uk unique(num_serie),
  constraint vehiculo_placa_id_uk unique(placa_id),
  constraint vehiculo_dispositivo_id_uk unique(dispositivo_id), 
  constraint vehiculo_placa_id_fk foreign key(placa_id)
    references placa(placa_id), 
  constraint vehiculo_modelo_id_fk foreign key(modelo_id)
    references modelo(modelo_id), 
  constraint vehiculo_propietario_id_fk foreign key(propietario_id)
    references propietario(propietario_id), 
  constraint vehiculo_estatus_vehiculo_id_fk foreign key(estatus_vehiculo_id)
    references estatus_vehiculo(estatus_vehiculo_id), 
  constraint vehiculo_dispositivo_id_fk foreign key(dispositivo_id)
    references dispositivo(dispositivo_id), 
  constraint vehiculo_pk primary key(vehiculo_id), 
  constraint vehiculo_es_publico_chk check(es_publico = 0 or es_publico = 1),
  constraint vehiculo_es_carga_chk check(es_carga = 0 or es_carga = 1),
  constraint vehiculo_es_particular_chk 
    check(es_particular = 0 or es_particular = 1),
  constraint vehiculo_combinacion_chk check(
    (es_publico = 1 and es_carga = 0 and es_particular = 0) or 
    (es_publico = 0 and es_carga = 1 and es_particular = 0) or
    (es_publico = 0 and es_carga = 0 and es_particular = 1) or
    (es_publico = 0 and es_carga = 1 and es_particular = 1)) 
);

--17. Historico estatus vehiculo
create table historico_estatus_vehiculo(
  historico_estatus_vehiculo_id   number(10, 0)   not null, 
  fecha_estatus                   date            not null, 
  estatus_vehiculo_id             number(10, 0)   not null,
  vehiculo_id                     number(10, 0)   not null, 
  constraint historico_estatus_vehiculo_estatus_vehiculo_id_fk 
    foreign key(estatus_vehiculo_id) 
    references estatus_vehiculo(estatus_vehiculo_id), 
  constraint historico_estatus_vehiculo_vehiculo_id_fk foreign key(vehiculo_id)
    references vehiculo(vehiculo_id), 
  constraint historico_estatus_vehiculo_pk 
    primary key(historico_estatus_vehiculo_id) 
);

--18. Historico vehiculo propietario
create table historico_vehiculo_propietario(
  historico_vehiculo_propietario_id  number(10,0)  not null,
  fecha_inicio                       date          not null,
  fecha_fin                          date          default sysdate,
  duracion_meses  as (MONTHS_BETWEEN(fecha_inicio, fecha_fin)) virtual,
  propietario_id                     number(10,0)  not null,
  vehiculo_id                        number(10,0)  not null,
  constraint historico_vehiculo_propietario_pk 
    primary key(historico_vehiculo_propietario_id),
  constraint historico_vehiculo_propietario_propietario_id_fk 
    foreign key(propietario_id) references propietario(propietario_id),
  constraint historico_vehiculo_propietario_vehiculo_id_fk 
    foreign key(vehiculo_id) references vehiculo(vehiculo_id)
);

--19. Cuota Anual 
create table cuota_anual(
  cuota_anual_id   number(10,0)  not null,
  folio            varchar2(40)  not null,
  importe          number(10,2)  not null, 
  fecha_pago       date          not null, 
  vehiculo_id      number(10,0)  not null,
  constraint cuota_anual_pk primary key(cuota_anual_id),
  constraint cuota_anual_vehiculo_id_fk foreign key(vehiculo_id)
    references vehiculo(vehiculo_id),
  constraint cuota_anual_folio_uk unique(folio)
);

--20. Tipo transmision
create table tipo_transmision(
  tipo_transmision_id  number(10, 0)  not null,
  clave                char(1)        not null, 
  descripcion          varchar2(80)   not null, 
  constraint tipo_transmision_clave_uk unique(clave),
  constraint tipo_transmision_pk primary key(tipo_transmision_id)     
);

--21. Tipo licencia
create table tipo_licencia(
  tipo_licencia_id  number(10, 0)  not null, 
  clave             char(1)        not null, 
  descripcion       varchar2(100)   not null, 
  constraint tipo_licencia_clave_uk unique(clave),
  constraint tipo_licencia_pk primary key(tipo_licencia_id) 
);

--22. Vehiculo particular
create table vehiculo_particular(
  vehiculo_id           number(10, 0)  not null, 
  num_bolsas_aire       number(2, 0)  default 2, 
  frenos_ABS            number(1, 0)   not null, 
  tipo_transmision_id   number(10, 0)  not null,
  constraint vehiculo_particular_vehiculo_id_fk foreign key(vehiculo_id)
    references vehiculo(vehiculo_id), 
  constraint vehiculo_particular_pk primary key(vehiculo_id), 
  constraint vehiculo_particular_tipo_transmision_id_fk 
    foreign key(tipo_transmision_id)
    references tipo_transmision(tipo_transmision_id),
  constraint vehiculo_particular_frenos_ABS_chk 
    check(frenos_ABS = 0 or frenos_ABS = 1) 
);

--23. Vehiculo Carga
create table vehiculo_carga(
  vehiculo_id     number(10, 0)  not null, 
  cap_toneladas   number(5, 2)   not null, 
  cap_m_cubico    number(8, 2)       null, 
  num_remolques   number(1, 0)       null, 
  constraint vehiculo_carga_vehiculo_id_fk foreign key(vehiculo_id)
    references vehiculo(vehiculo_id),
  constraint vehiculo_carga_pk primary key(vehiculo_id)     
);

--24. Vehiculo publico
create table vehiculo_publico(
  vehiculo_id        number(10, 0)  not null, 
  num_parados        number(2, 0)   not null, 
  num_sentados       number(2, 0)   not null, 
  tipo_licencia_id   number(10, 0)  not null, 
  constraint vehiculo_publico_vehiculo_id_fk foreign key(vehiculo_id)
    references vehiculo(vehiculo_id),
  constraint vehiculo_publico_pk primary key(vehiculo_id), 
  constraint vehiculo_publico_tipo_licencia_id_fk foreign key(tipo_licencia_id)
    references tipo_licencia(tipo_licencia_id),
  constraint vehiculo_publico_tipo_licencia_id_tipo_chk
    check ((((num_parados + num_sentados) >= 20) and tipo_licencia_id = 3) or 
      ((num_parados = 0) and (num_sentados > 4) and tipo_licencia_id = 2) or 
      ((num_parados = 0) and (num_sentados <= 4) and tipo_licencia_id = 1))
);

--25. Vehiculo log
create table vehiculo_log(
  vehiculo_log_id            number(10, 0)  not null,
  vehiculo_id                number(10, 0)  not null,
  cap_toneladas_anterior     number(5, 2)   not null,
  cap_toneladas_nuevo        number(5, 2)   not null,
  fecha_actualizacion        date           not null,
  usuario_actualiza          varchar(100)   not null, 
  constraint vehiculo_log_pk primary key (vehiculo_log_id),
  constraint vehiculo_log_vehiculo_id_fk 
    foreign key (vehiculo_id) references vehiculo_carga(vehiculo_id)
);
