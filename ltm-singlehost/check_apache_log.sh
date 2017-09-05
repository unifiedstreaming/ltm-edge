#!/bin/bash
log_type=$1

sudo docker exec -t `sudo docker ps | tail -n 1 | awk '{print $1}'` /root/obtain_size.sh /var/log/apache2/$log_type-origin-access.log /var/log/apache2/$log_type-origin-size.log
