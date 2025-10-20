# Serveur Nextcloud

Code source de mon projet de serveur Nextcloud.
Pour garantir un apprentissage solide de Kubernetes, j'ai choisi d'écrire chaque manifeste
à la main plutôt que l'installation semi-automatisée avec Helm.

## Déploiement multi-environnement
Le code permet à Argo CD de déployer le serveur dans un environnement de production.
Au besoin, il permet également dupliquer le serveur dans un environnement de développement pour tester des mises à jour, des paramétrages de performance ou des montées de version.

## Technologies utilisées

- PHP, MariaDB, Redis, Nginx, SealedSecrets, 
- Docker, Git, GitHub Actions et GitHub Packages (Partie CI)
- Kubernetes (PV, PVC), Kustomize, Argo CD (Partie CD), Hooks

## Liens utiles

- 🌐 [Adresse du portfolio en ligne](https://lumitek.fr)
- ☁️ [Mon Projet Cloud](https://cloud.lumitek.fr/s/tFfkts7BwxtGiBm)
- 💼 [Mon profil LinkedIn](https://www.linkedin.com/in/luclouisdelorme/)  
- 🐙 [Mon GitHub](https://github.com/Luc426)

## Contacter

**Email :** [luclouis.delorme@lumitek.fr]  

## Architecture

```bash
nextcloud-project/
├── cloud-application.yaml
├── cloud-devnet.yaml
├── dockerfiles
│   ├── nginx.dockerfile
│   └── php.dockerfile
├── k8s
│   ├── base
│   │   ├── cronjobs
│   │   │   ├── cronjobs.yaml
│   │   │   └── kustomization.yaml
│   │   ├── kustomization.yaml
│   │   ├── nginx
│   │   │   ├── config
│   │   │   │   ├── default.conf
│   │   │   │   └── nginx.conf.template
│   │   │   ├── deployment.yaml
│   │   │   ├── kustomization.yaml
│   │   │   └── service.yaml
│   │   ├── php
│   │   │   ├── config
│   │   │   │   ├── nextcloud.ini.template
│   │   │   │   └── www.conf
│   │   │   ├── deployment.yaml
│   │   │   ├── kustomization.yaml
│   │   │   └── service.yaml
│   │   └── redis
│   │       ├── deployment.yaml
│   │       ├── kustomization.yaml
│   │       └── service.yaml
│   └── overlays
│       ├── devnet
│       │   ├── configmap
│       │   │   ├── config-php.yaml
│       │   │   └── kustomization.yaml
│       │   ├── ingress
│       │   │   ├── fake-certificat.yaml
│       │   │   ├── fake-tls.yaml
│       │   │   └── kustomization.yaml
│       │   ├── jobs
│       │   │   ├── kustomization.yaml
│       │   │   ├── rsync-userdata.yaml
│       │   │   └── rsync-webdata.yaml
│       │   ├── kustomization.yaml
│       │   ├── mariadb
│       │   │   ├── deployment.yaml
│       │   │   ├── kustomization.yaml
│       │   │   └── service.yaml
│       │   ├── secrets
│       │   │   ├── kustomization.yaml
│       │   │   └── sealedsecrets.yaml
│       │   └── storage
│       │       ├── kustomization.yaml
│       │       ├── persistentVolumesClaim.yaml
│       │       └── persistentVolumes.yaml
│       └── prod
│           ├── configmap
│           │   ├── config-php.yaml
│           │   └── kustomization.yaml
│           ├── infra
│           │   ├── kustomization.yaml
│           │   └── resourceQuota.yaml
│           ├── ingress
│           │   ├── kustomization.yaml
│           │   └── tls.yaml
│           ├── kustomization.yaml
│           ├── mariadb
│           │   ├── kustomization.yaml
│           │   ├── service.yaml
│           │   └── statefulset.yaml
│           ├── secrets
│           │   ├── kustomization.yaml
│           │   └── sealedsecrets.yaml
│           └── storage
│               ├── kustomization.yaml
│               ├── persistentVolumesClaim.yaml
│               └── persistentVolumes.yaml
└── README.md
```
---