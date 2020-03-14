# k8s_training

k8s
-------------
**Índice**   
1. [Chapter 1. From Monolith to Microservices](#chapter1)
2. [Chapter 2. Container Orchestration](#chapter2)
3. [Chapter 3. Kubernetes](#chapter3)
4. [Chapter 4. Kubernetes Architecture](#chapter4)
5. [Chapter 5. Installing Kubernetes](#chapter5)
6. [Chapter 6. Minikube - A Local Single-Node Kubernetes Cluster](#chapter6)
7. [Chapter 7. Accessing Minikube](#chapter7)
8. [Chapter 8. Kubernetes Building Blocks](#chapter8)
9. [Chapter 9. Authentication, Authorization, Admission Control](#chapter9)
10. [Chapter 10. Services](#chapter10)
11. [Chapter 11. Deploying a Stand-Alone Application](#chapter11)
12. [Chapter 12. Kubernetes Volume Management](#chapter12)
13. [Chapter 13. ConfigMaps and Secrets](#chapter13)
14. [Chapter 14. Ingress](#chapter14)
15. [Chapter 15. Advanced Topics](#chapter15)
16. [Chapter 16. Kubernetes Community](#chapter16)

## Chapter 1. From Monolith to Microservices<a name="chapter1"></a>
## 1. From Monolith to Microservices
### 1.1. The legacy Monolith
This boulder represents the monolith application - sedimented layers of features and redundant logic translated into thousands of lines of code, written in a single, not so modern programming language, based on outdated software architecture patterns and principles.

The new features and improvements added to code complexity, making development more challenging - loading, compiling, and building times increase with every new update. 

Being a large, single piece of software which continuously grows, it has to run on a single system which has to satisfy its compute, memory, storage, and networking requirements. The hardware of such capacity is both complex and pricey.

Since the entire monolith application runs as a single process, the scaling of individual features of the monolith is almost impossible. It internally supports a hardcoded number of connections and operations. However, scaling the entire application means to manually deploy a new instance of the monolith on another server, typically behind a load balancing appliance - another pricey solution.

During upgrades, patches or migrations of the monolith application - downtimes occur and maintenance windows have to be planned as disruptions in service are expected to impact clients. While there are solutions to minimize downtimes to customers by setting up monolith applications in a highly available active/passive configuration, it may still be challenging for system engineers to keep all systems at the same patch level.


### 1.2. The Modern Microservice.
Similitudes:
- Monolito       --> Gran roca
- Microservicios --> Guijarros

Los guijarros representan la totalidad de la roca individualmente. También son faciles de seleccionar y agrupar en base al color, tamaño y forma.
Los microservicios pueden ser desplegados individualmente en servidores separados provistos con los recuros necesarios para cada servicio.
La arquitectura basada en microservicios está alineada con la Arquitectura Dirigida por Eventos y Arquitectura Orientada a Servicios, donde las aplicaciones complejas están compuestas por pqeueños procesos que se comunican entre si por medio de APIs.
Los microservicios se desarrollan en un lenguaje moderno y el más adecuado para cada servicio. Permite elegir hardware para cada servicio.
La naturaleza distribuida de los servicios añade complejidad a la arquitectura, pero añade beneficios en cuanto a la escalabilidad. Permite no tener inactividad.


### 1.3. Refactoring
Una aplicación multiproceso (monolito), no puede funcionar como un microservicio. Por lo tanto, se necesita refactorizar (Big-Bang ó refactorización incremental):
* __Big-bang:__                    Bloquea el desarrollo y nuevas características para centrarse en la refactorización
* __Refactorización incremental:__ Permite que se desarrollen nuevas características y se apliquen como microservicios modernos que puedan comunicarse con la API. 
                               Mientras tantos las características actuales del monolito se refactorizaran, y este irá desvaneciendo lentamente.


### 1.4. Challenges
Para algunas aplicaciones, puede ser más económico reconstruirlas que refactorizarlas.
Las aplicaciones estrechamente unidas a almacenes de datos, son candidatas pobres a la refactorización.

Una vez que el monolito ha sobrevivido a la refactorización, el siguiente reto es diseñar mecanismos o encontrar herramientas adecuadas para mantener vivos todos los módulos desacoplados.
Si se despliegan muchos módulos en un solo servidor, lo más probable es que las diferentes librerias y el entorno de tiempo de ejecución, puedan entrar en conflicto. 
Esto obliga a separar modulos por servidor, y no es una forma económica de gestión de recursos. 
Entonces aparecieron los contenedores, que proporcionan entornos encapsulados. 
El amplio soporte de los contenedores aseguró la portabilidad  de las aplicaciones del metal a las máquinas virtuales, pero esta vez con múltiples aplicaciones desplegadas en el mismo servidor.



## Chapter 2. Container Orchestration<a name="chapter2"></a>
## 2. Container Orchestration
### 2.1. What Are Containers?
* Contenedores: Son aplicaciones que ofrecen alto rendimiento y escalabilidad. Son los más adecuados para ofrecer microservicios, ya que proporcionan entornos virtuales portatiles y aislados.
!image 2.1.png

* Microservicios: Son aplicaciones ligeras escritas en varios lenguajes modernos, con dependencias, librerias y requisitos ambientales especificos. 
Los contenedores encapsulan los microservicios y sus dependencias pero no los ejecutan directamente. Los contenedores ejecutan imágenes de contenedores.

* Imagen de contenedor: Agrupa la aplicación junto con su tiempo de ejecución y sus dependencias, ofreciendo un entorno ejecutable aislado.


### 2.2. What Is Container Orchestration?
En los entornos de desarrollo la ejecución de contenedores en un solo host, puede ser una opción. Sin embargo, para entornos productivos ya no es una opción viable, ya que debe cumplir una seria de requisitos:
* Tolerancia a fallos
* Escalabildiad a petición
* Uso óptimo de los recursos.
* Autodescubrimiento para la comunicación entre si.
* Accesibilidad desde el exterior
* Actualizaciones y rollbacks sin downtime.

Los orquestadores de contenedores es una herramienta que permite automatizar los despliegues y la gestión de contenedores, al mismo tiempo que cumple con los requisitos anteriores. 


### 2.3. Container Orchestrators
Algunos orquestadores:
* AWS ECS
* Azure Container Instances
* Nomad
* Kubernetes
* Docker Swarm


### 2.4. Why Use Container Orchestrators?
Aunque podemos mantener manualmente un par de contenedores, los orquestadores facilitan mucho las tareas.

La mayoría de contenedores puede:
* Agrupar host mientras se crear un cluster
* Programar contenedores para que corran en cluster en funcion de la disponibilidad de los recursos.
* Permite que los contenedores de cluster se comuniquen entre si.
* Gestionar y optimizar el uso de recursos
* Permitir una implementación de políticas para el acceso seguro a las aplicaciones que corren en los contenedores.


### 2.5. Where to Deploy Container Orchestrators?
Los orquestadores pueden ser desplegados en bare metal, máquinas virtuales, on-premise, o nube pública.



## Chapter 3. Kubernetes<a name="chapter3"></a>
## 3. Kubernetes
### 3.1. What Is Kubernetes?
Kubernetes es un sistema de código abierto (OpenSource) para automatizar el despliegue, el escalado y la gestión de aplicaciones en contenedores.

Kubernetes viene del griego, que significa timonel. También se le conoce como k8s.
Kubernetes, se inspira mucho en el sistema de Google Borg, un orquestador de contenedores escrito en Go.
Kubernetes fue iniciado por Google, y con el lanzamiento de la v1 en 2015, fue donado a CNCF

3.2. From Borg to Kubernetes
El sistema de Borg de Google, es un administrador de Clusteres que ejecuta cientos de miles de trabajos, de muchos miles de aplicaciones diferentes, a través de varios clusteres, cada uno con decenas de miles de máquinas.

Durante más de una década, Borg ha sido el secreto de Google, gestionando servicios como Gmail, Drive, Maps, etc

Algunas características de kubernetes, son heredadas de Borg, son:
* API Servers
* Pods
* IP-per-Pod
* Services
* Labels


### 3.3. Kubernetes Features I
Kubernetes ofrece un conjunto de características para la orquestación:
* Automatic bin packing: programan en base a los recuros necesarios y limitaciones, para maximizar su utilización sin sacrificar la disponibilidad.
* Self-healing: Reemplaza y reprograma automáticamente los contenedores de los donos que fallan. Mata y reinicia los contenedores que no responden a los HealthCheck. También, enviata que se dirija el tráfico a contenedores que no responden.
* Horizontal scaling: se escalan manual o automáticamente las aplicaciones, en base a métricas.
* Service discovery and Load Balancing: Los contenedores reciben sus propias direcciones IPs, mientras que se asigna un único DNS a un conjunto de contenedores para ayudar al balanceo de carga.


### 3.4. Kubernetes Features II
* Automated rollouts and rollbacks: Despliegan y retroceden sin problema las actualizaciones de la aplicación y los cambios de configuración, supervisando constantemente la salud de la aplicación, evitando así inactividad.
* Secret and configuration management: Gestiona los secretos y detalles de la configuración de una aplicación por separado de la imagen del contenedor, con el fin de evitar la reconsctrucción de la imagen respectiva. Los secretos consisten en información confidencial que se le pasa a la aplicación sin revelar el contenido, como en GitHub.
* Storage orchestration: montan automáticamente soluciones de almacenamiento definidas por software en contenedores de almacenamiento local, proveedores de nube externos o sistemas de almacenamiento en red.

* Batch execution: apoya la ejecución por lotes, los trabajos de larga duración y reemplaza los contenedores que fallan.

Muchas otras características están por llegar aunque se encuentran en base beta. Otras, ya están estabales y aportan grandes beneficios como el control de acceso basado en roles (RBAC), estable desde la 1.8


### 3.5. Why Use Kubernetes?
K8s es portatil y extensible. La arquitectura de k8s es modular y enchufable. 
No solo orquesta aplicaciones de tipo microservicio desacoplado, si no que su arquitectura sigue patrones de los microservicios desacoplados. 
Pueden escribirse recursos personalizados, operadores APIs, reglas de programación o plugins.


### 3.6. Kubernetes Users
Algunos usuarios que utilizan k8s:
* BlaBlaCar
* eBay
* IBM
* Huawei
* ING


### 3.7. Cloud Native Computing Foundation (CNCF)
Es uno de los proyectos alojados por Linux-Foundation. 
Tiene como objetivo acelarar la adopción de contenedores, microservicios y aplicaciones nativas de la nube.

Algunos proyectos:
* Kubernetes
* Prometheus
* Envoy
* CoreDNS
* containerd
* Fluentd

Incuvando:
* CRI-O y rkt
* Linkerd
* etcd
* gRPC
* CNI
* Harbor
* Helm
* Rook y Vitess
* Notary
* TUF
* NATS
* Jaeger y OpenTracing
* Open Policy Agent


### 3.8. CNCF and Kubernetes
Para k8s, CNCF:
* Hogar neutral para la marca registrada, hace cumplir el uso adecuado.
* Proporciona una licencia para escanear el código del nucleo y del proveedor.
* Ofrece oritentación jurídica sobre cuestiones de patentes y derechos de autor.
* Crea un plan de estudios de aprendizaje de código abierto, formación y certificación tanto para los administradores como para los desarrolladores de k8s.
* Gestiona un gruop de trabajo de conformidad con el software.
* Comercializa activamente Kubernetes.



## Chapter 4. Kubernetes Architecture<a name="chapter4"></a>
## 4. Kubernetes Architecture
### 4.1. Kubernetes Architecture
A un nivel muy alto, kubernetes cuenta con los siguientes componnentes principales:

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.1_KubernetesArchitecture.png)

* Uno o más nodos maestros
* Uno o más nodos trabajadores
* Base de datos distribuidad, clave-valor, __etcd__


### 4.2. Master Node
El __Master Node__, proporciona un entorno de ejecución, es el reponsable de gestionar el estado del cluster de k8s, y es el cerebro detrás de todas las operaciones.
Para comunicarse con el cluster, los usuarios envian solicitudes al __Master Node__ a través de la __CLI__, un panel de control de interfaz de usuario o una interfaz gráfica de programación __(API)__.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.2_KubernetesMasterNode.png)

Es importante mantener el plano de control. Perder el plano de control puede introducir tiempos de inactividad, causando la interrumpción del servicio a los clientes. 
Para asegurar tolerancia a fallos, se añaden réplicas del __Master Node__ al cluster, configurandolo así, en modo HA.
Solo uno de los __Master Node__ administra activamente el cluster, el resto de componentes permanencen sincronizados con el resto de réplicas master. 

Para mantener el estado del cluster de k8s, todos los datos de la configuración del cluster se guardan en __etcd__. 
Sin embargo, etcd es un almacenamiento __clave-valor distribuido__, que solo guarda datos relacionados con el estado del cluster. 
Está configurado en el __Master Node__ y ubicado en un host dedicado, para evitar las posibilidades de pérdidas.


### 4.3. Master Node Components
Un __Master Node__ tiene los siguientes componentes:
* API Server
* Scheduler
* Controller managers
* etcd


### 4.4. Master Node Components: API Server
Todas las tareas administrativas, están coordinadas por __kube-apiserver__. 
El __API Server__, intercepta las llamadas RESTfull de los usuarios, operadores y agentes externos, las valida y las procesa. 
Durante el procesamiento, __API Server__, lee  el estado del cluster desde __etcd__, y despues de la llamada, el estado resultante del cluster de k8s se guarda en __etcd__.

__API Server__, es el único componente que habla con __etcd__, tanto para leer como para escribir, actuando como una interferfaz de intermediario.
__API Server__ es configurable, también adminte la adición de API Servers personalizados, cuando el API Server primario se convierte en un proxy de todos los servidores API.


### 4.5. Master Node Components: Scheduler
El role del __Scheduler__ es asignar nuevos objetos a los __Pods__ de los __Nodes__. 
Durante el proceso de programación, las decisiones se toman en base al estado actual del cluster, y a los requisitos de los nuevos objetos.
El __scheduler__, obtiene de __etcd__, a través de __API Server__, los datos de uso de recursos de cada nodo del cluster.
El __Scheduler__ también recibe de __API Server__, los requisitos del nuevo objeto. 
Los requisitos pueden incluir las restricciones que establecen los usuarios y los operadores. 
El __Scheduler__ también tiene en cuenta los requisitos de calidad (QoS), la localización de los datos, la afinidad, la antiafinidad, tolerancia, etc

Es altamente configurable, si se añaden más __Schedulers__, es necesario incluir el nonmbre del __Scheduler__, sino lo gestionará el de por defecto.

Es bastante importante y complejo este componente.


### 4.6. Master Node Components: Controller Managers
Son componentes del plano de control, en el __Master Node__ que regulan el estado del cluster. 
Son bucles de vigilancia que se ejecutan continuamente y comparan el estado deseado del cluster (proporcionado por los nuevos objectos) con el estado actual (proporcionado de etcd a traves de __API Server)__.
En caso de desajuste, se toman medidas correctivas para coincidir con el estado deseado.

Los __Controller Managers__, son los encargados de actuar cuando los __Nodes__ no están disponibles, garantizar que el número de __Pods__ son el esperado, de crear __Endpoints__, __Service Accounts__, y __API access tokens__.
Es el encargado de interactuar con la infraestructura subyacente de un proveedor de nubes cuando los __Nodes__ no están disponibles, de gestionar volumenes de almacenamiento, equilibrar el balancedo de carga y el enrutamiento.


### 4.7. Master Node Components: etcd
Es un __almacenamiento de datos clave-valor distribuido__ que se utiliza para persistir el estado de cluster. 
Los nuevos datos se escriben en el almacen solo añadiendolos, los datos nunca son reemplazados. 
Los datos obsoletos se compactan periódicamente para minimizar el tamaño de __etcd__.

__Solo el API Server es capaz de comunicarse con etcd.__

La herramienta de gestión (CLI) de __etcd__ proporciona capacidades de copias de seguridad, snapshots, y restauración. 
__Para los entornos productivos, es importante replicarlos en HA.__

Algunas herramientas de arranque de clusters de k8s, por defecto, aprovisionan __Master Nodes__ de etcd aplilados, en los que __etcd__ se ejecuta junto a los demás componentes del __Master Node__ y comparte recursos con ellos. 
Puede aislarse el __etcd__ en un host separado, reduciendo así posibilidades de fallo. 
Tanto las configuraciónes en el mismo host o en otro, adminten configuración en HA.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.7_MasterandFollowers.png)

__etcd está escrito en Go__. 
Además de almacenar el estado del cluster, también se almacenan detalles de configuración como subredes, ConfigMaps, secrets, etc.


### 4.8. Worker Node
Un __Worder Node__, proporciona un entorno de ejecución para las aplicaciones clientes. 
Aunque son microservicios en contenedores, estas aplicaciones están encapsuladas en __Pods__, controladas por componentes del __Master Node__.
Los __Pods__ se programan en los __Worker Node__, donde se encuentran los recursos de computación, memoria, almacenamiento y la red para hablar entre ellos y el mundo exterior.
__Un Pod, es la unidad mínima de k8s.__ Es una colección lógica de uno o más contenedores juntos.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.8_KubernetesWorkerNode.png)

Además, para acceder a las aplicaciones del mundo exterior, nos conectamos a los __Worker Nodes__ y no al __Master Node__.


### 4.9. Worker Node Components
Un __Worker Node__, cuenta con los siguientes componentes:
* __Container Runtime__
* __kubelet__
* __kube-proxy__
* __Addons__ para DNS, Dashboards, monitorización y registros de logs.


### 4.10. Worker Node Components: Container Runtime
Aunque k8s es un motor de orquestación de contenedores, no tiene la capacidad de manejar directamente los contenedores. 
Para ejecutar y gestionar el ciclo de vida de un contenedor, se requiere de un __runtime__ en el __Node__ en el que se va a programar un __Pod__ y sus contendores. 
k8s soporta:
* __Docker__: utiliza como runtime, containerd, es el más utilizado con k8s.
* __CRI-O__: contenedor ligero para k8s, soporta registros de imagenes Docker.
* __containerd__: simple y portatil, proporciona robustez.
* __rkt__: motor nativo para pods, disponible para imagenes docker.
* __rktlet__:


### 4.11. Worker Node Components: kubelet
__kubelet__ es un agente que se ejecuta en cada __Node__ y se comunica con los componentes del plano de control del __Master Node__. 
Recibe las definiciones del __Pod__, principalmente del __API Server__, e interactúa con el __runtime__ del contenedor en el __Node__ para ejecutar los contenedores asociados al __Pod__. 
También supervisa la salud de los contenedores en ejecución del __Pod__.

__kubelet__ se conecta al __runtime__ del contenedor mediante la Interfaz de Tiempo de Ejecución del Contenedor __(CRI)__. 
CRI consiste en buffers de protocolo, gRPC API, y librerías.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.11_ContainerRuntimeInterface.png)

__kubelet__ que actúa como cliente grpc se conecta a la __CRI__, que actúa como servidor grpc para realizar operaciones de contenedor e imagen. 
__CRI__ implementa dos servicios: __ImageService__ y __RuntimeService__:

* __ImageService__ es responsable de todas las operaciones relacionadas con la imagen.
* __RuntimeService__ es responsable de todas las operaciones relacionadas con el __Pod__ y el contenedor.

Los __runtime__ de los contenedores solían estar codificados en duro en Kubernetes, pero con el desarrollo de CRI, Kubernetes es más flexible ahora y utiliza diferentes __runtimes__ de los contenedores sin necesidad de recompilar. 
Cualquier __runtime__ de contenedor que implemente la CRI puede ser usado por Kubernetes para gestionar __Pods__, contenedores e imágenes de contenedores.


### 4.12. Worker Node Components: kubelet - CRI shims
Ejemplos de IRC:

* __dockershim:__ los contenedores se crean usando Docker instalado en los nodos de los trabajadores. Internamente, Docker utiliza __containerd__ para crear y gestionar los contenedores.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.12_dockershim.png)

* __cri-containerd:__ podemos usar directamente el contenedor de la descendencia más pequeña de Docker para crear y gestionar los contenedores.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.12_cri-containerd.png)

* __CRI-O:__ permite utilizar cualquier runtime compatible con la Iniciativa de Contenedor Abierto __(OCI)__ con los Kubernetes.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.12_CRI-O.png)


### 4.13. Worker Node Components: kube-proxy
El __kube-proxy__ es el agente de red que se ejecuta en cada __Node__ responsable de las actualizaciones dinámicas y del mantenimiento de todas las reglas de red del __Node__. 
Absorbe los detalles de la red de __Pods__ y reenvía las solicitudes de conexión a __Pods__.


### 4.14. Worker Node Components: Addons
Los __addons__ son características y funcionalidades de los clústeres que aún no están disponibles en los Kubernetes, por lo que se implementan a través de __Pods__ y servicios de terceros.

* __DNS__ - el clúster DNS es un servidor DNS necesario para asignar los registros DNS a los objetos y recursos de Kubernetes.
* __Dashboard__ - una interfaz de usuario de propósito general basada en la web para la gestión de clústeres.
* __Monitoreo__ - recopila las métricas de los contenedores a nivel de clúster y las guarda en un almacén central de datos.
* __Registro__ - recoge los registros de los contenedores a nivel de grupo y los guarda en un almacén central de registros para su análisis.


### 4.15. Networking Challenges
Las aplicaciones basadas en microservicios desacoplados dependen en gran medida de la conexión en red para imitar el estrecho acoplamiento que una vez estuvo disponible en la era monolítica. 
La conexión en red, en general, no es la más fácil de entender e implementar. Kubernetes no es una excepción - como un orquestador de microservicios en contenedores es necesario abordar 4 desafíos de red distintos:

* Comunicación de contenedor a contenedor dentro de los __Pods__.
* La comunicación de __Pod a Pod__ en el mismo __Node__ y a través de otros __Nodes__ de otros clusters.
* La comunicación de __Pod a Servicio__ dentro del mismo __namespaces__ y a través de los __namespaces__ de los clústeres.
* Comunicación externa al servicio para que los clientes accedan a las aplicaciones de un cluster.

Todos estos desafíos de red deben ser abordados antes de desplegar un cluster de Kubernetes.


### 4.16. Container-to-Container Communication Inside Pods
Haciendo uso de las características del kernel del sistema operativo del host subyacente, el __runtime__ de un contenedor crea un espacio de red aislado para cada contenedor que inicia. 
En Linux, ese espacio de red aislado se denomina __network namespace__. 
Un __network namespaces__ se comparte entre contenedores, o con el sistema operativo del host.
Cuando se inicia un __Pod__, se crea un __network namespace__ dentro del __Pod__, y todos los contenedores que se ejecutan dentro del __Pod__ compartirán ese __network namespace__ para que puedan hablar entre ellos a través del localhost.


### 4.17. Pod-to-Pod Communication Across Nodes
En un grupo de Kubernetes los __Pods__ están programados en __Nodes__ al azar. 
Independientemente de su __Node__ anfitrión, se espera que los __Pods__ puedan comunicarse con todos los demás __Pods__ del cluster, todo esto sin la implementación de la Traducción de Direcciones de Red (NAT). 
Este es un requisito fundamental de cualquier implementación de red en los kubernetes.

El modelo de red de los Kubernetes tiene como objetivo reducir la complejidad, y trata a los __Pods__ como máquinas virtuales en una red, en la que cada máquina virtual recibe una dirección IP, por lo que cada __Pod__ recibe una dirección IP. 
Este modelo se denomina __"IP por PC"__ y garantiza la comunicación entre los __Pods__, al igual que las máquinas virtuales pueden comunicarse entre sí.

Sin embargo, no nos olvidemos de los contenedores. Comparten el espacio de nombres de la red del __Pod__ y deben coordinar la asignación de puertos dentro del __Pod__ como lo harían las aplicaciones en una VM, todo ello mientras pueden comunicarse entre sí en el host local - dentro del __Pod__. 
Sin embargo, los contenedores se integran con el modelo general de red de Kubernetes mediante el uso de la Interfaz de Red de Contenedores __(CNI)__ soportada por los plugins CNI. 
La __CNI__ es un conjunto de especificaciones y librerías que permiten a los plugins configurar la red de contenedores. 
Aunque hay unos pocos plugins de kernel, la mayoría de los plugins CNI son soluciones de red definidas por software (SDN) de terceros que implementan el modelo de red de Kubernetes. 
Además de abordar el requisito fundamental del modelo de red, algunas soluciones de red ofrecen soporte para las políticas de red. 
__Flannel__, Weave, __Calico__ son sólo algunas de las soluciones SDN disponibles para los clusters de Kubernetes.

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/4.17_ContainerNetworkInterface.png)

El __runtime__ del contenedor descarga la asignación de IP a CNI, que se conecta al plugin configurado subyacente, como Bridge o MACvlan, para obtener la dirección IP. Una vez que la dirección IP es dada por el plugin respectivo, CNI la reenvía al tiempo de ejecución del contenedor solicitado.


### 4.18. Pod-to-External World Communication
Para que una aplicación en contenedor que se ejecuta en __Pods__ dentro de un clúster de Kubernetes se pueda desplegar con éxito, se requiere accesibilidad desde el mundo exterior. 
Kubernetes permite la accesibilidad externa a través de __services__, construcciones complejas que encapsulan definiciones de reglas de red en __Nodes__ de clúster. 
Al exponer los __services__ al mundo externo con __kube-proxy__, las aplicaciones se hacen accesibles desde fuera del cluster a través de una IP virtual.


DUDAS:
* Plano de control, que es exactamente?
* etcd y hosts externos

## Chapter 5. Installing Kubernetes<a name="chapter5"></a>
## 5. Installing Kubernetes
## 5.1. Kubernetes Configuration
Los kubernetes pueden ser instalados usando diferentes configuraciones. 
A continuación se presentan brevemente los cuatro tipos principales de instalación:

* __Instalación de un Single-Node todo en uno:__
En esta configuración, todos los componentes maestros y trabajadores están instalados y funcionando en un solo __Node__. 
Aunque es útil para el aprendizaje, desarrollo y pruebas, no debe utilizarse en la producción. 
__Minikube__ es un ejemplo de ello.

* __Instalación de un Single-Node, etc., de un solo Master Node y de varios Worker Node:__
En esta configuración, tenemos un __Master Node__ único, que también ejecuta una instancia de un solo __Node etcd__. 
Múltiples __Workers Nodes__ están conectados al __Master Node__.

* __Instalación de un Single-Node etcd, multi-Master y multi-Worker:__
En esta configuración, tenemos __Multi-Master Nodes__ configurados en modo HA, pero tenemos una instancia de un solo __Node etcd__. __Multi-Worker Nodes__ están conectados a los __Master Nodes__.

* __Instalación de Multi-Node etcd, Multi-Master y Multi-Worker:__
En este modo, __etcd__ está configurado en modo HA agrupado, los __Master Nodes__ están todos configurados en modo HA, conectando a __Multi-Worker Nodes__. 

> __Esta es la configuración de producción más avanzada y recomendada.__


## 5.2. Infrastructure for Kubernetes Installation
Una vez que decidimos el tipo de instalación, también tenemos que tomar algunas decisiones relacionadas con la infraestructura:

* ¿Debemos establecer los k8s en metal desnudo, nube pública o nube privada?
* ¿Qué sistema operativo subyacente deberíamos utilizar? ¿Deberíamos elegir RHEL, CoreOS, CentOS, u otra cosa?
* ¿Qué solución de red deberíamos utilizar?
* Y así sucesivamente.


## 5.3. Localhost Installation
Estas son sólo algunas de las opciones de instalación del host local disponibles para desplegar clusters de Kubernetes de uno o varios __Nodes__ en nuestra estación de trabajo/portátil:

* __Minikube__ - cluster de Kubernetes locales de un __Single-Node__.
* __Docker Desktop__ - __Single-Node__ de cluster local de Kubernetes para Windows y Mac.
* __CDK en LXD__ - cluster local __Multi-Node__ con contenedores de LXD.

> Minikube es la forma preferida y recomendada para crear una configuración de Kubernetes todo en uno localmente.


## 5.4. On-Premise Installation
Los kubernetes pueden instalarse en las máquinas virtuales y en el metal desnudo.

* __VMs en las instalaciones:__
Los kubernetes pueden instalarse en las máquinas virtuales creadas a través de Vagrant, VMware vSphere, KVM u otra herramienta de gestión de la configuración (CM) junto con un software de hipervisor. Hay diferentes herramientas disponibles para automatizar la instalación, como __Ansible__ o __kubeadm__.
* __Bare Metal en las instalaciones:__
Los kubernetes pueden ser instalados en bare-metal, en RHEL, CoreOS, CentOS, Fedora, Ubuntu, etc.


## 5.5. Cloud Installation
kubernetes pueden ser instalados y administrados en casi cualquier entorno de nube:

* __Soluciones alojadas:__
Algunos de los proveedores que ofrecen soluciones alojadas para Kubernetes son:
    * Motor de Kubernetes de Google (GKE).
    * Servicio de Kubernetes Azules (AKS).
    * Servicio de Contenedores Elásticos del Amazonas para Kubernetes (EKS).
    * DigitalOcean Kubernetes.
    * OpenShift Dedicado.
    * Plataforma9.
    * IBM Cloud Kubernetes Service.

* __Soluciones Turnkey:__
Kubernetes gestionado, como por ejemplo:
    * Motor de Computación de Google (GCE).
    * Amazon AWS (AWS EC2).
    * Microsoft Azure (AKS).

* __Soluciones "llave en mano" en las instalaciones:__
Las Soluciones On-Premise instalan Kubernetes en nubes privadas internas seguras con sólo unos pocos comandos:
    * GKE On-Prem de Google Cloud.
    * IBM Cloud Private.
    * OpenShift Container Platform de Red Hat.


## 5.6. Kubernetes Installation Tools/Resources 
Algunas herramientas/recursos útiles disponibles:

* __kubeadm:__
Es una forma segura y recomendada de arrancar un cluster de Kubernetes de __Single-Node__ o __Multi-Node__.

* __kubespray:__
(antes conocido como __kargo__), podemos instalar clusters de Kubernetes en HA en AWS, GCE, Azure, OpenStack, o bare-metal. Está basado en __Ansible__, y está disponible en la mayoría de las distribuciones de Linux.

* __kops:__
Podemos crear, destruir, actualizar y mantener clusters de Kubernetes de producción y HA desde la línea de mando. También puede aprovisionar las máquinas. Actualmente, AWS está oficialmente respaldada. La compatibilidad con GCE está en fase beta, y VMware vSphere en fase alfa, y otras plataformas están previstas para el futuro.

* __kube-aws:__
Podemos crear, actualizar y destruir clusters de Kubernetes en AWS desde la línea de comandos. 



## Chapter 6. Minikube - A Local Single-Node Kubernetes Cluster<a name="chapter6"></a>
## 6. Minikube - A Local Single-Node Kubernetes Cluster
## 6.1. Requirements for Running Minikube
__Minikube__ está disponible para Linux, MacOS o Windows. Sin embargo, para aprovechar al máximo todas las características que ofrece Minikube, se debe instalar un Hipervisor de Tipo 2 en tu equipo local, para que funcione en conjunto con Minikube. 

__Minikube__ construye toda su infraestructura siempre y cuando el Hipervisor de Tipo 2 esté instalado en nuestra estación de trabajo. Minikube invoca el Hipervisor para crear una sola VM que luego alberga un clúster de Kubernetes de un solo nodo. Por lo tanto, necesitamos asegurarnos de que tenemos el hardware y el software necesario requerido por Minikube para construir su entorno. A continuación se describen los requisitos para ejecutar Minikube en nuestra estación de trabajo local:

* __kubectl:__
__kubectl__ es un binario utilizado para acceder y gestionar cualquier grupo de Kubernetes. Se instala por separado de Minikube.

* __Hipervisor de tipo 2:__
    * En Linux VirtualBox o KVM
    * En macOS VirtualBox, HyperKit o VMware Fusion
    * En Windows VirtualBox o Hyper-V

> NOTA: Minikube soporta una opción __--vm-driver=none__ que ejecuta los componentes de Kubernetes directamente en el sistema operativo del host y no dentro de una VM. Con esta opción se requiere una instalación __Docker__ y un sistema operativo Linux en la estación de trabajo local, pero no una instalación de hipervisor. Si utiliza __--vm-driver=none__, asegúrese de especificar una red de puente para Docker. De lo contrario, podría cambiar entre los reinicios de la red, causando la pérdida de conectividad a su clúster.

* La virtualización de VT-x/AMD-v debe estar habilitada en la estación de trabajo local en el BIOS.

* Conexión a Internet en la primera ejecución de Minikube - para descargar paquetes, dependencias, actualizaciones y sacar las imágenes necesarias para iniciar el cluster de Minikube Kubernetes. Las ejecuciones subsiguientes requerirán una conexión a Internet sólo cuando las nuevas imágenes Docker necesiten ser extraídas de un repositorio de contenedores o cuando las aplicaciones desplegadas en contenedores lo necesiten. Una vez que una imagen ha sido extraída puede ser reutilizada sin una conexión a Internet.



## Chapter 7. Accessing Minikube<a name="chapter7"></a>
## 7. Accessing Minikube
## 7.1. Accessing Minikube
Se puede acceder a cualquier grupo de Kubernetes que funcione bien a través de cualquiera de los siguientes métodos:

* Herramientas y scripts de la Interfaz de Línea de Comando (CLI).
* Interfaz de usuario basada en la web (Web UI) desde un navegador web.
* APIs de CLI o programáticamente.

Estos métodos son aplicables a todos los grupos de Kubernetes. 


## 7.2. Accessing Minikube: Command Line Interface (CLI)
__kubectl__ es el cliente de la Interfaz de Línea de Comando (CLI) de Kubernetes para gestionar los recursos y aplicaciones del cluster. Puede utilizarse de forma autónoma o como parte de scripts y herramientas de automatización. Una vez que se han configurado todas las credenciales y puntos de acceso al clúster necesarios para kubectl, se puede utilizar de forma remota desde cualquier lugar para acceder a un clúster. 

En capítulos posteriores, utilizaremos kubectl para desplegar aplicaciones, gestionar y configurar los recursos de Kubernetes.


## 7.3. Accessing Minikube: Web-based User Interface (Web UI)
El Dashboard de Kubernetes proporciona una Interfaz de Usuario basada en la Web (Web UI) para interactuar con un grupo de Kubernetes para gestionar recursos y aplicaciones en contenedores. En uno de los últimos capítulos, la utilizaremos para desplegar una aplicación en contenedor.


## 7.4. Accessing Minikube: APIs
Como sabemos, Kubernetes tiene el servidor API, y los operadores/usuarios se conectan a él desde el mundo externo para interactuar con el cluster. Usando tanto la CLI como la Web UI, podemos conectarnos al servidor API que se ejecuta en el nodo maestro para realizar diferentes operaciones. Podemos conectarnos directamente al servidor de la API utilizando sus puntos finales de la API y enviarle comandos, siempre y cuando podamos acceder al nodo maestro y tengamos las credenciales adecuadas.

A continuación, podemos ver una parte del espacio de la API HTTP de Kubernetes:

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/7.3_HTTPAPISpaceofKubernetes.png)

El espacio de la API HTTP de los gobernantes se puede dividir en tres grupos independientes:

* Grupo central (/api/v1)
Este grupo incluye objetos como Pods, Servicios, nodos, espacios de nombres, configmaps, secretos, etc.

* Grupo de nombres
Este grupo incluye objetos en formato /apis/$NAME/$VERSION. Estas diferentes versiones de la API implican diferentes niveles de estabilidad y soporte:
Nivel Alfa - puede ser eliminado en cualquier momento, sin previo aviso. Por ejemplo, /apis/batch/v2alpha1.
Nivel Beta - está bien probado, pero la semántica de los objetos puede cambiar de forma incompatible en una posterior versión beta o estable. Por ejemplo, /apis/certificados.k8s.io/v1beta1.
Nivel estable - aparece en el software publicado para muchas versiones posteriores. Por ejemplo, /apis/networking.k8s.io/v1.

* A nivel de todo el sistema
Este grupo consiste en puntos finales de la API de todo el sistema, como /healthz, /logs, /metrics, /ui, etc.
Podemos conectarnos a un servidor de la API directamente llamando a los respectivos puntos finales de la API o a través del CLI/Web UI.

A continuación veremos cómo podemos acceder al entorno de Minikube que hemos configurado en el capítulo anterior.


## 7.5. kubectl
__kubectl__ se instala generalmente antes de instalar el Minikube, pero también podemos instalarlo después. Una vez instalado, kubectl recibe su configuración automáticamente para el acceso al cluster de Kubernetes de Minikube. Sin embargo, en otras configuraciones de clúster de Kubernetes, es posible que necesitemos configurar los puntos de acceso al clúster y los certificados requeridos por kubectl para acceder al clúster.

Existen diferentes métodos que pueden utilizarse para instalar kubectl, que se mencionan en la documentación de Kubernetes. Para obtener los mejores resultados, se recomienda mantener kubectl en la misma versión que los Kubernetes dirigidos por Minikube - en el momento en que se escribió el curso la última versión estable era la v1.14.1. A continuación, veremos algunos pasos para instalarlo en sistemas Linux, MacOS y Windows.

## 7.6. Installing kubectl on Linux
Para instalar kubectl en Linux, siga las siguientes instrucciones:

Descargue el último binario estable de kubectl, hágalo ejecutable y muévalo al PATH:

> $ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

NOTA: Para descargar y configurar una versión específica de kubectl (como la v1.14.1), emita el siguiente comando:

> $ curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.1/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/


## 7.7. Installing kubectl on macOS
Hay dos maneras de instalar kubectl en macOS: manualmente y usando el administrador de paquetes de Homebrew. A continuación, daremos instrucciones para ambos métodos.

Para instalar kubectl manualmente, descargue el último binario estable de kubectl, hágalo ejecutable y muévalo al PATH con el siguiente comando:

> $ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

NOTA: Para descargar y configurar una versión específica de kubectl (como la v1.14.1), emita el siguiente comando:

> $ curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.1/bin/darwin/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

Para instalar kubectl con el administrador de paquetes de Homebrew, emita el siguiente comando:

$ brew install kubernetes-cli


## 7.8. kubectl Configuration File
Para acceder al clúster de Kubernetes, el cliente de kubectl necesita el punto final del nodo maestro y las credenciales adecuadas para poder interactuar con el servidor de la API que se ejecuta en el nodo maestro. Al iniciar Minikube, el proceso de inicio crea, por defecto, un archivo de configuración, config, dentro del directorio.kube (a menudo denominado archivo dot-kube-config), que reside en el directorio principal del usuario. El archivo de configuración tiene todos los detalles de conexión requeridos por kubectl. Por defecto, el binario de kubectl analiza este archivo para encontrar el punto final de conexión del nodo maestro, junto con las credenciales. Para ver los detalles de conexión, podemos ver el contenido del archivo ~/.kube/config (en Linux) o ejecutar el siguiente comando:

```yaml
$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/student/.minikube/ca.crt
    server: https://192.168.99.100:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /home/student/.minikube/client.crt
    client-key: /home/student/.minikube/client.key
``` 


Una vez instalado kubectl, podemos obtener información sobre el clúster de Minikube con el comando kubectl cluster-info: 

```
$ kubectl cluster-info
Kubernetes master is running at https://192.168.99.100:8443
KubeDNS is running at https://192.168.99.100:8443//api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
``` 

Para seguir depurando y diagnosticando los problemas de los racimos, usa el 'kubectl cluster-info dump'.

Puedes encontrar más detalles sobre las opciones de la línea de comandos de kubectl aquí.

Aunque para el clúster de Kubernetes instalado por Minikube el archivo ~/.kube/config se crea automáticamente, este no es el caso de los clústeres de Kubernetes instalados por otras herramientas. En otros casos, el archivo de configuración tiene que ser creado manualmente y a veces reconfigurado para adaptarse a varias configuraciones de red y de cliente/servidor.


## 7.9. Kubernetes Dashboard
Como se ha mencionado anteriormente, el Tablero de Kubernetes proporciona una interfaz de usuario basada en la web para la gestión del clúster de Kubernetes. Para acceder al Dashboard desde Minikube, podemos utilizar el comando minikube dashboard, que abre una nueva pestaña en nuestro navegador web, mostrando el Dashboard de los Kubernetes:

``` 
$ minikube dashboard
``` 

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/7.9_KubernetesDashboard.png)

NOTA: En caso de que el navegador no abra otra pestaña y no muestre el Tablero de Control como se esperaba, verifique la salida en su terminal ya que puede mostrar un enlace para el Tablero de Control (junto con algunos mensajes de error). Copie y pegue ese enlace en una nueva pestaña de su navegador. Dependiendo de las características de su terminal, es posible que sólo tenga que hacer clic o hacer clic con el botón derecho del ratón en el enlace para abrirlo directamente en el navegador. El enlace puede tener un aspecto similar:

```
http://127.0.0.1:37751/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/
```

Lo más probable es que la única diferencia sea el número del PUERTO, que arriba es 37751. Su número de puerto puede ser diferente.

Después de un cierre de sesión/login o un reinicio de su estación de trabajo, el comportamiento normal debe ser esperado (donde el comando minikube dashboard abre directamente una nueva pestaña en su navegador mostrando el Dashboard).


## 7.10. The 'kubectl proxy' Command
Al emitir el comando proxy kubectl, kubectl se autentica con el servidor API en el nodo maestro y hace que el Dashboard esté disponible en una URL ligeramente diferente a la anterior, esta vez a través del puerto proxy 8001.

Primero, emitimos el comando kubectl proxy:

```
$ kubectl proxy
Starting to serve on 127.0.0.1:8001
```

Bloquea la terminal mientras el proxy esté funcionando. Con el proxy ejecutándose podemos acceder al Dashboard a través de la nueva URL (sólo tienes que hacer clic en ella abajo - debería funcionar en tu estación de trabajo). Una vez que detenemos el proxy (con CTRL + C) el Dashboard ya no es accesible.

```
http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard:/proxy/#!/overview?namespace=default 
```

![alt text](https://github.com/amartingarcia/k8s_training/blob/master/images/7.10_KubernetesDashboardovertheproxy.png)


## 7.11. APIs - with 'kubectl proxy'
Cuando se ejecuta el proxy de kubectl, podemos enviar solicitudes a la API a través del localhost en el puerto proxy 8001 (desde otra terminal, ya que el proxy bloquea la primera terminal):

```json
$ curl http://localhost:8001/
{
 "paths": [
   "/api",
   "/api/v1",
   "/apis",
   "/apis/apps",
   ......
   ......
   "/logs",
   "/metrics",
   "/openapi/v2",
   "/version"
 ]
}
```

Con la solicitud de rizo anterior, solicitamos todos los puntos finales de la API al servidor de la API. Al hacer clic en el enlace anterior (en el comando curl), se abrirá la misma salida de listado en una pestaña del navegador.

Podemos explorar todas las combinaciones de rutas con curl o en un navegador, por ejemplo:

```
http://localhost:8001/api/v1

http://localhost:8001/apis/apps/v1

http://localhost:8001/healthz

http://localhost:8001/metrics
```

## 7.12. APIs - without 'kubectl proxy'
Cuando no se utiliza el proxy kubectl, es necesario autenticarse en el servidor de la API cuando se envían las solicitudes de la API. Podemos autenticarnos proporcionando un token portador al emitir un rizo, o proporcionando un conjunto de claves y certificados.

Un token portador es un token de acceso que es generado por el servidor de autenticación (el servidor de la API en el nodo maestro) y devuelto al cliente. Utilizando ese token, el cliente puede conectarse de nuevo al servidor de la API de Kubernetes sin necesidad de proporcionar más detalles de autenticación y, a continuación, acceder a los recursos.

Consigue el token:

```
$ TOKEN=$(kubectl describe secret -n kube-system $(kubectl get secrets -n kube-system | grep default | cut -f1 -d ' ') | grep -E '^token' | cut -f2 -d':' | tr -d '\t' | tr -d " ")
```
Get the API server endpoint:

```
$ APISERVER=$(kubectl config view | grep https | cut -f 2- -d ":" | tr -d " ")
```

Confirm that the APISERVER stored the same IP as the Kubernetes master IP by issuing the following 2 commands and comparing their outputs:

```
$ echo $APISERVER
https://192.168.99.100:8443

$ kubectl cluster-info
Kubernetes master is running at https://192.168.99.100:8443 ...
```

Access the API server using the curl command, as shown below:

```json
$ curl $APISERVER --header "Authorization: Bearer $TOKEN" --insecure
{
 "paths": [
   "/api",
   "/api/v1",
   "/apis",
   "/apis/apps",
   ......
   ......
   "/logs",
   "/metrics",
   "/openapi/v2",
   "/version"
 ]
}
```

En lugar del token de acceso, podemos extraer el certificado de cliente, la clave de cliente y los datos de la autoridad de certificación del archivo .kube/config. Una vez extraídos, se codifican y luego se pasan con un comando curl para la autenticación. El nuevo comando curl es similar a:

```
$ curl $APISERVER --cert encoded-cert --key encoded-key --cacert encoded-ca
```



## Chapter 8. Kubernetes Building Blocks<a name="chapter8"></a>
## 8. Kubernetes Building Blocks
## 8.1. Kubernetes Object Model
## 8.2. Pods
## 8.3. Labels
## 8.4. Label Selectors
## 8.5. ReplicationControllers
## 8.6. ReplicaSets I
## 8.7. ReplicaSets II
## 8.8. ReplicaSets III
## 8.9. Deployments I
## 8.10. Deployments II
## 8.11. Deployments III
## 8.12. Namespaces 



## Chapter 9. Authentication, Authorization, Admission Control<a name="chapter9"></a>
## 9. Authentication, Authorization, Admission Control
## 9.1. Authentication, Authorization, and Admission Control - Overview
## 9.2. Authentication I
## 9.3. Authentication II
## 9.4. Authorization I
## 9.5. Authorization II
## 9.6. Authorization III
## 9.7.Admission Control
## 9.8. Authentication and Authorization Exercise Guide

## Chapter 10. Services<a name="chapter10"></a>
## 10. Services
## 10.1. Connecting Users to Pods
## 10.2. Services
## 10.3. Service Object Example
## 10.4. kube-proxy
## 10.5. Service Discovery
## 10.6. ServiceType
## 10.7. ServiceType: ClusterIP and NodePort
## 10.8. ServiceType: LoadBalancer
## 10.9. ServiceType: ExternalIP
## 10.10. ServiceType: ExternalName

## Chapter 11. Deploying a Stand-Alone Application<a name="chapter11"></a>
## 11. Deploying a Stand-Alone Application
## 11.1. Deploying an Application Using the Dashboard I
## 11.2. Deploying an Application Using the Dashboard II
## 11.3. Deploying an Application Using the Dashboard III
## 11.4. Exploring Labels and Selectors I
## 11.5. Exploring Labels and Selectors II
## 11.6. Exploring Labels and Selectors III
## 11.7. Deploying an Application Using the CLI I
## 11.8. Deploying an Application Using the CLI II
## 11.9. Exposing an Application I
## 11.10. Exposing an Application II
## 11.11. Accessing an Application
## 11.12. Liveness and Readiness Probes
## 11.13. Liveness
## 11.14. Liveness Command
## 11.15. Liveness HTTP Request
## 11.16. TCP Liveness Probe
## 11.17. Readiness Probes


## Chapter 12. Kubernetes Volume Management<a name="chapter12"></a>
## 12. Kubernetes Volume Management
## 12.1. Volumes
## 12.2. Volume Types
## 12.3. PersistentVolumes
## 12.4. PersistentVolumeClaims
## 12.5. Container Storage Interface (CSI)

## Chapter 13. ConfigMaps and Secrets<a name="chapter13"></a>
## 13. ConfigMaps and Secrets
## 13.1. ConfigMaps
## 13.2. Create a ConfigMap from Literal Values and Display Its Details
## 13.3. Create a ConfigMap from a Configuration File
## 13.4. Create a ConfigMap from a File
## 13.5. Use ConfigMaps Inside Pods
## 13.6. Secrets
## 13.7. Create a Secret from Literal and Display Its Details
## 13.8. Create a Secret Manually
## 13.9. Create a Secret from a File and Display Its Details
## 13.10. Use Secrets Inside Pods


## Chapter 14. Ingress<a name="chapter14"></a>
## 14. Ingress
## 14.1. Ingress I
## 14.2. Ingress II
## 14.3. Ingress Controller
## 14.4. Deploy an Ingress Resource
## 14.5. Access Services Using Ingress


## Chapter 15. Advanced Topics<a name="chapter15"></a>
## 15. Advanced Topics
## 15.1. Annotations
## 15.2. Jobs and CronJobs
## 15.3. Quota Management
## 15.4. Autoscaling
## 15.5. DaemonSets
## 15.6. StatefulSets
## 15.7. Kubernetes Federation
## 15.8. Custom Resources
## 15.9. Helm
## 15.10. Security Contexts and Pod Security Policies
## 15.11. Network Policies
## 15.12. Monitoring and Logging

## Chapter 16. Kubernetes Community<a name="chapter16"></a>
## 16. Kubernetes Community
## 16.1. Kubernetes Community
## 16.2. Weekly Meetings and Meetup Groups
## 16.3. Slack Channels and Mailing Lists
## 16.4. SIGs and Stack Overflow
## 16.5. CNCF Events
## 16.6. What's Next on Your Kubernetes Journey?