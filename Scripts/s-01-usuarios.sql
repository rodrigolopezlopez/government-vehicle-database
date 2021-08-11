--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 02/06/2020
--@Descripción: Proyecto Final 'Usuario y roles'

whenever sqlerror exit rollback

Prompt Conectando como sysdba 
connect sys/system as sysdba 

set serveroutput on

--Eliminando usuario admin en caso de existir
declare 
v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where username = 'LM_PROY_ADMIN';
  if v_count > 0 then
    dbms_output.put_line('Eliminando usuario existente');
    execute immediate 'drop user LM_PROY_ADMIN cascade';
  end if; 
end;
/ 

--Eliminando usuario invitado en caso de existir
declare 
v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where username = 'LM_PROY_INVITADO';
  if v_count > 0 then
    dbms_output.put_line('Eliminando usuario existente');
    execute immediate 'drop user LM_PROY_INVITADO cascade';
  end if; 
end;
/ 

Prompt Creando usuario lm_proy_admin 
create user lm_proy_admin identified by malo quota unlimited on users;

Prompt Creando usuario lm_proy_invitado 
create user lm_proy_invitado identified by malo quota unlimited on users;

--Eliminado rol admin en caso de existir 
declare
  v_count number(1,0);
begin
  select count(*) into v_count
  from dba_roles
  where role ='ROL_ADMIN';

  if v_count > 0 then
    execute immediate 'drop role ROL_ADMIN';
    dbms_output.put_line('Rol eliminado');
  else
    dbms_output.put_line('El rol no existe, no se requiere eliminar');
  end if;
end;
/

--Eliminado rol invitado en caso de existir 
declare
  v_count number(1,0);
begin
  select count(*) into v_count
  from dba_roles
  where role ='ROL_INVITADO';

  if v_count > 0 then
    execute immediate 'drop role ROL_INVITADO';
    dbms_output.put_line('Rol eliminado');
  else
    dbms_output.put_line('El rol no existe, no se requiere eliminar');
  end if;
end;
/

Prompt Creando rol admin 
create role rol_admin;
grant create session, create table, create view, create procedure, 
  create sequence, create public synonym, create synonym, create type, 
  create trigger, create any index to rol_admin;

Prompt Creando rol_invitado
create role rol_invitado; 
grant create session to rol_invitado;

Prompt Asignando rol admin a usuario lm_proy_admin 
grant rol_admin to lm_proy_admin;

Prompt Asignando rol invitado a usuario lm_proy_invitado
grant rol_invitado to lm_proy_invitado;

Prompt Listo!