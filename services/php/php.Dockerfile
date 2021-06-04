FROM php:7.3-fpm

WORKDIR /app

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -yq \
        nano \
        wget \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libssh-dev \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libpq-dev \
        libxslt-dev \
        libzip-dev \
        unzip \
        openssh-server \
        openssh-client

RUN docker-php-ext-configure gd \
        && docker-php-ext-install -j$(nproc) \
        gd \
        intl \
        pdo_pgsql \
        xsl \
        zip

RUN apt-get install -yq \
        librabbitmq-dev \
        libssh-dev \
        && pecl install amqp \
        && docker-php-ext-enable amqp

RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN apt-get install -yq \
    libmcrypt-dev \
    && pecl install mcrypt \
    && docker-php-ext-enable mcrypt

COPY image-files/ /

# install composer
RUN chmod 744 /usr/local/bin/install-composer.sh && \
    /usr/local/bin/install-composer.sh && \
    mv /app/composer.phar /usr/local/bin/composer

RUN mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#RUN git clone https://github.com/symfony/demo.git /app

EXPOSE 9000

# Set permissions for entrypoint script
RUN chmod 744 /start.sh

ENTRYPOINT ["/start.sh"]