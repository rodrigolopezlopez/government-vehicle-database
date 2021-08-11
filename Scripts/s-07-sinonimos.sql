-- @Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
-- @Fecha creación: 11/06/2020
-- @Descripción: Proyecto Final 'Sinonimos'

--Sinonimos publicos del usuario admin
grant select on dispositivo to lm_proy_invitado;
grant select on dispositivo_medicion to lm_proy_invitado;
grant select on verificacion to lm_proy_invitado;

create or replace public synonym dispositivo 
  for lm_proy_admin.dispositivo;
create or replace public synonym dispositivo_medicion 
  for lm_proy_admin.dispositivo_medicion;
create or replace public synonym verificacion for lm_proy_admin.verificacion;

--Sinonimos privados del usuario invitado
grant select on vehiculo to lm_proy_invitado;
grant select on licencia to lm_proy_invitado;
grant select on propietario to lm_proy_invitado;

Prompt Conectando como sysdba 
connect sys/system as sysdba 

Prompt Otorgando permisos de sinonimos
grant create synonym to lm_proy_invitado;

Promp Conectando a usuario lm_proy_invitado
connect lm_proy_invitado/malo

create or replace synonym vehiculo for lm_proy_admin.vehiculo;
create or replace synonym licencia for lm_proy_admin.licencia;
create or replace synonym propietario for lm_proy_admin.propietario;

-- Sinonimos para todas las tablas 
Promp Conectando a usuario lm_proy_admin 
connect lm_proy_admin/malo

declare 
  in_schema varchar2(100) := 'LM_PROY_ADMIN';

  cursor cur_tablas is
    select table_name from all_tables where owner = 'LM_PROY_ADMIN';
begin
  for r in cur_tablas loop
    Execute immediate 
      'create synonym ' || 'XX_'|| r.table_name || ' for ' 
        || in_schema || '.' || r.table_name;
  end loop;
end;
/