#!/bin/bash
lsblk
read -p "Introduce un disco a formatear: " disco
read -p "Introduce donde lo quieres montar: " montar_disco

(echo n;
    echo p;
    echo 1;
    echo ;
    echo ;
echo w;) | fdisk $disco

mkfs.ext4 ${disco}1

mkdir $montar_disco


fstab=/etc/fstab

    echo "${disco}1 $montar_disco ext4 defaults 0 0" >> /etc/fstab


mount -a
lsblk