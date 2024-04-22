FROM php:8.1-apache
RUN apt-get update && apt-get install -y gnupg2
ENV ACCEPT_EULA=Y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && apt-get install -y \
    unixodbc-dev \
    unixodbc \
    msodbcsql17
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv
EXPOSE 80

# COPY . /app
COPY ./QuickDbTest.php /var/www/html

# CMD [ "php", "./QuickDbTest.php" ] 
CMD php ./QuickDbTest.php




