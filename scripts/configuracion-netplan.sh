#!/bin/bash
clear

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


#ROOT PRIVILEGIES
if [[ $EUID -ne 0 ]]; then
    echo -e "$red No estas en root.$nc"
    exit 1
fi

#Configuracion de ip estatica
echo ""
echo -e "                     $Cyan Cambio de IP"
echo ""
echo -e "$green"
echo "Introduce la direccion de red"
read -p "Ex: 172.16.100.220: Por defecto se anyade mascara 255.255.255.0: " address_principal
read -p "Introduce la gateway: " gateway
read -p "nameservers: " nameservers

echo "network:" > /etc/netplan/00-installer-config.yaml
echo " ethernets:" >> /etc/netplan/00-installer-config.yaml
echo "    enp0s3:" >> /etc/netplan/00-installer-config.yaml
echo "      dhcp4: no" >> /etc/netplan/00-installer-config.yaml
echo "      addresses: [$address_principal/24]" >> /etc/netplan/00-installer-config.yaml
echo "      gateway4: $gateway" >> /etc/netplan/00-installer-config.yaml
echo "      nameservers:" >> /etc/netplan/00-installer-config.yaml
echo "         addresses: [$nameservers]" >> /etc/netplan/00-installer-config.yaml
# echo "version: 2" >> /etc/netplan/00-installer-config.yaml

netplan apply

echo -e " 		[+]$yellow Modificado el netplan correctamente $nc[$green✓$nc] $nc[+]"