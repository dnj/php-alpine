FROM php:8.1-cli-alpine3.16

WORKDIR /var/www
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="/var/www/vendor/bin:$PATH"

RUN --mount=type=bind,source=fs,target=/mnt apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  \
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
        nano \
        icu-dev \
        freetype \
        libmemcached \
        postgresql-dev \
        libssh2 \
        zip \
        curl \
        libxml2 \
        libzip \
        gmp \
        linux-headers \
        bzip2 && \
    pecl install inotify && \
    pecl install redis-6.0.2 && \
    docker-php-ext-configure opcache --enable-opcache &&\
    docker-php-ext-configure gd --with-jpeg --with-webp --with-xpm --with-avif --with-freetype && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install \
        opcache \
        pdo \
        pdo_pgsql \
        pgsql \
        sockets \
        intl \
        gd \
        exif \
        xml \
        bz2 \
        pcntl \
        bcmath \
        zip \
        soap \
        gmp \
        bcmath && \
    pecl install memcached-3.2.0 && \
    pecl install -a ssh2-1.4.1 && \
    docker-php-ext-enable \
        memcached \
        exif \
        redis \
        ssh2 \
        inotify && \
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk del --no-network .build-deps && \
    mkdir -p /run/php && \
    cp -v /mnt/usr/local/etc/php/php.ini /usr/local/etc/php/php.ini && \
    cp -v /mnt/usr/local/etc/php/conf.d/* /usr/local/etc/php/conf.d/

CMD ["/usr/bin/php"]
