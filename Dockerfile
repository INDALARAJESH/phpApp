# Use the official PHP base image with Apache
FROM php:7.4-apache

# Install required PHP extensions and utilities
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev\
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the Laravel application files to the working directory
COPY . /var/www/html
RUN chmod a+rwx -R /var/www/html

WORKDIR /var/www/html/application
# Install Composer and dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install gd
# RUN COMPOSER_ALLOW_SUPERUSER=1 composer update --no-scripts --no-autoloader
RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-scripts --no-autoloader

# Copy MySQL script files to a temporary directory
# COPY database/sql_scripts/ /tmp/sql_scripts/

# Copy the .env file
COPY /application/.env /application/.env

# Install MySQL client
# RUN apt-get install -y default-mysql-client

# # Add a script to the container's entrypoint to load SQL scripts into MySQL during startup
# RUN echo 'mysql --user=$DB_USERNAME --password=$DB_PASSWORD --host=$DB_HOST --port=$DB_PORT --database=$DB_DATABASE < /tmp/sql_scripts/crm.sql' >> /usr/local/bin/docker-entrypoint.sh
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh


# Generate Laravel application key
# RUN php artisan key:generate

WORKDIR /var/www/html/

# Expose the container port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
