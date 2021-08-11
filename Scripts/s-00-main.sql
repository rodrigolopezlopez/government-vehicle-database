--@Autor: Rodrigo Lopez López - Carlos Giovanni Martínez Gutiérrez
--@Fecha creación: 15/06/2020
--@Descripción: Proyecto Final 'Archivo Principal'

set lines 150

Prompt Creando Usuario 
@s-01-usuarios.sql 

Prompt Creando Entidades 
@s-02-entidades.sql 

Prompt Creando Tablas Temporales
@s-03-tablas-temporales.sql 

Prompt Creando Tablas Externas
@s-04-tablas-externas.sql 

Prompt Creando Secuencias 
@s-05-secuencias.sql 

Prompt Creando Indices 
@s-06-indices.sql 

Prompt Creando Sinónimos 
@s-07-sinonimos.sql 

Prompt Creando Vistas 
@s-08-vistas-sql.sql

Prompt Cargando Datos 
@s-09-carga-inicial.sql 

Prompt Creacion de Triggers 
@s-11-tr-actualizar-notificacion.sql 

@s-11-tr-compound-actualiza-propietario.sql

@s-11-tr-compound-actualizar-vehiculo.sql

@s-11-tr-eliminar-placa.sql

@s-11-tr-insertar-licencia.sql 

@s-11-tr-insertar-notificacion.sql 

Prompt Creacion de Procedimientos 
@s-13-p-crea-vehiculo.sql

@s-13-p-reporte-vehiculo.sql

Prompt Creacion de Funciones
@s-15-fx-concatenar-vehiculo.sql

@s-15-fx-proximos-pagos.sql

@s-15-fx-valida-anio.sql

Prompt creando Procedimiento para Lob 
@s-17-lob-licencia.sql