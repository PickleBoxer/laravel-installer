# Use the official Composer image as the base image
FROM composer:latest

# Define build argument for Laravel Installer version
ARG LARAVEL_INSTALLER_VERSION=latest

# Install Laravel Installer globally
RUN composer global require laravel/installer:${LARAVEL_INSTALLER_VERSION} && \
    ln -s $(composer config --global home)/vendor/bin/laravel /usr/local/bin/laravel && \
    composer clear-cache

RUN chmod -R 1777 /tmp

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]