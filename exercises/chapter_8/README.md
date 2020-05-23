
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

- Rolling update
```
kubectl create deploy mynginx --image=nginx:1.15-alpine
```
```
kubectl get deploy,rs,po -l app=mynginx
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/mynginx   1/1     1            1           14s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.extensions/mynginx-66655d5b94   1         1         1       14s

NAME                           READY   STATUS    RESTARTS   AGE
pod/mynginx-66655d5b94-4d9hm   1/1     Running   0          14s
```
```
kubectl scale deploy mynginx --replicas=3
deployment.extensions/mynginx scaled
```
```
kubectl get deploy,rs,po -l app=mynginx                
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/mynginx   3/3     3            3           4m23s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.extensions/mynginx-66655d5b94   3         3         3       4m23s

NAME                           READY   STATUS    RESTARTS   AGE
pod/mynginx-66655d5b94-4d9hm   1/1     Running   0          4m23s
pod/mynginx-66655d5b94-d4w9m   1/1     Running   0          18s
pod/mynginx-66655d5b94-rfq7q   1/1     Running   0          18s
```
```
kubectl describe deployments.apps mynginx 
Name:                   mynginx
Namespace:              default
CreationTimestamp:      Sat, 23 May 2020 10:49:02 +0200
Labels:                 app=mynginx
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=mynginx
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=mynginx
  Containers:
   nginx:
    Image:        nginx:1.15-alpine
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Progressing    True    NewReplicaSetAvailable
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   mynginx-66655d5b94 (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  5m21s  deployment-controller  Scaled up replica set mynginx-66655d5b94 to 1
  Normal  ScalingReplicaSet  76s    deployment-controller  Scaled up replica set mynginx-66655d5b94 to 3
```

- rollback
```
kubectl set image deployment mynginx nginx=nginx:1.16-alpine
deployment.extensions/mynginx image updated
```
```
kubectl rollout history deployment mynginx                  
deployment.extensions/mynginx 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
```
```
kubectl rollout history deployment mynginx --revision=1
deployment.extensions/mynginx with revision #1
Pod Template:
  Labels:       app=mynginx
        pod-template-hash=66655d5b94
  Containers:
   nginx:
    Image:      nginx:1.15-alpine
```
```
kubectl rollout history deployment mynginx --revision=2
deployment.extensions/mynginx with revision #2
Pod Template:
  Labels:       app=mynginx
        pod-template-hash=75cd85c66f
  Containers:
   nginx:
    Image:      nginx:1.16-alpine
```
```
kubectl get deploy,rs,po -l app=mynginx              
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/mynginx   3/3     3            3           9m37s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.extensions/mynginx-66655d5b94   0         0         0       9m37s
replicaset.extensions/mynginx-75cd85c66f   3         3         3       74s

NAME                           READY   STATUS    RESTARTS   AGE
pod/mynginx-75cd85c66f-22zlv   1/1     Running   0          74s
pod/mynginx-75cd85c66f-5vnmv   1/1     Running   0          67s
pod/mynginx-75cd85c66f-8979m   1/1     Running   0          68s
```
```
kubectl rollout undo deployment mynginx --to-revision=1
deployment.extensions/mynginx rolled back
```
```
kubectl get deploy,rs,po -l app=mynginx                
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/mynginx   3/3     3            3           13m

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.extensions/mynginx-66655d5b94   3         3         3       13m
replicaset.extensions/mynginx-75cd85c66f   0         0         0       4m47s

NAME                           READY   STATUS    RESTARTS   AGE
pod/mynginx-66655d5b94-8cblq   1/1     Running   0          45s
pod/mynginx-66655d5b94-f69qv   1/1     Running   0          42s
pod/mynginx-66655d5b94-n5f5d   1/1     Running   0          43s
```
```

```