#!/bin/bash

echo "=== Téléchargement des partitions stock via EDL ==="
echo ""
read -p "Entrez le nom du dossier de destination (ex: ufi001b): " folder_name

if [ -z "$folder_name" ]; then
    echo "Erreur: Le nom du dossier ne peut pas être vide"
    exit 1
fi

stock_dir="stock/$folder_name"

if [ ! -d "$stock_dir" ]; then
    echo "Création du dossier: $stock_dir"
    mkdir -p "$stock_dir"
else
    echo "Le dossier $stock_dir existe déjà"
fi

echo ""
echo "Téléchargement des partitions dans: $stock_dir"
echo ""

for n in fsc fsg modem modemst1 modemst2 persist sec; do
    echo "Téléchargement de $n..."
    if edl r ${n} "$stock_dir/${n}.bin"; then
        echo "✓ $n téléchargé avec succès"
    else
        echo "✗ Erreur lors du téléchargement de $n"
    fi
    echo ""
done

echo "=== Téléchargement terminé ==="
echo "Fichiers sauvegardés dans: $stock_dir"
