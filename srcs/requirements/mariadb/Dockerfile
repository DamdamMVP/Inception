FROM alpine:3.20

# Installation des paquets nécessaires
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-server-utils

# Création des répertoires nécessaires
RUN mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/log/mysql && \
    chmod 777 /run/mysqld && \
    chmod 755 /var/log/mysql

# Configuration de MariaDB
COPY ./config/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copie du script d'entrée
COPY ./config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposition du port
EXPOSE 3306

# Point d'entrée
ENTRYPOINT ["/entrypoint.sh"]
