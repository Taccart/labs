# A propos de Kubernetes


## architecture d'un cluster 
* Un master, qui dans notre contexte est en charge de la collection de services pour le cluster (serveur API, scheduler, controller manager, etcd...)
* Des nodes, qui on l'agent kubelet, le kube-proxy pour le reseau et l'engine de conteneur. On encore parfois le nom de “minions” pour les nodes.

## *resources* Kubernetes
Les resources Kubernetes sont organisées en `type` ou `Kind` dans l'API.
Parmi toutes les resources on trouve, entre autres, des
* `node`: les machine du cluster.
* `pod`: les groupes de conteneur qui s'execute ensemble sur lesun pod.
* `service`: les endpoint reseau pour les connection des conteneurs
* `namespace`: les groupes de resources permettant un certain niveau d'isolation.
`secret` pour stocker des données sensibles a passer aux conteneurs.
* ...
La liste exhaustive des resources est visible via `kubectl get`.

## Aller plus loin
Essayez le [training play-with-kubernetes : kubernetes-workshop](https://training.play-with-kubernetes.com/kubernetes-workshop/)
ou, pour aller plus loin, l'**excellent tutorial de kubernetes.io [kubernetes basics](https://kubernetes.io/fr/docs/tutorials/kubernetes-basics/)**
[training play-with-kubernetes : kubernetes-workshop](https://training.play-with-kubernetes.com/kubernetes-workshop/)


## Kubernetes minimalistes
Pour tester chez vous, pour des micro projets sur raspberrypi, vous pouvez utiliser
[K3S](https://k3s.io/)
[minikube](https://kubernetes.io/fr/docs/setup/learning-environment/minikube/)
