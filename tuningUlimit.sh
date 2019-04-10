#!/bin/bash
sudo sh -c "echo -e '* soft    nofile  1024\n' >> /etc/security/limits.conf"
sudo sh -c "echo -e '* hard    nofile  65535\n' >> /etc/security/limits.conf"
sudo sh -c "echo -e 'sesssion required /lib64/security/pam_limits.so\n' >> /etc/pam.d/login"
sudo sh -c "echo -e 'fs.file-max = 65535\n' >> /etc/sysctl.conf"
sudo sysctl -p
cat /proc/sys/fs/file-max
ulimit -n -H
