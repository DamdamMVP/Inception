#!/bin/sh

# Vérifie si la DB système MySQL existe déjà
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo ">>> [Entrypoint] Initialisation de la base de données..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    echo ">>> [Entrypoint] Démarrage provisoire de MariaDB (skip-networking)..."
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
    pid="$!"

    # Attendre que MySQL soit prêt
    for i in {30..0}; do
        if echo 'SELECT 1' | mysql &> /dev/null; then
            break
        fi
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 ">>> [Entrypoint] Échec: MySQL n'a pas démarré."
        exit 1
    fi

    echo ">>> [Entrypoint] Configuration de la base utilisateur..."
    mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost');

FLUSH PRIVILEGES;
EOF

    echo ">>> [Entrypoint] Arrêt du serveur provisoire..."
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 ">>> [Entrypoint] Échec lors de l'arrêt de MySQL après init."
        exit 1
    fi
    echo ">>> [Entrypoint] Initialisation terminée."
fi

# Enfin, on lance MariaDB "normalement" sur le port 3306
echo ">>> [Entrypoint] Lancement de MariaDB..."
exec mysqld --user=mysql --console
