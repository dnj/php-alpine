FROM php:8.2-fpm-alpine3.16

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
        mysql-client \
        libmemcached \
        libssh2 \
        zip \
        curl \
        libxml2 \
        libzip \
        gmp \
        linux-headers \
        bzip2 && \
    pecl install inotify && \
    pecl install redis-5.3.7 && \
    docker-php-ext-configure opcache --enable-opcache &&\
    docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && \
    docker-php-ext-install \
        opcache \
        mysqli \
        pdo \
        pdo_mysql \
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
        redis \
        ssh2 \
        inotify && \
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk del --no-network .build-deps && \
    mkdir -p /run/php


COPY supervisor/master.ini /etc/supervisor.d/
COPY nginx/default.conf /etc/nginx/http.d/ 
COPY nginx/default.conf.d /etc/nginx/conf.d/
COPY php/opcache.ini $PHP_INI_DIR/conf.d/
COPY php/php.ini $PHP_INI_DIR/conf.d/
COPY php/www.conf php/zz-docker.conf /usr/local/etc/php-fpm.d/

CMD ["/usr/bin/supervisord"]
