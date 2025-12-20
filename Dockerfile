# All-in-one WordPress container with Nginx, PHP-FPM, and WP-CLI
FROM wordpress:fpm-alpine

# Install Nginx and Supervisor
RUN apk add --no-cache \
    nginx \
    supervisor \
    bash \
    less \
    mysql-client \
    curl

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Create necessary directories
RUN mkdir -p /var/log/supervisor \
    /run/nginx \
    /var/cache/nginx \
    /var/log/nginx

# Copy configurations
COPY config/nginx.conf /etc/nginx/http.d/default.conf
COPY config/php.ini /usr/local/etc/php/conf.d/custom-php.ini
COPY config/supervisord.conf /etc/supervisord.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chown -R www-data:www-data /var/cache/nginx

# Expose HTTP port
EXPOSE 80

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
