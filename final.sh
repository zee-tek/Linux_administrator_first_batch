#!/bin/bash


# Need to delete group admins entry from sudoers file (DONE)
# change the Max days back to 9999 (DONE)
# clear cron log messages (DONE)
# clear swap and filesystems,partitions
# remove /var/log/journal (DONE)
# remove tar ball (DONE)
# Clean Repos
# umask for natasha needs t obe removed
# delete cron job for uswer harry
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
rm -rf /web1
#mkdir /web1


echo "RUNNING TASK 6 ......................."
#sed -i 's/\(^DocumentRoot.*\)/DocumentRoot "\/web1"/' /etc/httpd/conf/httpd.conf

echo "RUNNING TASK 7 ......................."
#sed -i '0,/<Directory "\/var\/www">/s|<Directory "/var/www">|<Directory "/web1">|' /etc/httpd/conf/httpd.conf
echo "Practicing RHCSA" >>/tmp/index.html
mv /tmp/index.html /var/www/html
echo "Hello WOrld" >>/tmp/file1
mv /tmp/file1 /var/www/html

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
rm -rf /home/linda/web /tmp/files
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
rm -rf /var/tmp/boo_logs
rm -rf /var/tmp/string_output
sed -i '/^Storage/s/persistent/volatile/' /etc/systemd/journald.conf
sed -i '/^Storage/s/auto/volatile/' /etc/systemd/journald.conf
systemctl restart systemd-journald
echo >/var/log/messages
echo > /var/log/audit/audit.log
rm -rf /var/log/journal
userdel -r natasha &>/dev/null
userdel -r harry &>/dev/null
userdel -r sarah &>/dev/null
sed -i '/^%admins/d' /etc/sudoers
groupdel admins &>/dev/null
sed -i '/^PASS_MAX_DAYS/s/90/9999/' /etc/login.defs
echo "RUNNING TASK 11 ......................"
dnf groupremove "RPM Development Tools" -y &>/dev/null
dnf remove autofs -y &>/dev/null
dnf remove chrony -y &>/dev/null

echo "RUNNING TASK 12 ......................"
sed -i '/^\/-/d' /etc/auto.master &>/dev/null
sed -i '/\/rhome/d' /etc/auto.master &>/dev/null
sed -i '/\/home/d' /etc/auto.misc &>/dev/null
firewall-cmd --remove-port={82/tcp,8085/tcp} --permanent &>/dev/null
firewall-cmd --reload &>/dev/null
dnf install tuned -y &>/dev/null
systemctl start tuned &>/dev/null
tuned-adm profile network-latency &>/dev/null 

echo "RUNNING TASK 13 ......................"

su - student -c "podman stop myweb1" &>/dev/null
su - student -c "podman rm myweb1" &>/dev/null
su - student -c "podman rmi webimage" -f &>/dev/null
su - student -c "rm -rf /home/student/.config/systemd/user/con*"
su - student -c "rm -rf /home/student/.config/systemd"
su - student -c "rm -rf /home/student/.config/containers"


echo "RUNNING Final Task ..................."
echo "Practicing RHCSA9" > /web1/index.html 2>/dev/null
echo "Hello From myweb1 Container" >/home/linda/web/html/index.html
chown -R linda:linda /home/linda/web/html &>/dev/null
chmod 700 /home/linda/web/html/index.html
find / -iname containerfile -type f -exec rm -rf {} \;
find / -iname archive.tar.bz2 -delete
echo
echo -e "Exam Environment Setup Completed!\n"

echo -e "Rebooting System.................."
echo `openssl rand -base64 14`|passwd --stdin root &>/dev/null

echo "/fake /fake_dir xfs defaults 0 0" >>/etc/fstab

shutdown -r now

