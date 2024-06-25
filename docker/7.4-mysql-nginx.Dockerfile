FROM php:7.4-fpm-alpine3.16

WORKDIR /var/www
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="/var/www/vendor/bin:$PATH"

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  \
        zlib-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxpm-dev \
        libavif-dev \
        libxml2-dev \
        bzip2-dev \
        libmemcached-dev \
        libssh2-dev \
        libzip-dev \
        freetype-dev \
        gmp-dev \
        curl-dev && \
    apk add --update --no-cache \
        libpng \
        libwebp \
        libxpm \
        libavif \
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
        exif \
        dom \
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
    docker-php-ext-configure gd --with-jpeg --with-webp --with-xpm --with-avif --with-freetype && \
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
        exif \
        dom \
        bcmath && \
    pecl install memcached-3.1.5 && \
    pecl install -a ssh2-1.3.1 && \
    docker-php-ext-enable \
        memcached \
        exif \
        dom \
        redis \
        ssh2 \
        inotify && \
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk del --no-network .build-deps && \
    mkdir -p /run/php /run/nginx && \
    ln -s /dev/stdout /var/log/nginx/access.log && \
    ln -s /dev/stderr /var/log/nginx/error.log


COPY supervisor/master.ini /etc/supervisor.d/
COPY nginx/default.conf /etc/nginx/http.d/ 
COPY nginx/default.conf.d /etc/nginx/conf.d/default.conf.d
COPY php/opcache.ini $PHP_INI_DIR/conf.d/
COPY php/php.ini $PHP_INI_DIR/conf.d/
COPY php/www.conf php/zz-docker.conf /usr/local/etc/php-fpm.d/

CMD ["/usr/bin/supervisord"]
