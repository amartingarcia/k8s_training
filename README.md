# k8s_training

k8s
-------------

Chapter 1. From Monolith to Microservices.

1. From Monolith to Microservices
1.1. The legacy Monolith
This boulder represents the monolith application - sedimented layers of features and redundant logic translated into thousands of lines of code, written in a single, not so modern programming language, based on outdated software architecture patterns and principles.

The new features and improvements added to code complexity, making development more challenging - loading, compiling, and building times increase with every new update. 

Being a large, single piece of software which continuously grows, it has to run on a single system which has to satisfy its compute, memory, storage, and networking requirements. The hardware of such capacity is both complex and pricey.

Since the entire monolith application runs as a single process, the scaling of individual features of the monolith is almost impossible. It internally supports a hardcoded number of connections and operations. However, scaling the entire application means to manually deploy a new instance of the monolith on another server, typically behind a load balancing appliance - another pricey solution.

During upgrades, patches or migrations of the monolith application - downtimes occur and maintenance windows have to be planned as disruptions in service are expected to impact clients. While there are solutions to minimize downtimes to customers by setting up monolith applications in a highly available active/passive configuration, it may still be challenging for system engineers to keep all systems at the same patch level.


1.2. The Modern Microservice.
Similitudes:
- Monolito       --> Gran roca
- Microservicios --> Guijarros

Los guijarros representan la totalidad de la roca individualmente. También son faciles de seleccionar y agrupar en base al color, tamaño y forma.
Los microservicios pueden ser desplegados individualmente en servidores separados provistos con los recuros necesarios para cada servicio.
La arquitectura basada en microservicios está alineada con la Arquitectura Dirigida por Eventos y Arquitectura Orientada a Servicios, donde las aplicaciones complejas están compuestas por pqeueños procesos que se comunican entre si por medio de APIs.
Los microservicios se desarrollan en un lenguaje moderno y el más adecuado para cada servicio. Permite elegir hardware para cada servicio.
La naturaleza distribuida de los servicios añade complejidad a la arquitectura, pero añade beneficios en cuanto a la escalabilidad. Permite no tener inactividad.


1.3. Refactoring
Una aplicación multiproceso (monolito), no puede funcionar como un microservicio. Por lo tanto, se necesita refactorizar (Big-Bang ó refactorización incremental):
* Big-bang:                    Bloquea el desarrollo y nuevas características para centrarse en la refactorización
* Refactorización incremental: Permite que se desarrollen nuevas características y se apliquen como microservicios modernos que puedan comunicarse con la API. 
                               Mientras tantos las características actuales del monolito se refactorizaran, y este irá desvaneciendo lentamente.


1.4. Challenges
Para algunas aplicaciones, puede ser más económico reconstruirlas que refactorizarlas.
Las aplicaciones estrechamente unidas a almacenes de datos, son candidatas pobres a la refactorización.

Una vez que el monolito ha sobrevivido a la refactorización, el siguiente reto es diseñar mecanismos o encontrar herramientas adecuadas para mantener vivos todos los módulos desacoplados.
Si se despliegan muchos módulos en un solo servidor, lo más probable es que las diferentes librerias y el entorno de tiempo de ejecución, puedan entrar en conflicto. 
Esto obliga a separar modulos por servidor, y no es una forma económica de gestión de recursos. 
Entonces aparecieron los contenedores, que proporcionan entornos encapsulados. 
El amplio soporte de los contenedores aseguró la portabilidad  de las aplicaciones del metal a las máquinas virtuales, pero esta vez con múltiples aplicaciones desplegadas en el mismo servidor.







Chapter 2. Container Orchestration
2. Container Orchestration
2.1. What Are Containers?
* Contenedores: Son aplicaciones que ofrecen alto rendimiento y escalabilidad. Son los más adecuados para ofrecer microservicios, ya que proporcionan entornos virtuales portatiles y aislados.
!image 2.1.png

* Microservicios: Son aplicaciones ligeras escritas en varios lenguajes modernos, con dependencias, librerias y requisitos ambientales especificos. 

# Los contenedores encapsulan los microservicios y sus dependencias pero no los ejecutan directamente. Los contenedores ejecutan imágenes de contenedores.

* Imagen de contenedor: Agrupa la aplicación junto con su tiempo de ejecución y sus dependencias, ofreciendo un entorno ejecutable aislado.


2.2. What Is Container Orchestration?
En los entornos de desarrollo la ejecución de contenedores en un solo host, puede ser una opción. Sin embargo, para entornos productivos ya no es una opción viable, ya que debe cumplir una seria de requisitos:
* Tolerancia a fallos
* Escalabildiad a petición
* Uso óptimo de los recursos.
* Autodescubrimiento para la comunicación entre si.
* Accesibilidad desde el exterior
* Actualizaciones y rollbacks sin downtime.

Los orquestadores de contenedores es una herramienta que permite automatizar los despliegues y la gestión de contenedores, al mismo tiempo que cumple con los requisitos anteriores. 


2.3. Container Orchestrators
Algunos orquestadores:
* AWS ECS
* Azure Container Instances
* Nomad
* Kubernetes
* Docker Swarm


2.4. Why Use Container Orchestrators?
Aunque podemos mantener manualmente un par de contenedores, los orquestadores facilitan mucho las tareas.

La mayoría de contenedores puede:
* Agrupar host mientras se crear un cluster
* Programar contenedores para que corran en cluster en funcion de la disponibilidad de los recursos.
* Permite que los contenedores de cluster se comuniquen entre si.
* Gestionar y optimizar el uso de recursos
* Permitir una implementación de políticas para el acceso seguro a las aplicaciones que corren en los contenedores.

2.5. Where to Deploy Container Orchestrators?
Los orquestadores pueden ser desplegados en bare metal, máquinas virtuales, on-premise, o nube pública.




Chapter 3. Kubernetes
3. Kubernetes
3.1. What Is Kubernetes?
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

3.3. Kubernetes Features I
Kubernetes ofrece un conjunto de características para la orquestación:
* Automatic bin packing: programan en base a los recuros necesarios y limitaciones, para maximizar su utilización sin sacrificar la disponibilidad.
* Self-healing: Reemplaza y reprograma automáticamente los contenedores de los donos que fallan. Mata y reinicia los contenedores que no responden a los HealthCheck. También, enviata que se dirija el tráfico a contenedores que no responden.
* Horizontal scaling: se escalan manual o automáticamente las aplicaciones, en base a métricas.
* Service discovery and Load Balancing: Los contenedores reciben sus propias direcciones IPs, mientras que se asigna un único DNS a un conjunto de contenedores para ayudar al balanceo de carga.

3.4. Kubernetes Features II

* Automated rollouts and rollbacks: Despliegan y retroceden sin problema las actualizaciones de la aplicación y los cambios de configuración, supervisando constantemente la salud de la aplicación, evitando así inactividad.
* Secret and configuration management: Gestiona los secretos y detalles de la configuración de una aplicación por separado de la imagen del contenedor, con el fin de evitar la reconsctrucción de la imagen respectiva. Los secretos consisten en información confidencial que se le pasa a la aplicación sin revelar el contenido, como en GitHub.
* Storage orchestration: montan automáticamente soluciones de almacenamiento definidas por software en contenedores de almacenamiento local, proveedores de nube externos o sistemas de almacenamiento en red.

* Batch execution: apoya la ejecución por lotes, los trabajos de larga duración y reemplaza los contenedores que fallan.

Muchas otras características están por llegar aunque se encuentran en base beta. Otras, ya están estabales y aportan grandes beneficios como el control de acceso basado en roles (RBAC), estable desde la 1.8


3.5. Why Use Kubernetes?
K8s es portatil y extensible. La arquitectura de k8s es modular y enchufable. No solo orquesta aplicaciones de tipo microservicio desacoplado, si no que su arquitectura sigue patrones de los microservicios desacoplados. Pueden escribirse recursos personalizados, operadores APIs, reglas de programación o plugins.


3.6. Kubernetes Users
Algunos usuarios que utilizan k8s:
* BlaBlaCar
* eBay
* IBM
* Huawei
* ING


3.7. Cloud Native Computing Foundation (CNCF)
Es uno de los proyectos alojados por Linux-Foundation. Tiene como objetivo acelarar la adopción de contenedores, microservicios y aplicaciones nativas de la nube.
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


3.8. CNCF and Kubernetes
Para k8s, CNCF:
* Hogar neutral para la marca registrada, hace cumplir el uso adecuado.
* Proporciona una licencia para escanear el código del nucleo y del proveedor.
* Ofrece oritentación jurídica sobre cuestiones de patentes y derechos de autor.
* Crea un plan de estudios de aprendizaje de código abierto, formación y certificación tanto para los administradores como para los desarrolladores de k8s.
* Gestiona un gruop de trabajo de conformidad con el software.
* Comercializa activamente Kubernetes.








Chapter 4. Kubernetes Architecture
4. Kubernetes Architecture
4.1. Kubernetes Architecture
A un nivel muy alto, kubernetes cuenta con los siguientes componnentes principales:
!4.1.png
* Uno o más nodos maestros
* Uno o más nodos trabajadores
* Base de datos distribuidad, clave-valor, __etcd__

4.2. Master Node
El nodo maestro, proporciona un entorno de ejecución, es el reponsable  de gestionar el estado del cluster de k8s, y es el cerebro detrás de todas las operaciones del cluster.
Para comunicarse con el cluster, los usuarios envian solicitudes al nodo maestro a través de la CLI, un panel de control de interfaz de usuario o una interfaz gráfica de programación(API).

!4.2.png

Es importante mantener el plano de control. Perder el plano de control puede introducir tiempos de inactividad, causando la interrumpción del servicio a los clientes. Para asegurar tolerancia a fallos, se añaden réplicas del nodo maestro al cluster, configurado en modo HA.
Mientras que solo uno de los nodos de réplica, administra activamente el cluster, el resto de componentes permanencen sincronizados con el resto de réplicas master. 

Para mantener el estado del cluster de k8s, todos los datos de la configuración del cluster se guardan en __etcd__. Sin embargo, etcd es un almacenamiento clave-valor distribuido que solo guarda datos relacionados con el estado del cluster. Está configurado en el nodmo maestro y en su host dedicado, para recudir las posibilidades de pérdidas.

4.3. Master Node Components
Un nodo maestro tiene los siguientes componentes:
* API Server
* Scheduler
* Controller managers
* etcd


4.4. Master Node Components: API Server
Todas las tareas administrativas, están coordinadas por kube-apiserver. El API Server, intercepta las llamadas RESTfull de los usuarios, operadores y agentes externos, las valida y las procesa. Durante el procesamiento, API Server, lee  el estado del cluster desde etcd, y despues de la llamada, el estado resultante del cluster de k8s se guarda en etcd.
API Server, es el único componente que habla con etcd, tanto para leer como para escribir, actuando como una interferfaz de intermediario.

API Server, es configurable, también adminte la adición de API Servers personalizados, cuando el API Server primario se convierte en un proxy de todos los servidores API.

4.5. Master Node Components: Scheduler
El role del Scheduler es asignar nuevos objetosa los pods de los nodos. Durante el proceso de programación, las decisiones se toman en base al estado actual del cluster, y a los requisitos de los nuevos objetos.
El scheduler, obtiene de etcd, a través de API Server, los datos de uso de recursos de cada nodo del cluster.
El Scheduler también recibe de API Server, los requisitos del nuevo objeto. Los requisitos pueden incluir las restricciones que establecen los usuarios y los operadores. El Scheduler también tiene en cuenta los requisitos de calidad (QoS), la localización de los datos, la afinidad, la antiafinidad, tolerancia, etc

Es altamente configurable, si se añaden más Schedulers, es necesario incluir el nonmbre del Schedueler, sino lo gestionará el de por defecto.

Es bastante importante y complejo.


4.6. Master Node Components: Controller Managers

Son componentes del plano de control, en el nodo maestro que regulan el estado del cluster. Son bucles de vigilancia que se ejecutan continuamente y comparan el estado deseado del cluster (proporcionado por los nuevos objectos) con el estado actual (proporcionado de etcd a traves de API Server).
En caso de desajuste, se toman medidas correctivas para coincidir con el estado deseado.

Los Controller Managers, son los encargados de actuar cuando los nodos no están disponibles, garantizar que el número de pods son el esperado, de crear endpoints, service accounts, y API access tokens.
Es el encargado de interactuar con la infraestructura subyacente de un proveedor de nubes cuando los nodos no están disponibles, de gestionar volumenes de almacenamiento, equilibrar el balancedo de carga y el enrutamiento.


4.7. Master Node Components: etcd

Es un almacenamiento de datos clave-valor distribuido que se utiliza para persistir el estado de cluster. Los nuevos datos se escreiben en el almacen solo añadiendolos, los datos nunca son reemplazados. Los datos obsoletos se compactan periódicamente para minimizar el tamaño de etcd.

Solo el API Server es capaz de comunicarse con etcd.

La herramienta de gestión (CLI) de etcd proporciona capacidades de copias de seguridad, snapshots, y restauración. Para los entornos productivos, es importante replicarlos en HA.

Algunas herramientas de arranque de clusters de k8s, por defecto, aprovisionando nodos maestros de etcd aplilados, en los que etcd se ejecuta junto a los demás componentes del nodo maestro y comparte recursos con ellos. Puede aislarse el etcd en un host separado, reduciendo así posibilidades de fallo en etcd. Tanto las configuraciónes en el mismo host o en otro, adminten configuración en HA.

!4.7.png

etcd está escrito en Go. Además de almacenar el estado del cluster, también se almacenan detalles de configuración como subredes, ConfigMaps, secrets, etc

4.8. Worker Node

Un nodo de trabajo, proporciona un entorno de ejecución para las aplicaciones clientes. Aunque son microservicios en contenedores, estas aplicaciones están encapsuladas en Pods, controladas por componentes del nodo maestro.

Los Pods se programan en los Worker Node, donde se encuentran los recursos de computación, memoria, almacenamiento y la red para hablar entre ellos y el mundo exterior.

Un Pod, es la unidad mínima de k8s. Es una colección lógica de uno o más contenedores juntos.

!4.8.png

Además, para acceder a las aplicaciones del mundo exterior, nos conectamos a los worker nodes  y no al nodo maestro.


4.9. Worker Node Components

Un worker Node, cuenta con los siguientes componentes:
* Container runtime
* kubelet
* kube-proxy
* Addons para DNS, Dashboards, monitorización y registros de logs.


4.10. Worker Node Components: Container Runtime

Aunque k8s es un motor de orquestación de contenedores, no tiene la capacidad de manejar directamente los contenedores. Para ejecutar y gestionar el ciclo de vida de un contenedor, se requiere de un runtime en el nodo en el que se va a programar un pod y sus contendores. 
k8s soporta:
* Docker: utiliza como runtime, containerd, es el más utilizado con k8s.
* CRI-O: contenedor ligero para k8s, soporta registros de imagenes Docker.
* containerd: simple y portatil, proporciona robustez.
* rkt: motor nativo para pods, disponible para imagenes docker.
* rktlet:

4.11. Worker Node Components: kubelet


4.12. Worker Node Components: kubelet - CRI shims
4.13. Worker Node Components: kube-proxy
4.14. Worker Node Components: Addons
4.15. Networking Challenges
4.16. Container-to-Container Communication Inside Pods
4.17. Pod-to-Pod Communication Across Nodes
4.18. Pod-to-External World Communication

DUDAS:
* Plano de control, que es exactamente?
* etcd y hosts externos

Chapter 5. Installing Kubernetes
5. Installing Kubernetes








Chapter 6. Minikube - A Local Single-Node Kubernetes Cluster
6. Minikube - A Local Single-Node Kubernetes Cluster








Chapter 7. Accessing Minikube
7. Accessing Minikube








Chapter 8. Kubernetes Building Blocks
8. Kubernetes Building Blocks








Chapter 9. Authentication, Authorization, Admission Control
9. Authentication, Authorization, Admission Control








Chapter 10. Services
10. Services








Chapter 11. Deploying a Stand-Alone Application
11. Deploying a Stand-Alone Application








Chapter 12. Kubernetes Volume Management
12. Kubernetes Volume Management








Chapter 13. ConfigMaps and Secrets
13. ConfigMaps and Secrets








Chapter 14. Ingress
14. Ingress








Chapter 15. Advanced Topics
15. Advanced Topics








Chapter 16. Kubernetes Community
16. Kubernetes Community
