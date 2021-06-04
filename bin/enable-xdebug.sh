#!bin/bash
set -e

echo "Enabling xdebug..."

docker-compose exec php bash -c "mkdir -p /app/var/log/ && chmod 755 /app/var/log/ && chmod g+s /app/var/log"
docker cp services/php/image-files/usr/local/docker-php-ext-xdebug-enabled.ini "$(docker-compose ps -q php)":/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

docker-compose restart php
echo ""
docker-compose exec php bash -c "php -r \"xdebug_info();\""
echo ""
docker-compose exec php bash -c "export"
echo ""
