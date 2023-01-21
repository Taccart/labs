# Play with Kubernetes

1.Connectez vous :` https://labs.play-with-k8s.com/ ![PWK home.png](readme.pictures%2FPWK%20home.png)
2. Creez une nouvelle instance K8S ![PWK create instance.png](readme.pictures%2FPWK%20create%20instance.png)
3. Lisez les messages 
4. Demarrez le master node
```
kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16
```
Vous obtenez un cluster  a un noeud. ![PWK started.png](readme.pictures%2FPWK%20started.png)
5. Preparez votre kube config: dans votre console PWK, executez 
```shell
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```
 
6. Votre PWK est pret : regardez avec 
```shell
kubectl get all -A
```
![PWK view all.png](readme.pictures%2FPWK%20view%20all.png)

7. lisez
  * [A propos de Play With Kubernetes](about-pwk.md)
  * [A propos de kubernetes.md](about-kubernetes.md)