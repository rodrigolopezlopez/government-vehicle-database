--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 16/06/2020
--@Descripción: Proyecto Final 'Trigger Insert Prueba'

set serveroutput on

Prompt =================================================
Prompt Prueba 1.
Prompt Insertando licencia a propietario que aún no llega al límite de licencias
Prompt ==================================================

insert into LICENCIA (LICENCIA_ID, NUM_LICENCIA, PERIODO_VIGENCIA, FOTO, FIRMA, 
  HUELLA_DER, HUELLA_IZQ, LICENCIA_ANTERIOR_ID, PROPIETARIO_ID) 
values (licencia_seq.nextval, '8500827663', 50, EMPTY_BLOB(), EMPTY_BLOB(), 
  EMPTY_BLOB(), EMPTY_BLOB(), null, 1);

Prompt OK, prueba 1 exitosa.

Prompt =================================================
Prompt Prueba 2.
Prompt Insertando licencia a propietario que ya no puede tener más licencias
Prompt ==================================================

declare
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into LICENCIA(LICENCIA_ID, NUM_LICENCIA, PERIODO_VIGENCIA, FOTO, FIRMA, 
    HUELLA_DER, HUELLA_IZQ, LICENCIA_ANTERIOR_ID, PROPIETARIO_ID) 
  values (licencia_seq.nextval, '8500888623', 70, EMPTY_BLOB(), EMPTY_BLOB(), 
    EMPTY_BLOB(), EMPTY_BLOB(), null, 3);
  raise_application_error(-20001,
    ' ERROR: El trigger debió evitar la insercion de la licencia');

exception 
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20010 then
      dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;
end;
/
show errors

select propietario_id, licencia_id, num_licencia, periodo_vigencia 
from licencia
where propietario_id = 1; 

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
