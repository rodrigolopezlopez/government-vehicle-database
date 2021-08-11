--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 19/06/2020
--@Descripción: Proyecto Final 'Funcion Concatena Vehiculo Prueba'

set serveroutput on 

Prompt =================================================
Prompt Prueba 1.
Prompt Vehiculo publico 
Prompt ==================================================
declare 
  v_vehiculo_id number := 1;
  v_string varchar(200);

cursor cur_vehiculo is
  select num_serie, anio, es_publico, es_carga, es_particular
  from vehiculo 
  where vehiculo_id = v_vehiculo_id; 

begin  
  
  for r in cur_vehiculo loop
    v_string := concatenar_vehiculo(r.num_serie, r.anio, r.es_publico, 
      r.es_carga, r.es_particular);
  end loop;

  dbms_output.put_line('La cadena concatenada es: ' || v_string);
end; 
/ 
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Vehiculo carga 
Prompt ==================================================
declare 
  v_vehiculo_id number := 68;
  v_string varchar(200);

cursor cur_vehiculo is
  select num_serie, anio, es_publico, es_carga, es_particular
  from vehiculo 
  where vehiculo_id = v_vehiculo_id; 

begin  
  
  for r in cur_vehiculo loop
    v_string := concatenar_vehiculo(r.num_serie, r.anio, r.es_publico, 
      r.es_carga, r.es_particular);
  end loop;

  dbms_output.put_line('La cadena concatenada es: ' || v_string);
end; 
/ 
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Vehiculo particular  
Prompt ==================================================
declare 
  v_vehiculo_id number := 160;
  v_string varchar(200);

cursor cur_vehiculo is
  select num_serie, anio, es_publico, es_carga, es_particular
  from vehiculo 
  where vehiculo_id = v_vehiculo_id; 

begin  
  
  for r in cur_vehiculo loop
    v_string := concatenar_vehiculo(r.num_serie, r.anio, r.es_publico, 
      r.es_carga, r.es_particular);
  end loop;

  dbms_output.put_line('La cadena concatenada es: ' || v_string);
end; 
/ 
show errors

Prompt =================================================
Prompt Prueba 4.
Prompt Vehiculo particular y carga 
Prompt ==================================================
declare 
  v_vehiculo_id number := 199;
  v_string varchar(200);

cursor cur_vehiculo is
  select num_serie, anio, es_publico, es_carga, es_particular
  from vehiculo 
  where vehiculo_id = v_vehiculo_id; 

begin  
  
  for r in cur_vehiculo loop
    v_string := concatenar_vehiculo(r.num_serie, r.anio, r.es_publico, 
      r.es_carga, r.es_particular);
  end loop;

  dbms_output.put_line('La cadena concatenada es: ' || v_string);
end; 
/ 
show errors