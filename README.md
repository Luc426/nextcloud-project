# Serveur Nextcloud

Code source de mon projet de serveur Nextcloud.
Pour garantir un apprentissage solide de Kubernetes, j'ai choisi d'écrire chaque manifeste
à la main plutôt que l'installation semi-automatisée avec Helm.

## Déploiement multi-environnement
Le code est livré avec deux objets de type Application permettant à Argo CD de déployer au besoin le serveur dans un environnement de production ou de développement.  
L'environnement de développement (Devnet) permet de dédoubler le serveur de production dans un espace de nom dédié pour tester des mises à jour, des paramétrages de performance ou des montées de version sans impacter la production, et au plus près de sa configuration, sans persistence des données.

## Technologies utilisées

- PHP, MariaDB, Redis, Nginx, SealedSecrets   
- Docker, Git, GitHub Actions et GitHub Packages (Partie CI)  
- Kubernetes (PV, PVC, NetworkPolicy, Ingress), Kustomize, Argo CD, Hooks (Partie CD)  

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
│   │   ├── networkpolicies
│   │   │   ├── backend.yaml
│   │   │   ├── database.yaml
│   │   │   ├── frontend.yaml
│   │   │   ├── kustomization.yaml
│   │   │   └── redis.yaml
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