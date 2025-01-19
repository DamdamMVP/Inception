#!/bin/sh

# Initialiser la base de données si elle n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialisation de la base de données
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Démarrer MySQL temporairement
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
    pid="$!"

    # Attendre que MySQL démarre
    for i in {30..0}; do
        if echo 'SELECT 1' | mysql &> /dev/null; then
            break
        fi
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi

    # Configurer la base de données
    mysql <<EOF
-- Créer la base de données
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Créer l'utilisateur WordPress et donner les permissions
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Sécuriser l'utilisateur root
CREATE USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost');

FLUSH PRIVILEGES;
EOF

    # Arrêter MySQL temporaire
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi
fi

# Démarrer MySQL normalement
exec mysqld --user=mysql --console
