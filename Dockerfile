FROM wordpress:fpm

# Install nginx and required packages
RUN apt-get update && apt-get install -y \
    nginx \
    wget \
    less \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configure WP-CLI to allow root without warnings
RUN mkdir -p /root/.wp-cli && \
    echo "allow-root: true" > /root/.wp-cli/config.yml

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Set optimized PHP settings for WordPress
RUN { \
    echo "memory_limit = 256M"; \
    echo "upload_max_filesize = 128M"; \
    echo "post_max_size = 128M"; \
    echo "max_execution_time = 300"; \
    echo "max_input_time = 300"; \
    echo "max_input_vars = 3000"; \
    echo ""; \
    echo "; OPcache optimization"; \
    echo "opcache.enable = 1"; \
    echo "opcache.memory_consumption = 256"; \
    echo "opcache.interned_strings_buffer = 16"; \
    echo "opcache.max_accelerated_files = 10000"; \
    echo "opcache.revalidate_freq = 60"; \
    echo "opcache.fast_shutdown = 1"; \
    echo "opcache.validate_timestamps = 0"; \
    echo ""; \
    echo "; Realpath cache optimization"; \
    echo "realpath_cache_size = 4M"; \
    echo "realpath_cache_ttl = 600"; \
    echo ""; \
    echo "; Session optimization"; \
    echo "session.cache_limiter = nocache"; \
    echo "session.gc_maxlifetime = 1440"; \
    echo ""; \
    echo "; Error logging"; \
    echo "display_errors = Off"; \
    echo "log_errors = On"; \
    echo "error_log = /var/log/php_errors.log"; \
    } > /usr/local/etc/php/conf.d/wordpress.ini

# Create startup script that runs WordPress entrypoint first
RUN echo '#!/bin/bash\n\
    set -e\n\
    \n\
    # Run WordPress docker-entrypoint script in background\n\
    docker-entrypoint.sh php-fpm &\n\
    \n\
    # Wait a moment for WordPress initialization\n\
    sleep 2\n\
    \n\
    # Start nginx in foreground\n\
    nginx -g "daemon off;"' > /start.sh && chmod +x /start.sh

# Expose port 80
EXPOSE 80

WORKDIR /var/www/html

CMD ["/start.sh"]
