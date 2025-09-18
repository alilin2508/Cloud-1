#!/bin/sh
set -e

cd "${WP_PATH}"

# Wait until DB is reachable
echo "Waiting for database at ${DB_HOST}..."
until mysqladmin ping -h"${DB_HOST%%:*}" -u"${DB_USER}" -p"${DB_PASSWORD}" --silent; do
  sleep 2
done

# Create wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
  echo "Creating wp-config.php..."
  wp config create \
    --dbname="${DB_NAME}" \
    --dbuser="${DB_USER}" \
    --dbpass="${DB_PASSWORD}" \
    --dbhost="${DB_HOST}"
fi

# Install WordPress if not installed
if ! wp core is-installed; then
  echo "Installing WordPress..."
  wp core install \
    --url="${DOMAIN_NAME}" \
    --title="Inception" \
    --admin_name="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASS}" \
    --admin_email="${WP_ADMIN_MAIL}"
fi

# Create additional user if not exists
if ! wp user get "${WP_USER}" >/dev/null 2>&1; then
  wp user create "${WP_USER}" "${WP_USER_MAIL}" \
    --user_pass="${WP_USER_PASS}" \
    --role=editor
fi

# Start PHP-FPM in foreground
exec php-fpm8 -F
