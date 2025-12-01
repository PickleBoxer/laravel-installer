# Use stable Composer 2.x as base image
FROM composer:2

# Laravel Installer version to install
ARG INSTALLER_VERSION=latest

# OCI Labels for metadata
LABEL org.opencontainers.image.title="Laravel Installer"
LABEL org.opencontainers.image.description="Docker image for Laravel Installer - create Laravel projects without local PHP/Composer"
LABEL org.opencontainers.image.vendor="PickleBoxer"
LABEL org.opencontainers.image.source="https://github.com/PickleBoxer/laravel-installer"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version="${INSTALLER_VERSION}"

# Install specific Laravel installer version globally
RUN composer global require laravel/installer:${INSTALLER_VERSION}

# Set working directory for project creation
WORKDIR /opt

# Add Composer global bin to PATH
ENV PATH="$PATH:$COMPOSER_HOME/vendor/bin"

# Set entrypoint to laravel command
ENTRYPOINT ["laravel"]
