# Lab0.1 : création d'un site web statique avec Azure


## Etapes

1. Créer un repo github avec votre compte git pour votre page web static avec le [Generateur Vanilla](https://github.com/staticwebdev/vanilla-basic/generate)
2. Donner le nom : lab0.1-static_website

Notes : index.html se situe dans le dossier /src de votre nouveau repo

3. Ouvrez [Azure Portal](https://portal.azure.com)
4. Créez une resource  [Static Web Apps](https://docs.microsoft.com/fr-fr/azure/static-web-apps/) de nom : lab01staticwebsite
5. Entrez votre Resource Group puis votre github, le repo lab0.1-static_website (branch main)  et app location/Output Location : ./src
<img
  src="https://user-images.githubusercontent.com/26376087/200795413-dca28fb8-db16-4c36-b6b4-916742b69e59.PNG"
     width=500px>
6. Allez sur Next : Tags et entrez owner en nom et sa valeur :

<img
  src="https://user-images.githubusercontent.com/26376087/200796963-747f387a-8e26-425f-85d7-6ff6062888c4.PNG"
     width=500px>

7. Review + Create puis Create
8. Le deploiment est rapide, ensuite allez sur Go to resource et dans Overview GitHub Action runs, une fois que github aura terminé, 
vous pouvez acceder depuis OverView à l'URL du site

<img
  src="https://user-images.githubusercontent.com/26376087/200799973-5e7c2e78-2513-4ef8-997b-585a8ef96321.PNG"
     width=500px>


## Conclusion
- Quelles possibilités ?
- Quelles limites ?
