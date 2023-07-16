# PHP-Alpine
PHP running on alpine base Docker Image with or without Nginx 🐳


![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/dnj/php-alpine/build-docker.yml?style=for-the-badge)
[![LICENSE](https://img.shields.io/github/license/dnj/php-alpine.svg?style=for-the-badge)](https://github.com/dnj/php-alpine/blob/master/LICENSE)
[![Stars Count](https://img.shields.io/github/stars/dnj/php-alpine.svg?style=for-the-badge)](https://github.com/dnj/php-alpine/stargazers)
[![Forks Count](https://img.shields.io/github/forks/dnj/php-alpine.svg?style=for-the-badge)](https://github.com/dnj/php-alpine/network/members)
[![Watchers Count](https://img.shields.io/github/watchers/dnj/php-alpine.svg?style=for-the-badge)](https://github.com/dnj/php-alpine/watchers)
[![Issues Count](https://img.shields.io/github/issues/dnj/php-alpine.svg?style=for-the-badge)](https://github.com/dnj/php-alpine/issues)
[![Pull Request Count](https://img.shields.io/github/issues-pr/dnj/php-alpine.svg?style=for-the-badge)](https://github.com/dnj/php-alpine/pulls)
[![Follow](https://img.shields.io/github/followers/dnj.svg?style=for-the-badge&label=Follow&maxAge=2592000)](https://github.com/dnj)

![SIZE](https://i.imgur.com/KifCewS.png)

## Pull it from Github Registry
To pull the docker image:
```bash
docker pull ghcr.io/dnj/php-alpine:8.1-mysql-nginx
```

## Usage
To run from current dir
```bash
docker run -v $(pwd):/var/www/html -p 80:80 ghcr.io/dnj/php-alpine:8.1-mysql-nginx
```

## What's Included
 - [Composer](https://getcomposer.org/) ( v2 - updated )
 - CRON
 - [Supervisor](http://supervisord.org) 

## Other Details
- Alpine base image

## PHP Extension
- opcache
- mysqli or pgsql
- pdo 
- pdo_mysql or pdo_pgsql
- sockets
- json
- intl
- gd
- xml
- zip
- bz2
- pcntl
- bcmath
- inotify
- redis
- memcached
- soap
- ssh2

## Adding other PHP Extension
You can add additional PHP Extensions by running `docker-ext-install` command. Don't forget to install necessary dependencies for required extension.
```bash
FROM ghcr.io/dnj/php-alpine:8.1-mysql-nginx
RUN docker-php-ext-install xdebug
```

## Adding CRON
```bash
FROM ghcr.io/dnj/php-alpine:8.1-mysql-nginx
echo '0 * * ? * * /usr/local/bin/php  /var/www/artisan schedule:run >> /dev/null 2>&1' > /etc/crontabs/root 
```
 
## Adding custom Supervisor config
You can add your own Supervisor config inside `/etc/supervisor.d/`. File extension needs to be `*.ini`. By default this image added `php-fpm` and `crond` process in supervisor. 

E.g: For a nodejs program you can make file `my-websocket-app.ini`
```ini
[program:my-websocket-app]
process_name=%(program_name)s
command=node /app/socket.js
autostart=true
autorestart=true
redirect_stderr=true
```
On your Docker image
```bash
FROM ghcr.io/dnj/php-alpine:latest
ADD my-websocket-app.ini /etc/supervisor.d/
```
For more details on config http://supervisord.org/configuration.html


## Bug Reporting

If you find any bugs, please report it by submitting an issue on our [issue page](https://github.com/dnj/php-alpine/issues) with a detailed explanation. Giving some screenshots would also be very helpful.

## Feature Request

You can also submit a feature request on our [issue page](https://github.com/dnj/php-alpine) or [discussions](https://github.com/dnj/php-alpine/discussions) and we will try to implement it as soon as possible.

