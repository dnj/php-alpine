FROM ghcr.io/dnj/php-alpine:8.0-mysql-nginx

RUN (crontab -u www-data -l 2>/dev/null && echo "* * * * * /usr/local/bin/php  /var/www/artisan schedule:run > /dev/null 2>&1") | crontab -u www-data -

COPY default.conf /etc/nginx/conf.d/ 
COPY worker.ini /etc/supervisor.d/
