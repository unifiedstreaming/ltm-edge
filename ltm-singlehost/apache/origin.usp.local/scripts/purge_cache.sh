#!/bin/bash

for i in `ls /var/log/apache2/*.log`; do echo > $i; done
