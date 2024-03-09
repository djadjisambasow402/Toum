#!/bin/bash

# Mise à jour des packages du système
sudo apt update

# Installation des dépendances pour permettre l'utilisation de paquets via HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Ajout de la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajout du référentiel Docker dans APT
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour de la liste des packages après l'ajout du référentiel
sudo apt update

# Installation de Docker Engine et Docker CLI
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Ajout de l'utilisateur actuel au groupe docker pour éviter l'utilisation constante de sudo
sudo usermod -aG docker $USER

# Activation du service Docker au démarrage
sudo systemctl enable docker

# Démarrage du service Docker
sudo systemctl start docker

# Vérification de l'installation en exécutant une image de test
sudo docker run hello-world
