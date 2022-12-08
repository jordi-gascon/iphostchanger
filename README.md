![Logo](https://github.com/jordi-gascon/iphostchanger/blob/main/img/iphostchanger.png?raw=true)


# iphostchanger

Este pequeño script está diseñado y pesnado para hacer cambio de IP y de nombre del host en máquinas virtuales clonadas o que son plantillas y al desplegarlas necesitas cambiar sus direcciones IP o nombres de host.\
**SOLO COMPATIBLE CON UBUNTU 20.04 Y 22.04**


## Autor

- [@jordi-gascon](https://www.github.com/jordi-gascon)


## License

[MIT](https://choosealicense.com/licenses/mit/)


## Usage/Examples

```bash
# chmod +x iphostchanger
# ./iphostchanger
```
Primera pregunta. Por default "y". 

```bash
# Tu interfaz es enp0s3 ? (Y/n)
```
Si se presiona enter salta a la siguiente pregunta.
Si se presiona "n" te imprime los interfaces de red disponibles
```bash
Tu interfaz es enp0s3 ? (Y/n)
n
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether f2:3c:93:ca:b6:b3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.23/24 brd 139.162.156.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 2a01:7e01::f03c:93ff:feca:b6b3/64 scope global dynamic mngtmpaddr noprefixroute
       valid_lft 5200sec preferred_lft 1600sec
    inet6 fe80::f03c:93ff:feca:b6b3/64 scope link
       valid_lft forever preferred_lft forever

Escribe el interfaz:
eth0
```
En este ejemplo, escribo "eth0" \
A continuación nos pedirá en nombre del host. Nos mostrará el nombre por defecto.\
Si presionamos [ENTER] dejará el mismo. 
```bash
# Escribe nuevo hostname (por defecto ubserver)
nuevohost
```
Automáticamente nos responde con el nuevo nombre de host seteado
```bash
hostname: nuevohost
 ```
Seguidamente nos pide la nueva dirección IP
```bash
Escribe nueva IP
192.168.1.100
```
Seguidamente nos pide la direccion IP del GATEWAY\
Si presionamos [ENTER] dejará la default.\
Si queremos cambiarla, introducimos la nueva

```bash
Escribe Gateway (por defecto 192.168.1.1)
```
Finalmente, se realiza el cambio y nos muestra los datos modificados
```bash
IP cambiada a 192.168.1.100
Hostname cambiado a nuevohost
Cierra sesión e inicia con la nueva IP

```
Aquí ya podemos salir de la sesión SSH y volver a iniciar sesión con la nueva IP
