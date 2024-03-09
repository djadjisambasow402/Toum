#!/bin/bash

# Mise à jour des packages du système
sudo apt update

# Installation des dépendances nécessaires pour Ansible
sudo apt install -y software-properties-common

# Ajout du référentiel Ansible PPA
sudo apt-add-repository --yes --update ppa:ansible/ansible

# Installation d'Ansible
sudo apt install -y ansible

# Vérification de l'installation
ansible --version
