--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 10/06/2020
--@Descripción: Proyecto Final 'Tabla Externa'

Prompt Conectando como sysdba 
connect sys/system as sysdba 

Prompt Creando directorio tmp_dir
create or replace directory tmp_dir as '/home/carlos/Desktop/ProyectoFinal';

grant read, write on directory tmp_dir to lm_proy_admin;


Promp Conectando a usuario lm_proy_admin 
connect lm_proy_admin/malo


create table dispositivo_antiguo_ext(
  dispositivo_id    number(10, 0)   null,
  num_serie         varchar2(40)    null,
  fecha_salida      date            null
)
organization external(
  type oracle_loader
  default directory tmp_dir
  access parameters
  (
    records delimited by newline 
    fields terminated by ','
    missing field values are null
    (
      dispositivo_id, num_serie, 
      fecha_salida date mask "dd/mm/yyyy"
    )
  )
  location ('dispositivo_antiguo.txt')
)
reject limit unlimited;
