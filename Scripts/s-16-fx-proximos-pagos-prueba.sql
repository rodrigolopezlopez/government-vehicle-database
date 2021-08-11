--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final 'Funcion Costo Mensual Prueba'


set serveroutput on

Prompt =================================================
Prompt Prueba 1.
Prompt Obteniendo fechas de pago de los siguientes 5 años
Prompt desde la última fecha especificada  
Prompt ==================================================

col proximas_cuotas format a90

select proximas_cuotas
((
  select fecha_pago 
  from cuota_anual
  where vehiculo_id = 1
)) 
as proximas_cuotas from dual;
