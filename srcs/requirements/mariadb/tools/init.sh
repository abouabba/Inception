#!/bin/bash
# set -e

# mkdir -p /run/mysqld
# chown -R mysql:mysql /run/mysqld /var/lib/mysql

# service mariadb start

# until mariadb-admin ping --silent; do
#     sleep 1
# done

# mariadb <<EOF
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

# CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

# FLUSH PRIVILEGES;
# EOF

# mysqladmin shutdown

# exec mariadbd --user=mysql



set -e

mkdir -p /run/mysqld

chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db \
        --user=mysql \
        --datadir=/var/lib/mysql
fi

echo "Starting MariaDB..."

service mariadb start

until mariadb-admin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 1
done

echo "MariaDB is ready!"

mariadb <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

mysqladmin shutdown

exec mariadbd --user=mysql