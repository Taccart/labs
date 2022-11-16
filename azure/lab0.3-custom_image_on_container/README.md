# Lab0.3
Creation et deploiment d'une image and Azure Container Instance
Nous avons utilisé dans un lab précédent une image _publique_ (jupyterlab), stockée sur DockerHub.
Dans un contexte professionel, votre entreprise préferera peut-etre garder ses images dans des _repositories_ privées. 

Il y a dans ce lab un `Dockerfile` qui construit l'image d'un serveur web Python Flask de demonstration: `app.py` qui répond sur le port 80.

Nous allons voir comment créer l'image, la publier sur une container repository (equivalent privé chez Azur de DockerHub), et l'utiliser.


## Contruction de l'image d'un serveur web Python Flask
Supposant vous avez Docker ou Podman sur votre PC :
1. constuire l'image avec `docker build -t flaskdemo .`. Si tout va bien, votre image est disponible dans votre repository locale (sur votre PC).
1. executer l'image avec `docker run --rm -p 8080:80 flaskdemo` 
1. ouvrez les pages pour constater le foncionnement correct du serveur web.
   1. [http://127.0.0.1:8080](http://127.0.0.1:8080) 
      
      <img src="https://user-images.githubusercontent.com/26376087/202153170-4a253bd6-1494-45c6-9891-f7f24e8f5e55.png" width=500px>
   1. [http://127.0.0.1:8080/hello/<votre nom>](http://127.0.0.1:8080/hello/)
   
      <img src="https://user-images.githubusercontent.com/26376087/202154542-5e662e72-6ed3-44b5-8460-765802299e23.png" width=500px>




## Publication de votre image dans votre Registry
1. Dans Azure Portal, créez une Container Registry ayant pour nom myRegisteryDemo

   <img src="https://user-images.githubusercontent.com/26376087/202155415-13860d98-0315-4df0-9e81-039bcee7d494.png" width=500px>

1. Recuperer les `UserName` et `Password` de votre registry dans Access keys de votre Registry

   <img src="https://user-images.githubusercontent.com/26376087/202167972-c101e71f-f43e-4f12-8a44-70cb2f1ba0fe.png" width=500px>

1. dans le shell de votre ordinateur
   1. Mettez vous dans le repertoire azure\lab0.3-custom_image_on_container
   1. `docker login myregisterydemo.azurecr.io` puis rentrez les identifiants de votre resistry
   1. `docker build -t myregisterydemo.azurecr.io/flaskdemo .`
   1. `docker push myregisterydemo.azurecr.io/flaskdemo`
   1. Vous devriez voir flaskdemo dans votre Repositories
   
   <img src="https://user-images.githubusercontent.com/26376087/202169141-c777aec4-3b40-40ad-9468-9a414da0b7a9.png" width=500px>
   
## Execution de votre image dans `Azure Container Instance`
1. Créez un resource *Container Instances*

   <img src="https://user-images.githubusercontent.com/26376087/202170180-4cfb8068-df0c-4195-b313-983fa30ec0e5.png" width=500px>

   <img src="https://user-images.githubusercontent.com/26376087/202170377-012c65d6-0926-46d0-a2fd-decc8377fee7.png" width=500px>

2. Apres quelques minutes, l'instance est crée et en attendant encore un peu si on click sur FDQN dans Overview du container instance,
   on observe la page
   
   <img src="https://user-images.githubusercontent.com/26376087/202171628-ea397396-4de1-4108-9fa5-2a70147101ca.png" width=400px>
   
   <img src="https://user-images.githubusercontent.com/26376087/202153170-4a253bd6-1494-45c6-9891-f7f24e8f5e55.png" width=400px>


## Conclusion
- Quelles possibilités ?
- Quelles limites ?
