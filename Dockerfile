FROM composer:1 as BUILDER

COPY composer.json /app
WORKDIR /app
RUN echo `composer install --no-dev --optimize-autoloader`

FROM php:7.1-fpm

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/symfony

COPY --from=BUILDER /app/vendor vendor
COPY --from=BUILDER /app/var var
COPY assets assets
COPY bin bin
COPY config config
COPY public public
COPY src src
COPY templates templates
COPY translations translations
COPY .env.prod .env
COPY .php_cs.dist .php_cs.dist
COPY composer.json composer.json
