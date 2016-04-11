#!/bin/bash
#Basic ubuntu script to setup developement enviroment for #Idempiere, #drupal, #Ionic

#Written by Eyog Yvon Léonce
clear
echo '#------------------------------------#'
echo '#   EYL Ubuntu Development Enviroment configuration Script  #'
echo '#------------------------------------#'
echo ''

echo 'Installing development tools'
echo ''
#add repositories
echo 'Adding repositories'
sudo add-apt-repository -y ppa:webupd8team/java

#Basic update
echo 'Updating...'
sudo apt-get update


#install java
sudo apt-get install python-software-properties default-jre default-jdk openjdk-7-jre openjdk-7-jdk oracle-java6-installer oracle-java7-installer oracle-java8-installer oracle-java7-set-default mysql-server libapache2-mod-auth-mysql php5-mysql php5 libapache2-mod-php5 php5-mcrypt php5-xdebug php5-curl php5-cgi php5-dev php5-cli postgresql postgresql-contrib libpg-java pgadmin3 git mercurial phpmyadmin -y --force-yes
clear
#configure mysql
echo 'Mysql config ...'
sudo mysql_install_db;sudo /usr/bin/mysql_secure_installation
echo 'End Mysql config ...'
#install phpmyadmin
echo 'phpmyadmin config ...'
sudo php5enmod mcrypt
sudo service apache2 restart
echo 'Include /etc/phpmyadmin/apache.conf' >>/etc/apache2/apache2.conf

#configure postgres

echo 'Postgres password'
sudo -u postgres psql postgres -c "\password postgres"
sudo -u postgres psql postgres -c "CREATE EXTENSION adminpack"
sed -i 's/local   all             postgres                                peer/local   all             postgres                                md5/' /etc/postgresql/9.3/main/pg_hba.conf

sudo /etc/init.d/postgresql reload
#configure php5
echo 'Php5 config ...'
sed -i 's/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf

cat Xdebug >> /etc/php5/cli/php.ini

echo 'restarting apache server'
sudo service apache2 restart
echo 'Configuration done. You can now start programming!!!'




