#!/bin/bash

# Téléchargement de kubectl (outil de ligne de commande Kubernetes)
sudo curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

# Attribution des droits d'exécution à kubectl
sudo chmod +x /usr/local/bin/kubectl

# Téléchargement de Minikube
sudo curl -Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Attribution des droits d'exécution à Minikube
sudo chmod +x /usr/local/bin/minikube

# Démarrage de Minikube (utilisation de VirtualBox comme pilote par défaut)
minikube start

# Vérification de l'installation en affichant l'état des nœuds
kubectl get nodes
