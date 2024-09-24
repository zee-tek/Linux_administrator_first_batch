#!/bin/bash


if [ `id -u` != 0 ];then
	echo ""
	echo -e "\e[31m Failed: Please Run this Script as root\e[0m\n"
	exit 1
fi

echo "RUNNING TASK 1 ......................."
dnf remove httpd-core httpd -y -q &>/dev/null
echo "RUNNING TASK 2 ......................."

dnf install httpd-core httpd -y -q &>/dev/null

echo "RUNNING TASK 3 ......................."
systemctl start httpd &>/dev/null

echo "RUNNING TASK 4 ......................."
semanage port -d -t http_port_t 82 -p tcp &>/dev/null
sed -i 's/^List.*/Listen 82/' /etc/httpd/conf/httpd.conf

echo "RUNNING TASK 5 ......................."
rm -rf /web1 &>/dev/null
mkdir /web1


echo "RUNNING TASK 6 ......................."
sed -i 's/\(^DocumentRoot.*\)/DocumentRoot "\/web1"/' /etc/httpd/conf/httpd.conf

echo "RUNNING TASK 7 ......................."
sed -i '0,/<Directory "\/var\/www">/s|<Directory "/var/www">|<Directory "/web1">|' /etc/httpd/conf/httpd.conf


echo "RUNNING TASK 8 ......................."
systemctl restart httpd &>/dev/null

echo "RUNNING TASK 9 ......................."
userdel -r linda &>/dev/null
useradd linda &>/dev/null
echo "welcome" |passwd --stdin linda &>/dev/null

echo "RUNNING TASK 10 ......................"
rm -rf /home/linda/web /tmp/files &>/dev/null
mkdir -p /home/linda/web/html
touch /tmp/rh_file{1..10}.txt
chown linda:linda /tmp/rh_file{1..10}.txt



echo "RUNNING Final Task ..................."
echo "Practicing RHCSA9" > /web1/index.html
echo "Hello From myweb1 Container" >/home/linda/web/html/index.html

echo
echo -e "Exam Environment Setup Completed!\n"

echo -e "Rebooting System.................."
echo `openssl rand -base64 14`|passwd --stdin root &>/dev/null

echo "/fake /fake_dir xfs defaults 0 0" >>/etc/fstab

shutdown -r now

