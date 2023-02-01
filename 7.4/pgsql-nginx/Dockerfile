FROM php:7.4-fpm-alpine3.14

WORKDIR /var/www
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="/var/www/vendor/bin:$PATH"

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  \
        zlib-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
        bzip2-dev \
        libmemcached-dev \
        libssh2-dev \
        libzip-dev \
        freetype-dev \
        gmp-dev \
        curl-dev && \
    apk add --update --no-cache \
        jpegoptim \
        pngquant \
        optipng \
        supervisor \
        nano \
        icu-dev \
        freetype \
        nginx \
        postgresql-dev \
        libmemcached \
        libssh2 \
        zip \
        curl \
        libxml2 \
        libzip \
        gmp \
        bzip2 && \
    pecl install inotify && \
    docker-php-ext-configure opcache --enable-opcache &&\
    docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install \
        opcache \
        pdo \
        pdo_pgsql \
        pgsql \
        sockets \
        intl \
        gd \
        xml \
        bz2 \
        pcntl \
        bcmath \
        zip \
        soap \
        gmp \
        bcmath && \
    pecl install memcached-3.1.5 && \
    pecl install -a ssh2-1.3.1 && \
    docker-php-ext-enable \
        memcached \
        ssh2 \
        inotify && \
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk del --no-network .build-deps && \
    mkdir -p /run/php


COPY master.ini /etc/supervisor.d/
COPY default.conf /etc/nginx/conf.d/ 
COPY opcache.ini $PHP_INI_DIR/conf.d/
COPY php.ini $PHP_INI_DIR/conf.d/
COPY www.conf zz-docker.conf /usr/local/etc/php-fpm.d/

CMD ["/usr/bin/supervisord"]
