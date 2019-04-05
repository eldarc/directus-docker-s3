FROM directus/api:latest
#https://github.com/directus/api/issues/718#issuecomment-457371997

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
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --filename=composer &&\
    php -r "unlink('composer-setup.php');"

WORKDIR /var/www/html

RUN php /composer require league/flysystem-aws-s3-v3

ENTRYPOINT ["/init"]
CMD []
