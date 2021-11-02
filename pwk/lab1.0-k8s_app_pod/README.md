# Lab1.0 Excecution Kubernetes 
Pour ce lab, nous allons nous affranchir de solution payantes.
Pour ce faire vous allez 
1. créer un compte et configurer votre propre [docker.io](https://index.docker.io/signup)
2. y publier votre image (créé au lab03) 
3. demarrer un cluser kubernetes sur 
4. executer votre image dans votre cluster kubernetes


## Préparation

### docker.io
1. Si vous n'en avez pas, créez un compte sur [docker.io](https://index.docker.io/signup)
2. Créez une repository <marepo>
3. Créez un token de securité Account Settings>Security>Token

### play-with-k8s.com
1. Si vous n'en avez pas, créez un espace [labs.play-with-k8s.com](https://labs.play-with-k8s.com) en utilisant votre compte docker.
2. Demarrage de votre cluster Kubernetes 
   1. Créez une nouvelle instance sur 
   2. Démarrez le master node:
```
kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml
export KUBECONFIG=/etc/kubernetes/admin.conf
```
Notez le message suivant : il contient la commande a executer sur les autres nodes que vous allez ajouter a votre cluster

*Then you can join any number of worker nodes by running the following on each as root:*

`kubeadm join 192.168.0.33:6443 --token ...
--discovery-token-ca-cert-hash sha256:2b29c1b2703e148cce5789d72db2f5fc3cc22c0b32a661ae3f502dabc74debd8`
   3. ajouter deux autres instances, et executez-y la commande `kubeadm join ...`

A ce stade, vous devriez pouvoir vérifier l'état de votre cluster: sur le master node, vous devriez voir tous les nodes en état `Ready`
1
```[node1 ~]$ kubectl get nodes
NAME    STATUS   ROLES                  AGE     VERSION
node1   Ready    control-plane,master   9m39s   v1.20.1
node2   Ready    <none>                 7m28s   v1.20.1
node3   Ready    <none>                 7m19s   v1.20.1
```

Installez le kubernetes dashboard pour avoir une GUI sur Kubernetes: 
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.3.1/aio/deploy/recommended.yaml
```

## Création et publication de votre image

### Contruction de l'image d'un serveur web Python Flask
Supposant vous avez Docker ou Podman sur votre PC :
1. constuire l'image avec `docker build -t flaskdemo .`. Si tout va bien, votre image est disponible dans votre repository locale (sur votre PC).
1. executer l'image avec `docker run --rm -p 8080:80 flaskdemo`
1. ouvrez les pages pour constater le foncionnement correct du serveur web.
    1. [http://127.0.0.1:8080](http://127.0.0.1:8080)
    1. [http://127.0.0.1:8080/hello/<votre nom>](http://127.0.0.1:8080/hello/)
    
### Publication de votre image
Pour publier votre image, vous allez utiliser `docker tag` et  `docker push` :
Ouvrez une session sur docker.io avec votre token comme mot de passe
```
docker login -u <votredockerid>
```
Puis associez un nouveau tag avant de pousser votre image sur votre repo.
```
docker tag flaskdemo:latest marepo:latest
docker push marepo:latest
```

## Deploiement de votre image
Dans ce lab, le déploiement se fera dans un [pod](https://kubernetes.io/fr/docs/concepts/workloads/pods/pod/).
Regardez dans le `pod.yaml`: il y a la description d'un conteneur unique 
```
  containers:
    - name: flaskdemo
      image: <VOTRE-IMAGE>
        resources:
           requests:
             memory: "100Mi"
             cpu: 0.1

```
Vous noterez la présence de `resources` : si kubernetes n'est pas capable d'allouer les resources demandées dans `request` le pod ne pourra pas être démarré.
L'unité de mesure pour les CPU correspond à 1 hyperthread sur un PC, 1 vCPU chez AWS et Azure et 1 GCP core. Les resources CPU peuvent etre exprimées en millicore (suffixe m) ou nombre ( ex: 500m équivaut a 0.5) 
Un conteneur qui demande 0.25 CPU a la garantie d'avoir à disposition un quart de ce qu'obtiendrait un conteneur demandant 1 CPU.

## Test 