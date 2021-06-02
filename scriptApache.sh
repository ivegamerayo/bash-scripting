#!/bin/bash
clear

# INSTALACION DE LOS SERVICIOS
printf "\nInstalacion de Apache2 y FTP"
apt install apache2 vsftpd sed -y

# Introduccion de la informacion basica

printf "\nIntroduce la ruta de la carpeta raiz: "
read carpeta_raiz
mkdir $carpeta_raiz

printf "\nIntroduce el sitio: "
read empresa1

mkdir $carpeta_raiz/$empresa1

printf "\nIntroduce otro sitio: "
read empresa2

mkdir $carpeta_raiz/$empresa2

chmod -R 777 $carpeta_raiz

# Configuracion de vsftpd.conf
echo "write_enable=YES" >> /etc/vsftpd.conf
echo "local_umask=022" >> /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
systemctl restart vsftpd


# Modificacion /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

useradd -g ftp -d $carpeta_raiz/$empresa1 -m -s /usr/sbin/nologin --password 'Ponferrada2014' $empresa1
useradd -g ftp -d $carpeta_raiz/$empresa2 -m -s /usr/sbin/nologin --password 'Ponferrada2014' $empresa2

#Generar el certificado
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem

sed '149d' /etc/vsftpd.conf
sed '150d' /etc/vsftpd.conf
sed '151d' /etc/vsftpd.conf

 echo "rsa_cert_file=/etc/ssl/private/vsftpd.pem" >> /etc/vsftpd.conf
 echo "rsa_private_key_file=/etc/ssl/private/vsftpd.pem" >> /etc/vsftpd.conf
 echo "ssl_enable=YES" >> /etc/vsftpd.conf
 echo "force_local_data_ssl=YES" >> /etc/vsftpd.conf
 echo "force_local_logins_ssl=YES" >> /etc/vsftpd.conf
 echo "ssl_tlsv1=YES" >> /etc/vsftpd.conf
 echo "ssl_sslv2=NO" >> /etc/vsftpd.conf
 echo "ssl_sslv3=NO" >> /etc/vsftpd.conf


systemctl restart vsftpd


#Configuracion de apache


printf "Configurando /etc/apache2/apache2.conf"

echo "<Directory /portales>" >> /etc/apache2/apache2.conf
echo "Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf
echo "AllowOverride None" >> /etc/apache2/apache2.conf
echo "Require all granted" >> /etc/apache2/apache2.conf
echo "</Directory>" >> /etc/apache2/apache2.conf


#Generar los index
echo "Bienvenido a $empresa1" > $carpeta_raiz/$empresa1/index.html
echo "Bienvenido a $empresa2" > $carpeta_raiz/$empresa2/index.html

touch /etc/apache2/sites-available/$empresa1.conf
touch /etc/apache2/sites-available/$empresa2.conf

echo "<virtualhost *:80>" >> /etc/apache2/sites-available/$empresa1.conf
echo "ServerName www.$empresa1.es" >> /etc/apache2/sites-available/$empresa1.conf
echo "DocumentRoot $carpeta_raiz/$empresa1" >> /etc/apache2/sites-available/$empresa1.conf

echo "DirectoryIndex index.html" >> /etc/apache2/sites-available/$empresa1.conf
echo "</virtualhost>" >> /etc/apache2/sites-available/$empresa1.conf



echo "<virtualhost *:80>" >> /etc/apache2/sites-available/$empresa2.conf
echo "ServerName www.$empresa2.es" >> /etc/apache2/sites-available/$empresa2.conf
echo "DocumentRoot $carpeta_raiz/$empresa2" >> /etc/apache2/sites-available/$empresa2.conf

echo "DirectoryIndex index.html" >> /etc/apache2/sites-available/$empresa2.conf
echo "</virtualhost>" >> /etc/apache2/sites-available/$empresa2.conf

a2ensite $empresa1
a2ensite $empresa2

systemctl restart apache2
systemctl status apache2

