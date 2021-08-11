--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final ' Prueba de Procedimiento para la insercion 
--de archivos Blob en tabla licencia'

set serveroutput on 

Prompt copiando imagenes
!rm -rf /tmp/bd
!mkdir -p /tmp/bd
!chmod 777 /tmp/bd
!cp imagenes/licencia-* /tmp/bd
!chmod 777 /tmp/bd/licencia-*

Prompt =================================================
Prompt Prueba 1.
Prompt Actualizando foto
Prompt ==================================================
declare 
  v_tam number;
begin 

  p_actualiza_imagen(1, 'licencia-foto-1.jpg', 'FOTO');

  select dbms_lob.getlength(foto) into v_tam
  from licencia 
  where licencia_id = 1;

  if  v_tam > 0 then 
    dbms_output.put_line('OK, prueba 1 Exitosa.');
  else 
    raise_application_error(-20002,
      ' ERROR: No se realizó la actualización');
  end if;

  commit;
end;
/

Prompt =================================================
Prompt Prueba 2.
Prompt Actualizando firma
Prompt ==================================================
declare 
  v_tam number;
begin 

  p_actualiza_imagen(1, 'licencia-firma-1.jpg', 'FIRMA');

  select dbms_lob.getlength(foto) into v_tam
  from licencia 
  where licencia_id = 1;

  if  v_tam > 0 then 
    dbms_output.put_line('OK, prueba 2 Exitosa.');
  else 
    raise_application_error(-20002,
      ' ERROR: No se realizó la actualización');
  end if;

  commit;
end;
/


Prompt =================================================
Prompt Prueba 3.
Prompt Actualizando huella derecha
Prompt ==================================================
declare 
  v_tam number;
begin 

  p_actualiza_imagen(1, 'licencia-huella-der-1.jpg', 'HUELLA_DER');

  select dbms_lob.getlength(foto) into v_tam
  from licencia 
  where licencia_id = 1;

  if  v_tam > 0 then 
    dbms_output.put_line('OK, prueba 3 Exitosa.');
  else 
    raise_application_error(-20002,
      ' ERROR: No se realizó la actualización');
  end if;

  commit;
end;
/

Prompt =================================================
Prompt Prueba 4.
Prompt Actualizando huella izquierda
Prompt ==================================================
declare 
  v_tam number;
begin 

  p_actualiza_imagen(1, 'licencia-huella-izq-1.jpg', 'HUELLA_IZQ');

  select dbms_lob.getlength(foto) into v_tam
  from licencia 
  where licencia_id = 1;

  if  v_tam > 0 then 
    dbms_output.put_line('OK, prueba 4 Exitosa.');
  else 
    raise_application_error(-20002,
      ' ERROR: No se realizó la actualización');
  end if;

  commit;
end;
/

Prompt =================================================
Prompt Prueba 5.
Prompt Actualizando campo invalido
Prompt ==================================================
declare 
  v_tam number;
  v_codigo number;
  v_mensaje varchar2(1000);
begin 

  p_actualiza_imagen(11, 'licencia-huella-izq-1.jpg', 'PDF');
  raise_application_error(-20002,
    ' ERROR: No se realizó la actualización');

exception 
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20010 then
      dbms_output.put_line('OK, prueba 5 Exitosa.');
    else
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
      raise;
    end if;

  commit;
end;
/

Prompt =================================================
Prompt Carga Completa.
Prompt Actualizando Fotos, firmas de licencias y huellas
Prompt ==================================================

begin 
  --Insertamos las fotos en las licencias
  p_actualiza_imagen(2, 'licencia-foto-2.jpg', 'FOTO');
  p_actualiza_imagen(3, 'licencia-foto-3.jpg', 'FOTO');
  p_actualiza_imagen(4, 'licencia-foto-4.jpg', 'FOTO');
  p_actualiza_imagen(5, 'licencia-foto-5.jpg', 'FOTO');
  p_actualiza_imagen(6, 'licencia-foto-6.jpg', 'FOTO');
  p_actualiza_imagen(7, 'licencia-foto-7.jpg', 'FOTO');
  p_actualiza_imagen(8, 'licencia-foto-8.jpg', 'FOTO');
  p_actualiza_imagen(9, 'licencia-foto-9.jpg', 'FOTO');
  p_actualiza_imagen(10, 'licencia-foto-10.jpg', 'FOTO');

  --Insertamos las firmas en las licencias
  p_actualiza_imagen(2, 'licencia-firma-2.jpg', 'FIRMA');
  p_actualiza_imagen(3, 'licencia-firma-3.jpeg', 'FIRMA');
  p_actualiza_imagen(4, 'licencia-firma-4.jpg', 'FIRMA');
  p_actualiza_imagen(5, 'licencia-firma-5.jpg', 'FIRMA');
  p_actualiza_imagen(6, 'licencia-firma-6.jpg', 'FIRMA');
  p_actualiza_imagen(7, 'licencia-firma-7.jpg', 'FIRMA');
  p_actualiza_imagen(8, 'licencia-firma-8.jpg', 'FIRMA');
  p_actualiza_imagen(9, 'licencia-firma-9.jpg', 'FIRMA');
  p_actualiza_imagen(10, 'licencia-firma-10.jpeg', 'FIRMA');

  --Insertamos huellas 
  p_actualiza_imagen(2, 'licencia-huella-der-2.jpg', 'HUELLA_DER');
  p_actualiza_imagen(2, 'licencia-huella-izq-2.jpg', 'HUELLA_IZQ');
  commit;

end;
/


Prompt Mostrando resultados
col nombre_archivo format a30
select licencia_id,dbms_lob.getlength(foto) as longitud_foto, 
  dbms_lob.getlength(firma) as longitud_firma, 
  dbms_lob.getlength(huella_der) as longitud_huella_der,
  dbms_lob.getlength(huella_izq) as longitud_huella_izq
from licencia
where licencia_id <11;
