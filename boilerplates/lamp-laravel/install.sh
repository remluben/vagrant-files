#!/usr/bin/env bash

# adjust to whatever you like as a MYSQL root password
# adjust to whatever you like as a MYSQL database name
DBPASSWD=root
DBNAME=development

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- We want the bleeding edge of PHP, right master? ---"
sudo add-apt-repository ppa:ondrej/php5-5.6

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- MySQL time ---"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

echo "\n--- Installing the phpmyadmin for easier MYSQL database access. It will save you time master. ---\n"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
sudo apt-get -y install mysql-server-5.5 phpmyadmin

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql git-core

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite

echo "--- Setting document root ---"
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www

sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\//" /etc/apache2/sites-available/000-default.conf

echo "--- What developer codes without errors turned on? Not you, master. ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

echo "--- Allowing .htaccess overrides. You will need it master. ---"
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "\n--- Configuring Apache webserver to use phpmyadmin ---\n"
echo "Listen 81" >> /etc/apache2/ports.conf

cat > /etc/apache2/conf-available/phpmyadmin.conf << "EOF"
<VirtualHost *:81>
    ServerAdmin webmaster@localhost
    DocumentRoot /usr/share/phpmyadmin
    DirectoryIndex index.php
    ErrorLog ${APACHE_LOG_DIR}/phpmyadmin-error.log
    CustomLog ${APACHE_LOG_DIR}/phpmyadmin-access.log combined
</VirtualHost>
EOF
sudo a2enconf phpmyadmin

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Setup database $DBNAME ---"
echo "CREATE DATABASE $DBNAME;" | mysql -u root -p$DBPASSWD

echo "--- We need laravel installed for out laravel project. Don't we? ---"
composer create-project laravel/laravel /vagrant/laravel --prefer-dist
cd /vagrant/laravel
mv * .[^.]* ..
cd ..
rm -r laravel
sudo chmod -R 777 /vagrant/storage/

echo "--- Start setting up environment specific configuration values for our laravel application. ---"
echo "--- Frist, set laravel database credentials. ---"

sed -i "s/DB_DATABASE=homestead/DB_DATABASE=$DBNAME/" /vagrant/.env
sed -i "s/DB_USERNAME=homestead/DB_USERNAME=root/" /vagrant/.env
sed -i "s/DB_PASSWORD=secret/DB_PASSWORD=$DBPASSWD/" /vagrant/.env

echo "--- All set to go! Would you like to play a game? ---"
