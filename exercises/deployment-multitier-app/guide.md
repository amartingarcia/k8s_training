Crea un namespaces
```bash
kubectl create ns rsvp
```

Asignamos el nampesace por defecto al contexto
```bash
kubectl config set-context --namespace rsvp minikube
```

aplicamos todos los ficheros y posteriormente analizamos cada uno.
```bash
kubectl apply -f .
```

```bash
minikube -p minikube dashboard
```