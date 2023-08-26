# Android Emulator Docker Image

## Description

Ce dépôt contient un Dockerfile pour créer une image Docker de l'émulateur Android. Cette image vous permet de lancer un émulateur Android dans un conteneur Docker, ce qui peut être utile pour le développement, les tests ou l'automatisation de tâches sur un appareil Android virtuel.

## Prérequis

- Docker installé sur votre machine
- Support KVM (Kernel-based Virtual Machine) pour l'accélération matérielle
  - Assurez-vous que la virtualisation est activée dans le BIOS de votre machine.
  - Assurez-vous que le module KVM est chargé sur votre système Linux (`lsmod | grep kvm`).

## Construction de l'image Docker

Pour construire l'image Docker, naviguez jusqu'au répertoire contenant le Dockerfile et exécutez la commande suivante :

\```bash
docker build -t android-emulator .
\```

Cela va construire l'image Docker et la tagger avec le nom `android-emulator`.

## Exécution de l'émulateur Android

Une fois l'image construite, vous pouvez exécuter un conteneur en utilisant la commande suivante :

\```bash
docker run --privileged -p 5037:5037 android-emulator
\```

Note : L'option `--privileged` est nécessaire pour permettre l'accès aux fonctionnalités du noyau telles que KVM pour l'accélération matérielle.

## Connexion à l'émulateur Android

Vous pouvez vous connecter à l'émulateur Android en utilisant ADB (Android Debug Bridge) :

\```bash
adb connect localhost:5037
\```
