#!/bin/bash


# Need to delete group admins entry from sudoers file

if [ `id -u` != 0 ];then
	echo ""
	echo -e "\e[31m Failed: Please Run this Script as root\e[0m\n"
	exit 1
fi

echo "RUNNING TASK 1 ......................."
#dnf remove httpd-core httpd -y -q &>/dev/null
echo "RUNNING TASK 2 ......................."

dnf install httpd-core httpd -y -q &>/dev/null

echo "RUNNING TASK 3 ......................."
systemctl start httpd &>/dev/null

echo "RUNNING TASK 4 ......................."
semanage port -d -t http_port_t 82 -p tcp &>/dev/null
sed -i 's/^List.*/Listen 82/' /etc/httpd/conf/httpd.conf
systemctl restart httpd &>/dev/null
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
mkdir /share &>/dev/null
userdel -r linda &>/dev/null
useradd linda &>/dev/null
echo "redhat" |passwd --stdin linda &>/dev/null
userdel -r john &>/dev/null
useradd -u 3020 -b /share -M john &>/dev/null

echo "redhat" |passwd --stdin linda &>/dev/null
echo "redhat" |passwd --stdin john &>/dev/null
echo "RUNNING TASK 10 ......................"
mkdir /rhome &>/dev/null
rm -rf /home/linda/web /tmp/files &>/dev/null
mkdir -p /home/linda/web/html
chown -R linda:linda /home/linda/web
touch /tmp/rh_file{1..10}.txt
chown linda:linda /tmp/rh_file{1..10}.txt
rm -rf /home/linda/.config/systemd
rm -rf /home/linda/.config/containers
rm -rf /tmp/files
mkdir /tmp/files
rm -rf /var/tmp/linda
mkdir  /var/tmp/linda
userdel -r natasha
userdel -r harry
userdel -r sarah
groupdel admins
echo "RUNNING TASK 11 ......................"
dnf groupremove "RPM Development Tools" -y &>/dev/null
dnf remove autofs -y &>/dev/null
dnf remove chrony -y &>/dev/null

echo "RUNNING TASK 12 ......................"
sed -i '/^\/-/d' /etc/auto.master &>/dev/null
sed -i '/\/rhome/d' /etc/auto.master &>/dev/null
sed -i '/\/home/d' /etc/auto.misc &>/dev/null
firewall-cmd --remove-port=82/tcp --permanent &>/dev/null
firewall-cmd --reload &>/dev/null
dnf install tuned -y &>/dev/null
systemctl start tuned &>/dev/null
tuned-adm profile network-latency &>/dev/null 

echo "RUNNING TASK 13 ......................"

su - student -c "podman stop myweb1" &>/dev/null
su - student -c "podman rm myweb1" &>/dev/null
su - student -c "podman rmi webimage" -f &>/dev/null
su - student -c "rm -rf /home/student/.config/systemd/user/con*" &>/dev/null
su - student -c "rm -rf /home/student/.config/systemd" &>/dev/null
su - student -c "rm -rf /home/student/.config/containers" &>/dev/null


echo "RUNNING Final Task ..................."
echo "Practicing RHCSA9" > /web1/index.html
echo "Hello From myweb1 Container" >/home/linda/web/html/index.html
chown -R linda:linda /home/linda/web/html
find / -iname containerfile -type f -print 2>/dev/null -exec rm -rf {} \;
echo
echo -e "Exam Environment Setup Completed!\n"

echo -e "Rebooting System.................."
echo `openssl rand -base64 14`|passwd --stdin root &>/dev/null

echo "/fake /fake_dir xfs defaults 0 0" >>/etc/fstab

shutdown -r now

