# nginx/Dockerfile

FROM alpine:3.20

# Installer Nginx et OpenSSL
RUN apk update && apk add --no-cache nginx openssl

# Créer un utilisateur www-data de manière sécurisée
RUN if ! getent group www-data > /dev/null 2>&1; then \
        addgroup -S www-data; \
    fi && \
    if ! getent passwd www-data > /dev/null 2>&1; then \
        adduser -S -G www-data www-data; \
    fi

# Créer les répertoires nécessaires
RUN mkdir -p /var/www/html/wordpress && \
    mkdir -p /run/nginx && \
    mkdir -p /etc/nginx/ssl

# Générer un certificat SSL auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=dalebran.42.fr"

# Copier les configurations Nginx
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/default.conf /etc/nginx/conf.d/default.conf

# Modifier la configuration Nginx pour utiliser www-data
RUN sed -i 's/user nginx/user www-data/g' /etc/nginx/nginx.conf

# Permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chown -R www-data:www-data /var/lib/nginx && \
    chown -R www-data:www-data /var/log/nginx && \
    chmod -R 755 /var/lib/nginx && \
    chmod -R 755 /var/log/nginx && \
    chown -R www-data:www-data /etc/nginx/ssl && \
    chmod -R 755 /etc/nginx/ssl && \
    chown -R www-data:www-data /run/nginx

# Exposer uniquement le port 443
EXPOSE 443

# Démarrer Nginx en tant que www-data
CMD ["nginx", "-g", "daemon off;"]
