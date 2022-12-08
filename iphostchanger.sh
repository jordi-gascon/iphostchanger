#!/bin/bash
# Autor: Jordi Gascón
# Versión 1.1 fecha de creación 18/11/22 fecha de revisión 19/11/22
# Script para cambiar IP y nombe del host en versiones Ubuntu 20.04 y 22.04
# Comprobar el nombre del interfaz y hacer cambio si es necesario

echo "  _           _                     _            _                                            "
echo " (_)  _ __   | |__     ___    ___  | |_    ___  | |__     __ _   _ __     __ _    ___   _ __  "
echo " | | |  _ \  |  _ \   / _ \  / __| | __|  / __| |  _ \   / _  | |  _ \   / _  |  / _ \ |  __| "
echo " | | | |_) | | | | | | (_) | \__ \ | |_  | (__  | | | | | (_| | | | | | | (_| | |  __/ | |    "
echo " |_| | .__/  |_| |_|  \___/  |___/  \__|  \___| |_| |_|  \__,_| |_| |_|  \__, |  \___| |_|    "
echo "     |_|                                                                 |___/                "
echo "Autor: Jordi Gascon"
echo "V1.1 -- 19/11/22  ----  Compatible con Ubuntu 20.04 y 22.04"
echo "Cambia la IP y el host de tus máquinas clonadas en pocos segundos"
echo "##############################################################################################"


#VARIABLES DEFAULT##########################################
interf=enp0s3 #interfaz por defecto enp0s3
defGateway=192.168.1.1
defHostname=$(hostnamectl|grep hostname|cut -c19-50)

#PREGUNTA SI EL INTERFAZ POR DEFECTO ES enp0s3. EN CASO AFIRMATIVO PRESIONAR ENTER
#SI NO LO ES INTRODUCIR "n" Y ESCRIBIR EL NOMBRE DEL INTERFAZ
echo "Tu interfaz es $interf ? (Y/n)"
read changeInter
if [ "$changeInter" == "n" ];
        then
        ip a
        echo "Escribe el interfaz: "
        read interf
fi

#SOLICITA EL NUEVO NOMBRE DE HOST. EN CASO DE NO QUERERLO CAMBIAR PRESIONAR ENTER
echo "Escribe nuevo hostname (por defecto $defHostname)"
read newHostname
if [ "$newHostname" != "$defHostname" ] && [ "$newHostname" != "" ];
        then
        defHostname=$newHostname
        hostnamectl set-hostname $defHostname
        hostnamectl | grep hostname
fi

#SOLICITA LA NUEVA IP. ESCRIBIR IP QUE SE QUIERE ESTABLECER COMO NUEVA
echo "Escribe nueva IP"
read newIP

#SOLICITA GATEWAY POR SI FUERA NECESARIO CAMBIARLO.
#SI NO SE QUIERE CAMBIAR PRESIONAR ENTER
echo "Escribe Gateway (por defecto 192.168.1.1)"
read newGateway

if [ "$newGateway" != "$defGateway" ] && [ "$newGateway" != "" ];
        then
        defGateway=$newGateway
fi

#REEMPLAZA EL ARCHIVO YAML CON LOS NUEVOS VALORES
ruta=/etc/netplan/00-installer-config.yaml

echo -e "network:" > $ruta
echo -e "  ethernets:" >> $ruta
echo -e "    $interf:" >> $ruta
echo -e "      addresses:" >> $ruta
echo -e "      - $newIP/24" >> $ruta
echo -e "      gateway4: $defGateway" >> $ruta
echo -e "      nameservers:" >> $ruta
echo -e "        addresses:" >> $ruta
echo -e "        - $defGateway" >> $ruta
echo -e "        search: []" >> $ruta
echo -e "  version: 2" >> $ruta

#INFORMA DE LOS CAMBIOS REALIZADOS Y FINALIZA
echo "IP cambiada a $newIP"
echo "Hostname cambiado a $defHostname"
echo "Cierra sesión e inicia con la nueva IP"
sleep 2
netplan apply 2>/dev/null

#cat $ruta #linea para debuging