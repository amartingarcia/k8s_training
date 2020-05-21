
- Permite generar la plantilla de un pod. Al indicar Never, creará únicamente un pod.
```
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml > pod.yaml
```

- Permite generar la plantilla de un pod. Si indicamos Always, nos creará un deployment
```
kubectl run nginx --image=nginx --restart=Always --dry-run -o yaml > deployment.yaml
```

- --dry-run
Permite ejecutar acciones con kubectl, sin llegar a aplicarlo.
```
kubectl run nginx --image=nginx --restart=Never --dry-run
pod/nginx created (dry run)
```

- Mostrar salida con JSON
```
kubectl run nginx --image=nginx --restart=Never --dry-run -o json
{
    "kind": "Pod",
    "apiVersion": "v1",
    "metadata": {
        "name": "nginx",
        "creationTimestamp": null,
        "labels": {
            "run": "nginx"
        }
    },
    "spec": {
        "containers": [
            {
                "name": "nginx",
                "image": "nginx",
                "resources": {}
            }
        ],
        "restartPolicy": "Never",
        "dnsPolicy": "ClusterFirst"
    },
    "status": {}
}
```

- Mostrar salida con YMAL
```
kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: N
```

- kubectl apply/create. Apply, permite crear un objecto, y si existe, actualizarlo. Sin embargo create, solo permite crearlo.
```
kubectl apply -f pod.yml
kubectl create -f pod.yml
```

