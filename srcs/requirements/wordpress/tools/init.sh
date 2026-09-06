#!/bin/bash
set -e

mkdir -p /var/www/html
cd /var/www/html

echo "Waiting for MariaDB..."

until mysqladmin ping \
    -h "$MARIADB_SERVICE" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    --silent
do
    echo "MariaDB is not ready yet..."
    sleep 2
done

echo "MariaDB is ready!"

if [ ! -f wp-config.php ]; then

    wp core download --allow-root

    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MARIADB_SERVICE"

    wp core install \
        --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    wp user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
fi

exec php-fpm8.2 -F