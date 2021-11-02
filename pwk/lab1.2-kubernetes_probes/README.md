# Lab 1.2 Probes
Kubernetes permet de décrire trois types de [sondes d'etat](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#conteneur-probes) optionnelles:
- les `livenessProbe` qui indiquent si un conteneur est en cours execution. En cas d'échec de la sonde, le kubelet tuera le conteneur, et appliquera la `restart policy`
- les `readinessProbe` qui indiquent si un conteneur est prêt à répondre aux requêtes. En cas d'échec, l'IP du pod est supprimée des destinations des services correspondants.
- les `startupProbe` qui indiquent l'état de l'application embarquée dans le conteneur. Si une `startupProbe` est donnée, elle prend le pas sur les deux autres sondes.

En elles-même, les sondes sont définies par 
- une `ExecAction`: une commande executée dans le conteneur, qui doit renvoyer un code de sortie de 0 pour être considérée comme un succès.
- une `TCPSocketAction`: un test TCP sur un port donné du pod. Si le port est ouvert le test est considéré comme un succès. 
- une `HTTPGetAction`: une requête HTTP GET sur un port et un path donné du pod. Est considérée comme un succès si le code de response est entre 200 (incl.) et 400 (excl.)

Gardez à l'esprit que la charge (CPU/Mémoire) nécessaires pour répondre aux ExecAction et HTTPGetAction et le temps de réponse doivent être les plus faibles possibles.
