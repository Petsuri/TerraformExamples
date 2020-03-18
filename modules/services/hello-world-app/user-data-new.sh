#!/bin/bash

echo "Hello Petsuri, v2" > index.html
nohup busybox httpd -f -p ${server_port} &