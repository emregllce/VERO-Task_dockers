FROM php:8.1-apache-bullseye

 # Set the working directory to the web root
WORKDIR /var/www/html

ENV ACCEPT_EULA=Y

# Install MS ODBC Driver for SQL Server
RUN apt-get update && apt-get install -y gnupg sudo && \
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/debian/11/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && apt-get install -y unixodbc-dev
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18
RUN pecl channel-update pecl.php.net
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

# Restart Apache to apply the changes
RUN service apache2 restart

# Copy QuickDbTest.php script to the web root
COPY QuickDbTest.php /var/www/html/

# Copy info.php script to the web root so we can see the installed PDO drivers etc.
COPY index.html /var/www/html/
COPY info.php /var/www/html/

# Expose port 80 for the web server
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
