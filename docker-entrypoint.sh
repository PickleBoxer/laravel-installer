#!/bin/sh

if [ -z "$1" ]; then
    PROJECT_NAME="example-app"
else
    PROJECT_NAME="$1"
fi

laravel new "$PROJECT_NAME"
cd "$PROJECT_NAME"
php artisan sail:install