#!/bin/sh
set -e

echo "Deploying application ..."

# Enter maintenance mode
php artisan down

echo "copy files start ..."
cp server.php index.php
echo "copy files end ..."

# Update codebase
git fetch origin main
git reset --hard origin/main

# Install dependencies based on lock file
composer install --no-interaction --prefer-dist --optimize-autoloader

# Migrate database
# php artisan migrate --force

# Note: If you're using queue workers, this is the place to restart them.
# ...

# Permission given
chmod 777 -R storage/
chmod 777 -R bootstrap/

# Clear cache
php artisan optimize

# Reload PHP to update opcache
# echo "" | sudo -S service php7.4-fpm reload    

# Exit maintenance mode
php artisan up

echo "Application deployed!"
