# Car-Control-Online
Desarrollo de una base de datos para llevar el control y administración de los vehículos a nivel gobierno, incluye análisis lógico y físico. La programación de la bd se realizó haciendo uso de Oracle Database.

## Caso de Estudio
 
Car Control Online es una empresa de la iniciativa privada que esta proponiendo un nuevo modelo al gobierno del país para modernizar y mejorar el control vehicular del país. La base de datos que propone para realizar este proyecto define las siguientes reglas de negocio.

El proceso inicia con la definición del catálogo de entidades del país(clave y nombre). La empresa propone el registro global de un catálogo de placas del automóvil. Se registra el número de placa (hasta 10 caracteres), la entidad a la que pertenece, fecha de asignación. Una placa puede ser asignada a un solo auto. Si lasplacas se dan de baja por parte del dueño del vehículo la placa se marca como inactiva y esta ya no se puede reutilizar. Notar que pueden existir en el catálogo,placassin ser aun asignadas a un vehículo.

El registro de vehículos sigue los siguientes requerimientos: se requiere almacenar marca, modelo y año. Una marca de vehículo define varios modelos.Para el caso de las marcas, secuenta con catálogos en el que se almacena (clave y descripción). Para el caso de los modelos, solo se registra el nombre del modelo.Se guarda el número de serie del vehículo.

Se ha decidido realizarla siguiente clasificación: Vehículos para transporte público, vehículos de carga y vehículos particulares. Para los vehículos decarga se almacena la capacidad en toneladas, y dependiendo del modelo se puede expresar la capacidad en metros cúbicos. En caso de aplicar,se guardael número deremolques que tiene.

Para el caso de los vehículos detransporte público se requiere almacenar el número de pasajerossentados, pasajeros parados que puede transportar. Para tener un mayor control, se requiere almacenar el tipo de licencia que se requiere para poder conducir dicho automóvil: Tipo A licencia para taxis tipo sedán, tipo B, Licencia para camionetas que no pueden transportar pasajeros de pie, y Licencia tipo C para Autobuses y Camiones que tienen capacidad para transportar a 20 o más pasajeros.

Para los autos particulares se requiere almacenar las siguientes características del auto que son requeridas para cálculode seguroe impuesto: número de bolsas de aire, bandera que indica si cuenta con frenos ABS, tipo de transmisión (M = Manual, A = Automática).Se registran los datos del propietario del vehículo: nombre, apellidos, RFC (opcional), licencia(s)y correo electrónico (obligatorio).Un auto cuenta con un solo propietario a la vez.

Para realizar el proceso de verificación se aplica la siguiente regla: A cada vehículo se le deberá instalar un dispositivoque mide y reporta las emisiones de contaminantes. Cada dispositivo cuenta con un número único de serie que se debe registrar al momento de registrar el vehículo.Este dispositivo se comunicará con el sistema central y reportará las siguientes cantidades de contaminantes Hidrocarburos= HC, Monóxidode CarbonoCO en un rango de [0,1], Óxidode Nitrógeno NOx,Dioxido de Carbono CO2. El reporte de las emisiones se realiza cada 10 días. Se requiere guardar estas medidas y la fecha de registro.

En el momento que el sistema detecta que el vehículono cumple con los niveles permitidos, se genera una notificación que se le envía por correoelectrónico. Se requiere registrar el número de notificación (1, 2 o 3), la fecha de envío y elregistro de mediciones que envió el dispositivo que causaron el exceso.

Para llevar un control adecuado de los vehículos, la empresa propone los siguientes estados: EN REGLA, CON LICENCIA EXPIRADA, CON ADEUDO DE IMPUESTO, CON VERIFICACION PENDIENTE. Se requiere conocer en todo momento el estado actual del auto yla historia de cambio de estados a lo largo del tiempo.

Cuando el sistema genera notificaciones, el dueño del automóvil debe acudira verificar su auto. Se registra los datos de la verificación fecha de verificación, folio de verificación (13 caracteres) y un nuevo registro de las emisiones contaminantes. Si el vehículopasa la nueva medida, el status del auto se actualiza a EN REGLA, siempre y cuando no tenga otros adeudos.

A lo largo de la vida útil de un vehículo, este puede tener varios propietarios(uno a la vez). Se ha decidido guardar adicional alpropietario actual, la lista de propietarios que ha tenido el automóvil a lo largo del tiempo. Se requiere guardar el periodo en el que cada propietario tuvo a su cargo dicho automóvil.Cada propietario debe contar con su licencia que tiene un periodo finito de vigencia. Se requiere almacenar los siguientes datos: foto, firma y huella de los índices del propietario, número de licencia, periodo de vigencia. Al término de la vigencia de la licencia, esta debe ser reemplazada por una nueva. Una vez que la nueva licencia ha sido generada, se debe asociar a la licencia que reemplaza(en caso de existir).Cabe mencionar que a un propietario se le permite tener hasta 3 licencias (una por cada tipo de licencia).

Para sostener el mantenimiento y operación del sistema de control de automóviles, a cada auto se le cobra una cuota anual. Se requiere registrar la fecha de pago, el importe y el folio de pago que se realiza por cada automóvil.

Con la finalidad de promover el uso adecuado del automóvil, un propietario puede recibir puntos negativos. Si el propietario acumula 20 o más puntos, perderá su derecho a contar con licencia. Se requiere almacenar la fecha en la que se registran los puntos negativos, descripción de la falta, cantidad de puntos negativos asignados y un documento PDF que contiene el detalle y la evidencia de la(s) faltas cometidas.

Finalmente, algunos automóviles pueden ser usados como autos de carga y particulares a la vez. Por ejemplo, una camioneta adaptada con un compartimiento trasero. Solo para esta combinación, el sistema permite que el mismo automóvil tenga ambos roles.

## Diseños
Diseño físico de la bd
![diseño-fisico-crows-foot](https://user-images.githubusercontent.com/68760775/129112515-e8ce8ab6-f648-4c3f-a88e-d6d075e08ea3.jpg)
