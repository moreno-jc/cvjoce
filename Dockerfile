
FROM php:7.4-apache

# Instalamos las extensiones PHP que nuestra aplicación necesita
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libpq-dev \
&& docker-php-ext-configure gd --with-jpeg \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-install pdo_pgsql

# Habilitamos mod_rewrite
RUN a2enmod rewrite

# Copiamos nuestra aplicación en el contenedor
COPY . /var/www/html

# Establecemos la propiedad de los archivos de nuestra aplicación al usuario y grupo 'www-data'
RUN chown -R www-data:www-data /var/www/html
