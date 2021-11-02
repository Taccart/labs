# Lab0.2 Execution d'une image docker avec Container Instance
Scenario : vous avez travaillez sur votre PC dans un Spark Notebooks mais les capacités de votre PC ne suffisent pas...

Vous allez deployer l' image de [Jupyterlab](https://jupyter.org/) dans Azure Container Instance.
>[Jupyterlab](https://jupyter.org/)  is a web-based interactive development environment for Jupyter notebooks, code, and data.

Image a utiliser : [`jupyter/all-spark-notebook`](https://hub.docker.com/r/jupyter/all-spark-notebook)

## Etapes
1. Ouvrez votre resource group dans [Azure Portal](https://portal.azure.com)
2. Créez un resource *Container Instance*
```
  Image type : Public
  Image: jupyter/all-spark-notebook
  OS type: Linux

  Networking type: Public
  Ports : 80 (TCP), 8080 (TCP)

  Restart policy: On failure
```

## Conclusion
- Quelles possibilités ?
- Quelles limites ?