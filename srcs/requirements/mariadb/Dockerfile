# requirements/mariadb/Dockerfile

FROM alpine:3.20

# Installer MariaDB + utilitaires
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-server-utils

# Préparer les répertoires
RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql && \
    chmod 777 /run/mysqld && \
    chmod 755 /var/log/mysql

# Copier le script d'entrée
COPY ./config/entrypoint.sh /entrypoint.sh
COPY ./config/my.cnf /etc/my.cnf
RUN chmod +x /entrypoint.sh

EXPOSE 3306

# On lance notre script entrypoint
ENTRYPOINT ["/entrypoint.sh"]
