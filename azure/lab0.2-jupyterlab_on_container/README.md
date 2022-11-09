# Lab0.2 Execution d'une image docker avec Container Instance
Scenario : vous avez travaillez sur votre PC dans un Spark Notebooks mais les capacités de votre PC ne suffisent pas...

Vous allez deployer l' image de [Jupyterlab](https://jupyter.org/) dans Azure Container Instance.
>[Jupyterlab](https://jupyter.org/)  is a web-based interactive development environment for Jupyter notebooks, code, and data.

Image a utiliser : [`jupyter/all-spark-notebook`](https://hub.docker.com/r/jupyter/all-spark-notebook)

## Etapes
1. Ouvrez votre resource group dans [Azure Portal](https://portal.azure.com)
2. Créez un resource *Container Instances*
3. Mettre le nom : lab02, Image source : Other registry et image : jupyter/all-spark-notebook

<img src="https://user-images.githubusercontent.com/26376087/200858183-9ef045aa-650e-47a5-8ed6-0455ffbfaa70.PNG" width=500px>

4. Next : Networking, DNS name label : label02 et port 8080 TCP

<img src="https://user-images.githubusercontent.com/26376087/200856242-c103ae3f-dcf5-44f7-abef-a432f0326d9b.PNG" width=500px>

5. Review and Create, attendez quelques minutes et l'instance est lancé

## Conclusion
- Quelles possibilités ?
- Quelles limites ?
