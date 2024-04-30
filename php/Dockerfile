FROM php:8.1-apache

RUN apt-get update && apt-get install -y gnupg2


# Install Microsoft SQL Server

ENV ACCEPT_EULA=Y

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Update package lists and install dependencies
RUN apt-get update && apt-get install -y \
    unixodbc-dev \
    unixodbc \
    msodbcsql17

# Install pdo_sqlsrv extension
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv
# Copy your PHP application files
COPY ./app /var/www/html/
WORKDIR /var/www/html