#!/bin/bash

DBHOST=localhost
DBNAME=wordpress
DBUSER=root
DBPASS=root

echo -e "Iniciando Configuração do Ambiente de Desenvolvimento \n"

echo -e "Atualizando pacotes"
sudo apt-get -qq update

echo -e "Instalando pacotes base"
sudo apt-get -y install curl build-essential git software-properties-common tar >> vm_build.log 2>&1

echo -e "Instalando PHP 7.4"
sudo add-apt-repository -y ppa:ondrej/php >> vm_build.log 2>&1
sudo apt-get -qq update
sudo apt-get -y install php7.4 >> vm_build.log 2>&1

echo -e "Instalando Apache"
sudo apt-get -y install apache2 >> vm_build.log 2>&1

echo -e "Instalando Módulos Necessários"
sudo apt-get -y install php7.4-{curl,mysql,gd,gettext,bcmath,bz2,zip,intl,mbstring,mcrypt} >> vm_build.log 2>&1
sudo apt-get -y install libapache2-mod-php >> vm_build.log 2>&1

echo -e "Instalando MySQL"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASS"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
sudo apt-get -y install mysql-server phpmyadmin >> vm_build.log 2>&1

echo -e "Configurando MySQL"
mysql -uroot -p$DBPASS -e "CREATE DATABASE $DBNAME" >> vm_build.log 2>&1
mysql -uroot -p$DBPASS -e "grant all privileges on $DBNAME.* to '$DBUSER'@'$DBHOST' identified by '$DBPASS'" > vm_build.log 2>&1

echo -e "Configurando Apache ModRewrite"
sudo a2enmod rewrite >> vm_build.log 2>&1

echo -e "Configurando Apache Override"
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "Configurando diretório raiz do Apache"
sudo sed -i 's;DocumentRoot /var/www/html;DocumentRoot /var/www/html/wordpress;' /etc/apache2/sites-enabled/000-default.conf

echo -e "Configurando Apache Usuário e Grupo"
sudo cp /vagrant/config/envvars /etc/apache2/

echo -e "Reiniciando Apache"
sudo service apache2 restart >> vm_build.log 2>&1

echo -e "Apache, PHP e MySQL Configurados\n"

echo -e "Iniciando instalação do Wordpress"
if [ ! -d "/vagrant/wordpress" ]; then
  mkdir /vagrant/wordpress
fi
cd /vagrant/wordpress

echo -e "Baixando Wordpress"
curl -s https://br.wordpress.org/latest-pt_BR.tar.gz --output /tmp/wp.tar.gz
tar -xzf /tmp/wp.tar.gz -C /vagrant/
rm -rf /tmp/wp.tar.gz

echo -e "Configurando Banco de Dados do Wordpress"
cp /vagrant/config/wp-config.php /vagrant/wordpress/wp-config.php

echo -e "Criando links simbólicos"
sudo ln -fs /vagrant/wordpress /var/www/html/
sudo ln -fs /vagrant/splus-theme /var/www/html/wordpress/wp-content/themes/

echo -e "Confguração Finalizada\n"
echo -e "Termine a instalação do Wordpress acessando o IP da Máquina Virtual"

