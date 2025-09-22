# Analyse d'annonces

Ce projet analyse des annonces de type Airbnb

## Prérequis

- mongod
- mongosh

## Installation

1. **Cloner le dépôt**

```bash
git clone https://github.com/nau81000/ad_analysis.git
cd ad_analysis
```

2. **Installer poetry**

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

3. **Créer l'environnement (installer les dépendances)**

```bash
poetry install --no-root
```

5. **Lancer MongoDB**

```
./start_replicaset.sh <ip> <data_folder>
```

Ex:

```
./start_replicaset.sh 127.0.0.1 ./data
```

6. **Utiliser le notebook python dans un navigateur pour importer les données et faire des requêtes**

```bash
jupyter lab neotebook.ipynb
```

