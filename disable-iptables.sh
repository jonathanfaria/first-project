#!/bin/bash
sudo service iptables stop
sudo chkconfig iptables off
sudo service iptables status
sudo service ip6tables stop
sudo chkconfig ip6tables off
sudo service ip6tables status