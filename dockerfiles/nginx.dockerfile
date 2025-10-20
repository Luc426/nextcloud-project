FROM nginx:alpine

# Donner accès aux répertoires nécessaires
RUN mkdir -p /var/cache/nginx /var/log/nginx \
    && chown -R nginx:nginx /var/cache/nginx /var/log/nginx /usr/share/nginx/html

USER nginx

CMD ["nginx", "-g", "daemon off;"]