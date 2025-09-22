#!/bin/bash

# Variables
BINDIP=0.0.0.0
IP=$1
BASE_DIR=$2
RS_NAME=rs0

# Étape 1 : Suppression des anciens fichiers de données
echo "Suppression des anciens répertoires de données..."
rm -rf "$BASE_DIR/rs0" "$BASE_DIR/rs1" "$BASE_DIR/rs2" "$BASE_DIR/arb"

# Étape 2 : Création des dossiers
echo "Création des répertoires de données..."
mkdir -p "$BASE_DIR/rs0" "$BASE_DIR/rs1" "$BASE_DIR/rs2" "$BASE_DIR/arb"

# Étape 3 : Lancement des instances mongod
echo "Lancement des instances mongod..."
mongod --replSet $RS_NAME --port 27017 --dbpath "$BASE_DIR/rs0" --bind_ip $BINDIP --fork --logpath "$BASE_DIR/rs0/mongod.log"
mongod --replSet $RS_NAME --port 27018 --dbpath "$BASE_DIR/rs1" --bind_ip $BINDIP --fork --logpath "$BASE_DIR/rs1/mongod.log"
mongod --replSet $RS_NAME --port 27019 --dbpath "$BASE_DIR/rs2" --bind_ip $BINDIP --fork --logpath "$BASE_DIR/rs2/mongod.log"
mongod --replSet $RS_NAME --port 30000 --dbpath "$BASE_DIR/arb" --bind_ip $BINDIP --fork --logpath "$BASE_DIR/arb/mongod.log"

# Attente de démarrage
sleep 5

# Étape 4 : Initialisation du ReplicaSet
echo "Initialisation du ReplicaSet..."
mongosh --port 27017 --eval "
rs.initiate({
  _id: '$RS_NAME',
  members: [
    { _id: 0, host: '$IP:27017' },
    { _id: 1, host: '$IP:27018' },
    { _id: 2, host: '$IP:27019' },
    { _id: 3, host: '$IP:30000', arbiterOnly: true }
  ]
});
"

# Étape 5 : Affichage du statut du ReplicaSet
sleep 3
mongosh --port 27017 --eval "rs.status()"
