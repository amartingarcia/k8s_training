# 
```
```

# kubectl
Permite interactuar con el cluster. 
Con el parámetro --help, nos muestra todos los parámetros permitidos, podemos obtener información del cluster, hasta desplegar aplicaciones.

## kubectl --help
```
kubectl --help

kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create         Create a resource from a file or from stdin.
  expose         Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
  run            Run a particular image on the cluster
  set            Set specific features on objects

Basic Commands (Intermediate):
  explain        Documentation of resources
  get            Display one or many resources
  edit           Edit a resource on the server
  delete         Delete resources by filenames, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout        Manage the rollout of a resource
  scale          Set a new size for a Deployment, ReplicaSet or Replication Controller
  autoscale      Auto-scale a Deployment, ReplicaSet, or ReplicationController

Cluster Management Commands:
  certificate    Modify certificate resources.
  cluster-info   Display cluster info
  top            Display Resource (CPU/Memory/Storage) usage.
  cordon         Mark node as unschedulable
  uncordon       Mark node as schedulable
  drain          Drain node in preparation for maintenance
  taint          Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe       Show details of a specific resource or group of resources
  logs           Print the logs for a container in a pod
  attach         Attach to a running container
  exec           Execute a command in a container
  port-forward   Forward one or more local ports to a pod
  proxy          Run a proxy to the Kubernetes API server
  cp             Copy files and directories to and from containers.
  auth           Inspect authorization

Advanced Commands:
  diff           Diff live version against would-be applied version
  apply          Apply a configuration to a resource by filename or stdin
  patch          Update field(s) of a resource using strategic merge patch
  replace        Replace a resource by filename or stdin
  wait           Experimental: Wait for a specific condition on one or many resources.
  convert        Convert config files between different API versions
  kustomize      Build a kustomization target from a directory or a remote url.

Settings Commands:
  label          Update the labels on a resource
  annotate       Update the annotations on a resource
  completion     Output shell completion code for the specified shell (bash or zsh)

Other Commands:
  api-resources  Print the supported API resources on the server
  api-versions   Print the supported API versions on the server, in the form of "group/version"
  config         Modify kubeconfig files
  plugin         Provides utilities for interacting with plugins.
  version        Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
```

## kubectl config get-context
Interactuamos con nuestra configuración local para acceder a nuestro cluster.
Exite un fichero en ~/.kube/config.
```
kubectl config get-context

kubectl config get-contexts
CURRENT   NAME              CLUSTER    AUTHINFO   NAMESPACE
*         curso             curso      curso      
          minikube          minikube   minikube   
```

## kube/config 
Contiene 3 partes importantes:
- Clusters: cluster configurados en este fichero.
- Context: asociación de un cluster con unas credenciales
- users: usuario para conectar al cluster.

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/adrian.martin/.minikube/ca.crt
    server: https://192.168.39.195:8443
  name: curso
- cluster:
    certificate-authority: /home/adrian.martin/.minikube/ca.crt
    server: https://192.168.39.197:8443
  name: minikube
contexts:
- context:
    cluster: curso
    user: curso
  name: curso
- context:
    cluster: minikube
    user: minikube
  name: minikube
kind: Config
preferences: {}
users:
- name: curso
  user:
    client-certificate: /home/adrian.martin/.minikube/client.crt
    client-key: /home/adrian.martin/.minikube/client.key
- name: minikube
  user:
    client-certificate: /home/adrian.martin/.minikube/client.crt
    client-key: /home/adrian.martin/.minikube/client.key

```

## minikube profile list
```
|----------|-----------|---------|----------------|------|---------|---------|
| Profile  | VM Driver | Runtime |       IP       | Port | Version | Status  |
|----------|-----------|---------|----------------|------|---------|---------|
| minikube | kvm2      | docker  | 192.168.39.197 | 8443 | v1.17.3 | Running |
|----------|-----------|---------|----------------|------|---------|---------|
```

Es posible indicar la versión de kubernetes, además de limitarlo.
```
minikube start -p training --cpus=3 --memory=3000 --kubernetes-version=1.15.4
```