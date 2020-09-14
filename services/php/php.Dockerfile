FROM php:7.3-fpm

WORKDIR /app

RUN apt-get update
RUN apt-get install -yq nano wget git

RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm"]