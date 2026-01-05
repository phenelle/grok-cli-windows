# Grok CLI Windows Installation

Ce projet fournit un script PowerShell pour installer Grok CLI sur Windows.

## Fichiers

- `install-grok-cli.ps1` : Script d'installation

## Installation

Pour installer Grok CLI, ouvrez PowerShell et exécutez la commande suivante dans le répertoire du projet :

```powershell
powershell -ExecutionPolicy Bypass -File .\install-grok-cli.ps1
```

Le script vérifiera automatiquement les privilèges administrateur (et les élèvera si nécessaire), installera les dépendances (Node.js si absent), puis Grok CLI.

## Configuration de la clé API

Pour configurer la clé API Grok comme variable d'environnement sur Windows :

### Méthode PowerShell (persistante)

```powershell
[Environment]::SetEnvironmentVariable("GROK_API_KEY", "ta-clé-ici", "User")
```

Cela définit la variable pour l'utilisateur actuel de manière persistante.