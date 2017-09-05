#!/bin/bash

sudo docker exec -t `sudo docker ps | tail -n 1 | awk '{print $1}'` /root/purge_cache.sh
