#!/bin/bash
sudo sh -c "sed -i 's/IPV6INIT\=\"yes\"/IPV6INIT\=\"no\"/g' /etc/sysconfig/network-scripts/ifcfg-eth0"
sudo sh -c "echo -e 'net.ipv6.conf.all.disable_ipv6 = 1\n' >> /etc/sysctl.conf"
sudo sh -c "echo -e 'NETWORKING_IPV6=no\n' >> /etc/sysconfig/network"
