--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final 'Funcion Valida Anio'


create or replace function valida_anio(
  p_anio number
)
return number 
result_cache relies_on (VEHICULO) is

v_resultado number;

begin 
  if (TO_NUMBER(TO_CHAR(sysdate, 'YYYY')) - p_anio) > 10 then 
    v_resultado := 1; 
  elsif (TO_NUMBER(TO_CHAR(sysdate, 'YYYY')) - p_anio) <= 10 then
    v_resultado := 0;
  end if;

  return v_resultado;
end;
/
show errors
