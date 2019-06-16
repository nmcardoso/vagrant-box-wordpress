#!/bin/bash

DBHOST=localhost
DBNAME=wordpress
DBUSER=root
DBPASS=root

echo -e "Iniciando Configuração do Ambiente de Desenvolvimento \n"

echo -e "Atualizando pacotes"
apt-get -qq update

echo -e "Instalando pacotes base"
apt-get -y install curl build-essential git software-properties-common tar >> vm_build.log 2>&1

echo -e "Instalando PHP 7.3"
add-apt-repository -y ppa:ondrej/php >> vm_build.log 2>&1
apt-get -qq update
apt-get -y install php7.3 >> vm_build.log 2>&1

echo -e "Instalando Apache"
apt-get -y install apache2 >> vm_build.log 2>&1

echo -e "Instalando Módulos Necessários"
apt-get -y install php-{curl,mysql,gd,gettext,bcmath,bz2,zip,intl,mbstring,mcrypt} >> vm_build.log 2>&1
apt-get -y install libapache2-mod-php >> vm_build.log 2>&1

echo -e "Instalando MySQL"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASS"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASS"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASS"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASS"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
apt-get -y install mysql-server phpmyadmin >> vm_build.log 2>&1

echo -e "Configurando MySQL"
mysql -uroot -p$DBPASS -e "CREATE DATABASE $DBNAME" >> vm_build.log 2>&1
mysql -uroot -p$DBPASS -e "grant all privileges on $DBNAME.* to '$DBUSER'@'$DBHOST' identified by '$DBPASS'" > vm_build.log 2>&1

echo -e "Configurando Apache ModRewrite"
a2enmod rewrite >> vm_build.log 2>&1

echo -e "Configurando Apache Override"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "Configurando diretório raiz do Apache"
if [ ! -d "/vagrant/wordpress" ]; then
  mkdir /vagrant/wordpress
fi
rm -rf /var/www/html
ln -fs /vagrant/wordpress /var/www/html

echo -e "Reiniciando Apache"
service apache2 restart >> vm_build.log 2>&1

echo -e "Apache, PHP e MySQL Configurados\n"

echo -e "Instalação do servidor FTP"
apt-get -y install vsftpd >> vm_build.log 2>&1

echo -e "Configurando FTP"
cp /vagrant/vsftpd.conf /etc/vsftpd.conf

echo -e "Servidor FTP Instalado e Configurado\n"
echo -e "Iniciando instalação do Wordpress"
cd /vagrant/wordpress

echo -e "Baixando Wordpress"
curl -s https://br.wordpress.org/latest-pt_BR.tar.gz --output /tmp/wp.tar.gz
tar -xzf /tmp/wp.tar.gz -C /vagrant/
rm -rf /tmp/wp.tar.gz

echo -e "Configurando Banco de Dados do Wordpress"
cp /vagrant/wp-config.php /vagrant/wordpress/wp-config.php

echo -e "Confguração Finalizada\n"
echo -e "Termine a instalação do Wordpress acessando o IP da Máquina Virtual http://192.168.33.10"

