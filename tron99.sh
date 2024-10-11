#!/bin/bash
# test1
# Boucle infinie du menu
while true; do
    clear
    echo "----------------------------------"
    echo "      MENU UTILISATEUR"
    echo "----------------------------------"
    echo "1. Créer un utilisateur"
    echo "2. Supprimer un utilisateur"
    echo "3. Quitter"
    echo "----------------------------------"
    read -p "Choisissez une option (1-3) : " choix

    # Création d'un utilisateur
    if [ "$choix" -eq 1 ]; then
        read -p "Entrez le nom de l'utilisateur à créer : " username

        # Vérification si l'utilisateur existe déjà
        if id "$username" &>/dev/null; then
            echo "L'utilisateur $username existe déjà."
        else
            # Création de l'utilisateur et définition du mot de passe
            sudo useradd "$username"
            if [ $? -eq 0 ]; then
                echo "Utilisateur $username créé avec succès."
                # Demande d'un mot de passe
                sudo passwd "$username"
            else
                echo "Erreur lors de la création de l'utilisateur."
            fi
        fi

    # Suppression d'un utilisateur
    elif [ "$choix" -eq 2 ]; then
        read -p "Entrez le nom de l'utilisateur à supprimer : " username

        # Vérification si l'utilisateur existe
        if id "$username" &>/dev/null; then
            # Confirmation avant suppression
            read -p "Êtes-vous sûr de vouloir supprimer l'utilisateur $username (y/n) ? " confirm
            if [ "$confirm" = "y" ]; then
                sudo userdel "$username"
                if [ $? -eq 0 ]; then
                    echo "Utilisateur $username supprimé avec succès."
                else
                    echo "Erreur lors de la suppression de l'utilisateur."
                fi
            else
                echo "Annulation de la suppression."
            fi
        else
            echo "L'utilisateur $username n'existe pas."
        fi

    # Quitter le programme
    elif [ "$choix" -eq 3 ]; then
        echo "Au revoir !"
        exit 0

    # Option non valide
    else
        echo "Option invalide, veuillez réessayer."
    fi

    # Pause pour que l'utilisateur puisse lire le résultat avant d'afficher le menu à nouveau
    read -p "Appuyez sur Entrée pour continuer..."
done
