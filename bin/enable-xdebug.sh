#!bin/bash
set -e

echo "Enabling xdebug..."

docker cp services/php/image-files/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini "$(docker-compose ps -q php)":/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

docker-compose restart php
echo ""
echo "php -i | grep xdebug"
docker-compose exec php bash -c "php -i | grep xdebug"
echo ""
