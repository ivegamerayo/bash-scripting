#!/bin/bash
#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
nc="\e[0m"

#Configuracion de ip estatica
#ROOT PRIVILEGIES
if [[ $EUID -ne 0 ]]; then
    echo -e "$red No estas en root.$nc"
    exit 1
fi
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