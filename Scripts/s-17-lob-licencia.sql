--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 18/06/2020
--@Descripción: Proyecto Final 'Procedimiento para la insercion de 
--archivos Blob en tabla licencia'

whenever sqlerror exit rollback
set serveroutput on

Prompt Actualizando datos Blob de licencias 

Prompt conectando como sys
connect sys/system as sysdba 

Prompt creando objeto DATA_DIR
create or replace directory data_dir as '/tmp/bd';
grant read, write on directory data_dir to lm_proy_admin; 

Prompt conectando como usuario lm_proy_admin
connect lm_proy_admin/malo 

Prompt creando procedimiento para cargar archivos Blob.

create or replace procedure p_actualiza_imagen (
    p_licencia_id in number, p_nombre_archivo in varchar2,
    p_tipo in varchar2 ) is 
--Declaracion de variables 
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;

begin 
  v_src_offset := 1;
  v_dest_offset := 1;

  dbms_output.put_line('Cargando imagen para ' || p_nombre_archivo);
  v_bfile := bfilename('DATA_DIR', p_nombre_archivo);

  if dbms_lob.fileexists(v_bfile) = 1 and not dbms_lob.isopen(v_bfile) = 1 then 
      dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
  else raise_application_error(-20001, 'El archivo '
      || p_nombre_archivo
      || ' no existe en el directorio DATA_DIR'
      || ' o el archivo esta abierto');
  end if;

  if p_tipo = 'FOTO' then 
    select foto into v_dest_blob
    from licencia 
    where licencia_id  = p_licencia_id
    for update;
  elsif p_tipo = 'FIRMA' then 
    select firma into v_dest_blob
    from licencia 
    where licencia_id  = p_licencia_id
    for update;
  elsif p_tipo = 'HUELLA_DER' then 
    select huella_der into v_dest_blob
    from licencia 
    where licencia_id  = p_licencia_id
    for update;
  elsif p_tipo = 'HUELLA_IZQ' then 
    select huella_izq into v_dest_blob
    from licencia 
    where licencia_id  = p_licencia_id
    for update;
  else 
    raise_application_error(-20010,'Tipo Inválido');
  end if;

  dbms_lob.loadblobfromfile(
    dest_lob => v_dest_blob,
    src_bfile => v_bfile,
    amount => dbms_lob.getlength(v_bfile),
    dest_offset => v_dest_offset,
    src_offset => v_src_offset);

  dbms_lob.close(v_bfile);
  v_src_length := dbms_lob.getlength(v_bfile);
  v_dest_length := dbms_lob.getlength(v_dest_blob);

  if v_src_length = v_dest_length then
    dbms_output.put_line('Escritura correcta, bytes escritos: '
    || v_src_length);
  else raise_application_error(-20002, 'Error al escribir datos.\n'
    || ' Se esperaba escribir '
    || v_src_length
    || ' Pero solo se escribió '
    || v_dest_length);
  end if;

end;
/
show errors






