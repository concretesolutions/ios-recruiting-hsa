#  MovieScope

Proyecto de prueba para ejemplificar la arquitectura MVVM-C. Y un poco de protocol oriented programming.  Este proyecto se conecta a la api abierta de [TheMovieDB](https://developers.themoviedb.org/3/getting-started/introduction). Consultar para mas detalles.

## Getting Started

### Requisitos
 - Git
 - Xcode, versión: 10 en adelante.
 - CocoaPods versión:  1.6.0 en adelante.
 - Mac con macOS versión 10.14 en adelante.
 - iPhone con iOS 12.0 en adelante.

### Instalación

MovieScope utiliza el manager de dependencias cocapods para instalar las librerias.
Primero se debe abrir un terminal en la carpeta contenedora del proyecto  y ejecutar el comando pod install.
Una vez instaladas las pods, abrir el archivo MovieScope.xcworkspace


## Arquitectura

MovieScope utiliza la arquitectura MVVM-C por sus siglas, Model-View-ViewModel Coordinator, esta arquitectura utiliza 4 entidades para su funcionamiento:

Model: Se encarga de guardar la data que es otorgada por la capa de Data. Los viewmodel modifican a esta entidad para cumplir la lógica de negocio.

View: Se encarga de mostrar los elementos visuales en pantalla y de reconocer las interacciones del usuario.  

ViewModel: Se encarga de las operaciones lógicas, procesamiento de datos y de exponer la data de los modelos al view.
 
 Coordinator:  Se encarga de la navegación de la app. (Para mas detalle de este elemento referenciarse al creador de esta propuesta http://khanlou.com/2015/01/the-coordinator/)
 
 ### Porque MVVM-C
 
 La arquitectura tradicional MVVM es una de las más usada actualmente por los programadores iOS para sus proyectos y esto es debido a que es una arquitectura sencilla de implementar, facilmente testeable, que aporta componentes capaces de ser reutilizados. Sin embargo tiene un defecto muy grande: La navegación.
 
 La navegación en iOS es algo que puede ser un terrible dolor de cabeza cuando se trata con apps grandes o con flujos complejos, este problema se resuelve en gran medida con los coordinator. Los coordinator instancian las vistas correspondientes a los flujos y son una opción a las tradicionales segues del storyboard. 
 
 Esto simplifica la navegación y permite que los flujos sean más flexibles y exista una mayor independencia de componentes, con las segues tradicionales y el mismo storyboard ocurre que muchas veces se utiliza al viewcontroller para enviar la data que sera usada por otro viewcontroller/viewmodel, este problema se soluciona con los coordinator.
 
 En nuestra app 'MovieScope' existen 3 flujos/modulos, cada uno administrado por un coordinator, esto es solo para ejemplificar como sería una navegación con multiples coordinators, sin embargo, lo optimo es que existiera un solo coordinator para estos 3 que se llamara 'HomeCoordinator' y que cambiara a un nuevo coordinator cuando existiese un cambio de flujo mayor, por ejemplo: Que añadamos un flujo para comprar boletos de las peliculas.
 
 Los coordinator lamentablemente tienen un gran defecto y es la incapacidad de interactuar directamente con la barra de navegación nativa de iOS. Es por esto que se añade un elemento adicional, el navigationInterceptor el cual notifica al coordinator de las interacciones con el backbutton de la barra de navegación. Otra opcion para este problema seria implementar una barra custom y usarla en vez de la nativa.
 
 ### Ventajas
 
 - Independencia de componentes: Hay 4 entidades separadas que se encargan de un aspecto fundamental de la app. Cada una de estas entidades es independiente y no conoce como trabajan las demás.
 - Reusabilidad: Al eliminar la navegacion de las tareas de los demás componentes, estos se hacen mas reutilizables, supongamos que queramos añadir una nueva vista de lista de peliculas con otro aspecto pero conservando la actual, podriamos reutilizar el viewmodel de ese flujo inyectandolo a la nueva vista.
 - Testeable: Como las entidades se encuentran aisladas son mas faciles de testear.
 - Dinamico y flexible: Los coordinator son muy dinamicos y se pueden adaptar facilemente, un ejemplo de esto es como el  `MovieDetailCoordinator` se puede acceder desde el home y desde la lista de peliculas .
 
 ### Desventajas
 - Complejo para proyectos pequeños: En este proyecto se trata de ejemplificar esta arquitectura, sin embargo si los requirimientos finales de esta app fueran los actuales, no seria la arquitectura más óptima.
 - El ViewModel: Si bien el viewmodel es la entidad que controla la lógica de negocio, aún no se ha podido llegar a un consenso sobre las responsabilidades de este, por lo que muchas veces llevamos al limite los principios SOLID con este componente.
 - No tan intuitivo: Al existir tantos componentes esta arquitectura no es tan intuitiva como lo es MVC.
 
 ### Conclusión
 - No existe arquitectura que sea efectiva en todos los proyectos, pero esta es una bastante escalable y que permite cambios rapidos. Por lo que es muy buena opción para proyectos medianos que escalaran con el tiempo.
 
 ## Capas de la aplicación
 
 Podemos ejemplificar las capas de la aplicación en 3 capas, la ultima dividida en 2 subcapas:

### Capa de presentación
    
Esta capa es la capa visible para el usuario, la que representa la UI/UX. Esta capa es manejada por las entidades view.

### Capa de negocio

El dominio de la lógica de negocio es manejada por las entidades viewmodel, que se encargan de procesar la data para cumplir con los requirimientos estipulados para la app.

### Capa de data

Esta capa es la encargada de acceder a la data usada por las demas capas, en esta app nuestra capa de data se divide en dos:

#### Capa de conexion (network layer)

Capa encargada de acceder a la data de la nube, en nuestra app es la representacion de la conexión con la api de `TheMovieDB`. De esta capa se encargan las clases declaradas en la carpeta `network`.

#### Capa de persistencia (base de datos - coredata)

Capa encargada de mantener la data que extraemos de la nube para ser usada de forma offline por la app. De esta capa se encargan las clases declaradas en la carpeta  `CoreData`. Para la persistencia de datos se ha utilizado CoreData el framework nativo de apple para persistencia en iOS. No debe ser confundido con una base de datos aunque se puede manejar de forma similar. 

En nuestra app la capa de persistencia y la de conexión estan estrechamente relacionadas y eso es debido a que ambas acceden al mismo modelo, así pues cuando la capa de conexión crea un nuevo objeto a partir de una llamada al servicio de la api, la capa de persistencia es consciente de este mismo objeto, esto nos crea un conflicto con la independencia de objetos en el sentido de que al realizar una llamada desde la capa de servicio se le debe notificar a la capa de persistencia por lo que esta no es totalmente independiente. 

Para que ambas capas sean totalmente independientes se debe crear una capa intermediaria, un ejemplo de una capa intermediaria seria el uso de plain old swift objects (POSO), los cuales se encargarían de pasar la data de un objeto de una de las capas a la otra. Referencia: https://academy.realm.io/posts/isolating-your-data-layer/.

## La responsabilidad única

El principio de responsabilidad única, conforma uno de los 5 principios SOLID de la programacion orientada a objetos. Este principio nos indica crear objetos que solo mantengan una única tarea y que solo cambien por una razon en especifica, supongamos que no tuvieramos el viewmodel y nuestro viewcontroller se encargara no solo de mostrar la data procesada en la capa de lógica de negocio, sino que tambien se encargara de procesar la data, este es un abismo comunmente llamado `massive view controller` y una falta clara a este principio.

Este concepto es muy subjetivo y tipicamente varia de programador en programador, pero a mi opinion lo más importante es como cada clase interactua con cada capa de la aplicación y como un cambio en esta clase puede afectar a otras clases.

Con esta arquitectura ejemplificamos el principio de responsabilidad única, cada modulo se encarga de una tarea y cada clase, metodo o manager se encarga de su propia capa, cada objeto tiene una tarea única en la app.  Por ejemplo supongamos que se requere cambiar la lógica en la que se muestras las categorias de las peliculas en nuestro  flujo `home`, supongamos que no queramos que se muestren primeros las peliculas de `upcoming` sino las de `top rated`, este cambio a nivel de lógica de negocio se realiza en la entidad `viewmodel` y no debiese afectar las demás capas ni a las demás clases. 

Para llevar los principios SOLID al mayor nivel en apps de iOS lo mejor es utilizar la arquitectura VIPER ya que esta aplica al maximo los principios antes mencionados, muchas veces cuando pensamos en SOLID tambien tenemos que ver el alcance, mantenimiento y escalabilidad de nuestro software. Hay que hacernos estas preguntas al crear un objeto: ¿Esto puede cambiar en el tiempo?, ¿Como puede afectar a las demás clases?. 

 
 ## Un código limpio
 
 Un código limpio es un codigo robusto, flexible que se pueda cambiar facilmente, que se adapta a cualquier nuevo feature, que se pueda refactorizar rapidamente,  un código limpio tambien debe explicarse por si mismo,  entre mas pequeño las lineas de código mejor.
 
 ## Estructura de carpetas
 
- **MovieScope**
    - **Modules**
        - Este es el patron generico de flujos, cada flujo que requiera de una vista seguira este patron
        - **View**
        - **ViewController**
        - **ViewModel**
        - **Model**
        - **Coordinator**
    - **DataProvider**
        - Contiene la declaracion del manager de data, este se encarga de enviar al ViewModel la data que este le requiere.
    - **Network**
        - Contiene la capa de internet de la capa de data. En ella se declaran los servicesRouters, entidades dedicadas a armar las request usadas para obtener la data de las api.
    - **CoreData**
        - Contiene la capa de persistencia del data layer. En ella estan declaran los queryRouter, entidades dedicadas a armar los predicados de que son usados para extraer los objetos de coredata.
    - **Utils**
        - Contiene modelos y vistas usados por toda la aplicación.
    - **Resources**
        - Contiene recursos de imagenes y colores.
    - **Extensions**
        - Contiene extensiones que afectan directamente a clases del UIKit o clases que son usadas por toda la app.
    - **Support**
        - Contiene archivos de soporte del proyecto, tal como el appdelegate y el info.plist.

## Librerias

A continuación un listado de las librerias utilizadas:

- [Alamofire](https://github.com/Alamofire/Alamofire)
    - Libreria de conexiones http para el consumo de api rest.
    
- [Nuke](https://github.com/kean/Nuke)
    - Libreria de carga y guardado de cache de imagenes remotas.
    
## Licencia
Este proyecto se encuentra bajo la [MIT License](https://opensource.org/licenses/MIT).  Dicho esto es un proyecto con fines educativos.

