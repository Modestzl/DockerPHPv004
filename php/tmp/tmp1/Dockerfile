# syntax=docker/dockerfile:1

# ---- Этап 1: Базовый образ с PHP и расширениями ----
FROM php:8.2-fpm-bookworm AS php-base

# Устанавливаем расширения через удобную утилиту
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions opcache pdo_mysql zip bcmath intl

# ---- Этап 2: Сборка зависимостей Composer ----
FROM php-base AS vendor

# Копируем Composer из официального образа
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем только файлы, описывающие зависимости (важно для кэша!)
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --no-autoloader --no-scripts

# ---- Этап 3: Финальный образ ----
FROM php-base AS final

# Копируем готовые vendor зависимости с предыдущего этапа
COPY --from=vendor --chown=www-data:www-data /app/vendor /var/www/html/vendor

# Копируем код приложения (меняется чаще всего, поэтому в самом конце)
COPY --chown=www-data:www-data ../.. /var/www/html

# Копируем пользовательский php.ini, если нужно
COPY php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html

USER www-data