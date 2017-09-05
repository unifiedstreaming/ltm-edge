#!/bin/bash

for i in `sudo docker ps | grep "\"nginx\"" | awk '{print $1}'`; do sudo docker exec -t $i du -s /var/cache/nginx; done | awk '{print $1}'
