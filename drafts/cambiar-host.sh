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


echo -e "                    $Cyan Cambiar el nombre del host$nc"
echo -e "$green"
read -p "Introduce el nombre del host: " host
echo -e "$white"
sudo hostnamectl set-hostname $host
echo ""
echo -e " 		[+]$yellow Cambio de usuario completado $nc[$green✓$nc] $nc[+]"