FROM php:7.4-fpm

LABEL maintainer="Andrian Putra Ramadan <ramadanandrian89@gmail.com>"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

WORKDIR /var/www

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user
RUN groupadd -g 1000 laraveluser && useradd -u 1000 -g laraveluser -m -s /bin/bash laraveluser

RUN chown -R laraveluser:laraveluser .

USER laraveluser




