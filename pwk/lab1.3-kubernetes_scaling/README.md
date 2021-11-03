# Lab07 Mise à l'echelle

L'ajout de pods peut se faire manuellement, en modifiant le nombre de replicas d'un deployment avec la commande 'scale'
`kubectl scale --replicas=5 deployment/flaskDemoDeployment`

Il est toutefois généralement plus interessant de mettre en place de la mise a l'échelle automatisée.

Ceci peut se faire manuellement avec la commande 'autoscale' : 
`kubectl autoscale deployment flaskDemoDeployment --cpu-percent=50 --min=3 --max=10`

Ou, mieux encore : ajouter la demande dans le deployment lui meme: Kubernetes est capable de le faire avec cette formule:
> `desiredReplicas = ceil[currentReplicas * ( currentMetricValue / desiredMetricValue )]`

Pour aller plus loin, consultez les possibilités de Kubernetes : [horizontal pod autoscale](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)

## Etapes

1. Deployez le Horizontal Pod Autoscaler [hpa.yaml](./resources/hpa.yaml).
2. lancez des appels en boucle sur un pod
```
while(true); do curl <POD IP>/hello/test;done
```
vérifiez 