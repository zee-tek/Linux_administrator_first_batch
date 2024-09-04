#!/bin/bash

sed -i 's/\(^L.*\)/Listen 86/' /etc/httpd/conf/httpd.conf

mkdir /tmp/newdir

echo "Practicing RHCSA9" > /tmp/newdir/index.html
