#!/bin/bash

# Rede interna
SERVER03=192.168.1.1
SERVER02=192.168.1.2
SERVER01=192.168.1.100
LAN=192.168.1.0/24


# Internet
DIP=10.0.3.15
WAN=10.0.3.0/24

# Habilita o passagem de pacotes
echo 1 > /proc/sys/net/ipv4/ip_forward

# Politicas padroes do firewall
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# Limpa todas chains
iptables -t nat -F
iptables -t filter -F

# Limpa as chains de usuarios
iptables -X

# Zera os contadores do iptables
iptables -Z


###################
### NAT SESSION ###
###################

# 1 - Habilita o acesso a internet para LAN
iptables -t nat -A POSTROUTING -s $LAN -o enp0s8 -j MASQUERADE


if [ $? == 0 ] ; then 
  service iptables save
  mkdir -p /etc/firewall
  iptables-save > /etc/firewall/firewall.sh
fi
