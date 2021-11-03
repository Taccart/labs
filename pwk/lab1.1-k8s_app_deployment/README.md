# Lab1.1 Déploiements Kubernetes
Vous avez vu dans le lab 1.0 comment démarrer votre image dans un pod. 
Nous allons voir dans ce lab comment rendre votre web app vraiment opérationnelle grace aux descripteurs de resources.

# Les descripteurs 
``` 
    |                  |                       /  --> pod->conteneur
PC  | -> (Internet) -> | Ingress -> Service -> *  --> pod->conteneur
    |                  |                       \  --> pod->conteneur
```
 
## [deployement](https://kubernetes.io/fr/docs/concepts/workloads/controllers/deployment/)
Le déployment va nous permettre de décrire, entre autres, quelles quantité de mémoire et CPU nous voulons allouer a nos pods et combien de pods nous voulons
## [service](https://kubernetes.io/fr/docs/concepts/services-networking/service/)
Le service est une resource qui survit aux pods : un moyen perenne de s'adresser à votre webapp
## [ingress](https://kubernetes.io/fr/docs/concepts/services-networking/ingress/)
L'ingress publie un point d'entrée publique vers votre service

# Déploiment des resources
```
kubectl apply -f <fichier yaml>
```
* [kubectl apply -f deployment.yaml](./resources/deployment.yaml)
* [kubectl apply -f service.yaml](./resources/service.yaml)
* [kubectl apply -f ingress.yaml](./resources/ingress.yaml)

Vérifications :  `kubectl get <type> <nom>` ou `kubectl describe <type> <nom>` 

Aller plus loin : [A visual guide on troubleshooting Kubernetes deployments](https://learnk8s.io/troubleshooting-deployments) (voir le [PDF](https://learnk8s.io/a/a-visual-guide-on-troubleshooting-kubernetes-deployments/troubleshooting-kubernetes.v2.pdf))

#Test
1. executez `kubectl get pods` pour voir l'état des pods
2. tuez les pod avec `kubectl delete pod <podname>`
3. executez `kubectl get pods` a nouveau pour voir l'état des pods..