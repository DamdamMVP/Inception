# requirements/nginx/Dockerfile

FROM alpine:3.20

RUN apk update && apk add --no-cache nginx openssl

# Créer répertoires
RUN mkdir -p /etc/nginx/ssl \
    && mkdir -p /run/nginx \
    && mkdir -p /var/www/html/wordpress

# Générer un certificat SSL auto-signé (exemple)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mylogin.42.fr"

# Copier config
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
