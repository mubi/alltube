FROM php:7.3-apache
RUN apt-get update && \
RUN apt-get install -y libicu-dev xz-utils git python libgmp-dev unzip ffmpeg     apt-get install -y libicu-dev xz-utils git python libgmp-dev libzip-dev unzip ffmpeg libsodium-dev && \
RUN docker-php-ext-install mbstring     docker-php-ext-install mbstring intl gmp sodium zip gettext && \
RUN docker-php-ext-install intl     rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install gmp
RUN a2enmod rewrite
RUN curl -sS https://getcomposer.org/installer | php -- --quiet
COPY resources/php.ini /usr/local/etc/php/
COPY . /var/www/html/
RUN php composer.phar check-platform-reqs --no-dev
RUN php composer.phar install --prefer-dist --no-progress --no-dev --optimize-autoloader
RUN mkdir /var/www/html/templates_c/
RUN chmod 770 -R /var/www/html/templates_c/
ENV CONVERT=1
