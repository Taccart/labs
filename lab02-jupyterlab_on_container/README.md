# Lab02 Execution d'une image docker avec Container Instance
Scenario : vous avez travaillez sur votre PC dans un Spark Notebooks mais les capacités de votre PC ne suffisent pas...

Vous allez deployer l
 image de [Jupyterlab](https://jupyter.org/) dans Azure Container Instance.
Image a utiliser :  [jupyter/all-spark-notebook](https://hub.docker.com/r/jupyter/all-spark-notebook)

 
>[Jupyterlab](https://jupyter.org/)  is a web-based interactive development environment for Jupyter notebooks, code, and data.
>[Jupyterlab](https://jupyter.org/)  is flexible: configure and arrange the user interface to support a wide range of workflows in data science, scientific computing, and machine learning.
>[Jupyterlab](https://jupyter.org/)  is extensible and modular: write plugins that add new components and integrate with existing ones.



## Etapes
1.Ouvrez votre resource group dans [Azure Portal](https://portal.azure.com)
2.Créez un resource *Container Instance*
```
  Image type : Public
  Image: jupyter/all-spark-notebook
  OS type: Linux

  Networking type: Public
  Ports : 80 (TCP), 8080 (TCP)

  Restart policy: On failure
```

## Conclusion
...
