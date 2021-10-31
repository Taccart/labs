# Lab04 Creation et deploiment d'une image and Azure Container Instance
Nous avons utilisé dans un lab précédent une image _publique_ (jupyterlab), stockée sur DockerHub.
Dans un contexte professionel, votre entreprise préferera peut-etre garder ses images dans des _repositories_ privées. 

Il y a dans ce lab un `Dockerfile` qui construit l'image d'un serveur web Python Flask de demonstration: `app.py` qui répond sur le port 80.

Nous allons voir comment créer l'image, la publier sur une container repository (equivalent privé chez Azur de DockerHub), et l'utiliser.


## Contruction de l'image d'un serveur web Python Flask
Assumant que vous avez installé Docker ou Podman sur votre PC :
1. constuire l'image avec `docker build -t monserveur .`. Si tout va bien, votre image est disponible dans votre repository locale (sur votre PC).
2. executer l'image avec `docker run --rm -p 8080:80 monserveur` 
3. ouvrez les pages pour constater le foncionnement correct du serveur web.
   1. [http://127.0.0.1:8080](http://127.0.0.1:8080)
   2. [http://127.0.0.1:8080/hello/<votre nom>](http://127.0.0.1:8080/hello/)   


## Etapes pour publier votre image 

