#!/usr/bin/env bash

# MYSQL
# user: root
# pass: as defined below
# adjust to whatever you like as a MYSQL database name
DBNAME=development
DBPASS=root

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list and upgrading system ---"
sudo apt-get update
sudo apt-get -y dist-upgrade

echo "--- Start installing ---"
sudo apt-get install -y unzip zip build-essential

# Apache
echo "--- Installing and configuring apache webserver with bleeing edge PHP FPM ---"
sudo apt-get install -y apache2

# Set server name to calm output
sudo echo "ServerName localhost" > /etc/apache2/conf-available/httpd.conf
sudo a2enconf httpd

# PHP7
sudo apt-get install python-software-properties software-properties-common
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install libapache2-mod-fastcgi php7.1 php7.1-fpm php7.1-mysql php7.1-curl php7.1-gd php7.1-intl php-pear php7.1-imap php7.1-mcrypt php7.1-ps php7.1-pspell php7.1-recode php7.1-snmp php7.1-sqlite php7.1-tidy php7.1-xmlrpc php7.1-xsl php7.1-mbstring -y

sudo a2enmod actions fastcgi alias

sudo service apache2 restart
sudo service php7.1-fpm restart

# PHP tweaks
echo "--- Let us configure good PHP defaults, my master. ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/fpm/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php/7.1/fpm/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 80M/g" /etc/php/7.1/fpm/php.ini

# Silent MySQL Install
# http://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt
echo "--- Master, it's MySQL time ---"
sudo apt-get update
sudo debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password $DBPASS"
sudo debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password $DBPASS"
sudo -E apt-get install -q -y mysql-server-5.6

# Install Adminer
echo "--- Setup adminer for mysql administration. I hope you like it, my master. ---"
wget http://www.adminer.org/latest.php
mkdir /var/www/adminer
mv latest.php /var/www/adminer/index.php
chown -R www-data: /var/www/adminer
chmod 755 /var/www/adminer/index.php

# Setup the project database
echo "--- Setup database '$DBNAME' ---"
echo "CREATE DATABASE $DBNAME;" | mysql -u root -p$DBPASS

# virtual host setup
echo "--- Setting document root for project ---"
sudo rm -rf /var/www/html
sudo ln -fs /vagrant /var/www/htdocs

# setup hosts file
VHOST=$(cat <<EOF
<IfModule mod_fastcgi.c>
    AddHandler php7-fcgi .php
    Action php7-fcgi /php7-fcgi
    Alias /php7-fcgi /usr/lib/cgi-bin/php7-fcgi
    FastCgiExternalServer /usr/lib/cgi-bin/php7-fcgi -socket /var/run/php/php7.1-fpm.sock -pass-header Authorization
</IfModule>

<VirtualHost *:80>
    DocumentRoot "/var/www/htdocs"
    <Directory "/var/www/htdocs">
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /usr/lib/cgi-bin>
        Require all granted
    </Directory>
</VirtualHost>

Listen 81

<VirtualHost *:81>
    DocumentRoot "/var/www/adminer"
    <Directory "/var/www/adminer">
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /usr/lib/cgi-bin>
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
sudo service apache2 restart

# Install git
sudo apt-get install -y git

# Clean up old packages
sudo apt-get -y autoremove

# Install Composer
echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod 755 /usr/local/bin/composer