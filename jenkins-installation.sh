#!/bin/bash

# Mise à jour des packages du système
sudo apt update

# Installation de Java
sudo apt install -y openjdk-11-jdk

# Ajout de la clé GPG du référentiel Jenkins
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# Ajout du référentiel Jenkins aux sources du système
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Mise à jour de la liste des packages
sudo apt update

# Installation de Jenkins
sudo apt install -y jenkins

# Démarrage du service Jenkins
sudo systemctl start jenkins

# Activation du démarrage automatique de Jenkins
sudo systemctl enable jenkins

# Vérification du statut du service Jenkins
sudo systemctl status jenkins

# Affichage du mot de passe initial
echo "Mot de passe initial Jenkins:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
