#!/bin/bash

################################################################################
# Script de réinitialisation complète de Docker et Docker Swarm
# ------------------------------------------------------------------------------
# Auteur      : Souhail
# Création    : 28 Janvier 2025
# Mise à jour : 28 Janvier 2025
# Version     : 1.0
# ------------------------------------------------------------------------------
# Description :
#   - Supprime tous les conteneurs Docker
#   - Supprime toutes les images Docker
#   - Désactive Docker Swarm et supprime tous les services Swarm
#   - Supprime tous les volumes et réseaux Docker
#   - Redémarre le service Docker pour un état propre
# ------------------------------------------------------------------------------
# ⚠️ ATTENTION : Ce script supprime définitivement toutes les données Docker !
# Usage :
#   1. Rendre le script exécutable : chmod +x reset-docker.sh
#   2. Lancer le script en mode administrateur : sudo ./reset-docker.sh
################################################################################

echo "⚠️  ATTENTION : Ce script va supprimer TOUT Docker (conteneurs, services, volumes, networks) !"
read -p "Es-tu sûr de vouloir continuer ? (yes/no) : " confirm

if [[ "$confirm" != "yes" ]]; then
    echo "❌ Annulation..."
    exit 1
fi

echo "🚀 Arrêt et suppression de tous les conteneurs..."
docker rm -f $(docker ps -aq) 2>/dev/null

echo "🗑️ Suppression de toutes les images..."
docker rmi -f $(docker images -q) 2>/dev/null

echo "🛑 Désactivation de Docker Swarm (si activé)..."
docker swarm leave --force 2>/dev/null

echo "🗑️ Suppression de tous les services Swarm..."
docker service rm $(docker service ls -q) 2>/dev/null

echo "🔄 Suppression de tous les stacks Swarm..."
docker stack rm $(docker stack ls --format '{{.Name}}') 2>/dev/null

echo "📦 Suppression de tous les volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null

echo "🌐 Suppression de tous les réseaux..."
docker network rm $(docker network ls -q) 2>/dev/null

echo "🔄 Redémarrage du service Docker..."
systemctl restart docker

echo "✅ Docker est maintenant réinitialisé à son état initial !"
