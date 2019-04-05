FROM directus/api:latest

RUN apk add --no-cache \
    nginx \
    php7 \
    php7-fpm \
    php7-curl \
    php7-dom \
    php7-exif \
    php7-fileinfo \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-redis \
    php7-session \
    php7-xml \
    php7-zip \
    php7-zlib \
    php7-imagick \
    php7-phar \
    php7-simplexml \
	php7-xmlwriter \
    php7-tokenizer \
    git \
	imagemagick

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --filename=composer &&\
    php -r "unlink('composer-setup.php');"

WORKDIR /var/www/html

RUN php /composer require league/flysystem-aws-s3-v3

ENTRYPOINT ["/init"]
CMD []
