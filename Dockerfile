# Use the official Composer image as the base image
FROM composer:latest

# Install Laravel Installer globally
RUN composer global require laravel/installer && \
    ln -s $(composer config --global home)/vendor/bin/laravel /usr/local/bin/laravel

RUN chmod -R 1777 /tmp

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]