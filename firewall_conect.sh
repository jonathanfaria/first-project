#!/bin/bash

echo 0 > /proc/sys/net/ipv4/ip_forward

iptables -Z
iptables -F
iptables -X

iptables -P INPUT DROP

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -p icmp --icmp-type 8 -i tun1 -j ACCEPT

#iptables -A INPUT -m state --state NEW -j ACCEPT

iptables -A INPUT -p tcp -i tun1  --dport 8000 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 9111 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 8081 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 25 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 8088 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 9000 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 3810 -j ACCEPT
iptables -A INPUT -p tcp -i tun1  --dport 2677 -j ACCEPT

iptables -A INPUT -p tcp -i em1  --dport 2677 -j ACCEPT
iptables -A INPUT -p tcp -i em1  --dport 80 -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

echo 1 > /proc/sys/net/ipv4/ip_forward

