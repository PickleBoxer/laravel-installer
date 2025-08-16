ARG COMPOSER_VERSION=latest
FROM composer:${COMPOSER_VERSION}

# Install Laravel installer globally
RUN composer global require laravel/installer

# Set working directory
WORKDIR /opt

# Add Composer global bin to PATH
ENV PATH="$PATH:$COMPOSER_HOME/vendor/bin"

# Set entrypoint to laravel command
ENTRYPOINT ["laravel"]
