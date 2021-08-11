--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final 'Funcion Costo Mensual'

create or replace type fechas_varray
  as varray(5) of date;
/

create or replace function proximas_cuotas(
  p_fecha_pago date
)
return fechas_varray

pipelined is

--declaracion de la colección
anio fechas_varray;

begin

  anio := fechas_varray(p_fecha_pago + 365, p_fecha_pago + 2 * 365,
    p_fecha_pago + 3 * 365, p_fecha_pago + 4 * 365, p_fecha_pago + 5 * 365);

  for i in 1 .. anio.last loop
    pipe row(anio(i));
  end loop;
  
  return;
end;
/
show errors

