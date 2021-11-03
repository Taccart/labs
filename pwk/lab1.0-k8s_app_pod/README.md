# Lab1.0 Excecution Kubernetes 
Pour ce lab, nous allons nous affranchir de solution payantes.
Pour ce faire vous allez 
1. créer un compte et configurer votre propre [docker.com](https://www.docker.com/)
2. y publier votre image (créé au lab03) 
3. demarrer un cluser kubernetes sur 
4. executer votre image dans votre cluster kubernetes


## Préparation

### docker.io
1. Si vous n'en avez pas, créez un compte sur [docker.com (signup)](https://www.docker.com/)
2. Créez une repository <marepo>
3. Créez un token de securité `Account Settings`>`Security`>`Token` et **gardez sa valeur** :)

### play-with-k8s.com
1. Si vous n'en avez pas, créez un espace [labs.play-with-k8s.com](https://labs.play-with-k8s.com) en utilisant votre compte docker.
2. Demarrage de votre cluster Kubernetes 
   1. Créez une nouvelle instance
   2. Démarrez-y le master node de votre cluster:
```
kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16 && \
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml && \
export KUBECONFIG=/etc/kubernetes/admin.conf
```
Notez le message suivant : il contient **la commande a executer sur les autres nodes que vous allez ajouter a votre cluster**

*Then you can join any number of worker nodes by running the following on each as root:*
`kubeadm join 192.168.0.33:6443 --token ... --discovery-token-ca-cert-hash sha256:...`
(cette commande peut etre retrouvée via `kubeadm token create --print-join-command`)
   3. Ajoutez un reseau 
`kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"`
   4. créez deux instances qui serviront de nodes, executez-y la commande `kubeadm join ...` 

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

## Deploiement de votre service web
Dans ce lab, le déploiement se fera a minima [pod](https://kubernetes.io/fr/docs/concepts/workloads/pods/pod/).
### Deploiement de votre image
```
kubectl run flaskdemo --image <VOTRE IMAGE>
```
A ce stade, votre image devrait être opérationnelle.
Vous pouvez vérifier avec `kubectl get pods` qui devrait indiquer un état `Ready`.
`kubectl describe flaskdemo` vous donner l'adresse IP a la quelle votre webapp répond.
Attention : a ce stade, votre serveur web fonctionne dans kubernetes, mais aucune route ne permet d'y accéder de l'extérieur du cluster :)

### Test de votre image
A partir de la console de votre master, exécutez un simple  
`curl <IP du pod flaskdemo>`.


