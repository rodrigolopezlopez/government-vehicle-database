--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final 'Funcion Concatena Vehiculo'

create or replace function concatenar_vehiculo(
  p_num_serie varchar2, 
  p_anio number, 
  p_es_publico number, 
  p_es_carga number, 
  p_es_particular number
) return varchar2 is


v_string varchar2(200);

begin 

  v_string := p_num_serie || '-' || TO_CHAR(p_anio);

  if p_es_publico = 1 and p_es_carga = 0 and p_es_particular = 0 then 
    v_string := v_string || '-' || 'PUBLICO';

  elsif p_es_publico = 0 and p_es_carga = 1 and p_es_particular = 0 then
    v_string := v_string || '-' || 'CARGA';

  elsif p_es_publico = 0 and p_es_carga = 0 and p_es_particular = 1 then
    v_string := v_string || '-' || 'PARTICULAR';

  elsif p_es_publico = 0 and p_es_carga = 1 and p_es_particular = 1 then
    v_string := v_string || '-' || 'PARTICULAR' || '-' || 'CARGA';
  end if;

  return v_string;
end;
/
show errors