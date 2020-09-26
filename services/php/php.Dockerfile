FROM php:7.3-fpm

COPY image-files/ /

WORKDIR /app

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -yq nano wget git

RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

EXPOSE 9000

CMD ["php-fpm"]