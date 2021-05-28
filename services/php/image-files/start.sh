#!/bin/sh

# Start up the ssh server
echo "Starting sshd..."
  /usr/sbin/sshd -p 18022

# Start php-fpm
echo "Starting php-fpm..."
php-fpm