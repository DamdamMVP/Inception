-- Créer la base de données si elle n'existe pas
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Créer l'utilisateur s'il n'existe pas
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Donner tous les privilèges à l'utilisateur sur la base de données
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Appliquer les changements
FLUSH PRIVILEGES;
