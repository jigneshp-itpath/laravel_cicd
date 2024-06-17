#!/bin/sh
set -e

echo "Deploying application ..."

# Enter maintenance mode
php artisan down

rm -R -F vendor

# Install dependencies based on lock file
composer install --no-interaction --prefer-dist --optimize-autoloader
# cp server.php index.php

# Update codebase
git fetch origin main
git reset --hard origin/main

# Migrate database
# php artisan migrate --force

# Note: If you're using queue workers, this is the place to restart them.
# ...

# Permission given
chmod 777 -R storage bootstrap

# Clear cache
php artisan optimize

# Reload PHP to update opcache
# echo "" | sudo -S service php7.4-fpm reload    

# Exit maintenance mode
php artisan up

echo "Application deployed!"
