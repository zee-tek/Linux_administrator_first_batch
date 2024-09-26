#!/bin/bash

: ' This Script is Created to test following
   - IP
   - Repository
   - Users
  '





ip_test=`nmcli con show enp0s3|grep ipv4.method|awk '{print $2}'`
dnf repolist --enabled -q|egrep -v '^rhel|^repo'|grep -i app&>/dev/null
app_chk=$?
dnf repolist --enabled -q|egrep -v '^rhel|^repo'|grep -i base&>/dev/null
base_chk=$?

usr_shell=` getent passwd sarah|awk -F ':' '{print $NF}'|grep nologin` &>/dev/null
usr_chk=$?

getent group admins|grep sarah &>/dev/null
chk_usr1=$?

getent group admins|grep harry &>/dev/null
chk_usr2=$?

getent group admins|grep natasha &>/dev/null
chk_usr3=$?

u_mask=`su - natasha -c "umask"`

sudo_pr=`grep "^%admins" /etc/sudoers`
sudo_chk=$?



if [ $u_mask == 0022 ];then
        echo "Pass"
else
        echo "Fail"
fi

echo "Checking Ip"....................

if [ $ip_test == "manual" ];then
     
	echo "PASS"
else
	echo "FAIL"
fi

echo "Checking Repositories"...............

if [ $app_chk -eq 0 ];then

  echo "Pass"

else

 echo "Fail"

fi

if [ $base_chk -eq 0 ];then

  echo "Pass"

else

 echo "Fail"

fi

echo "Checking users".............
if [ $usr_chk -eq 0 ];then

  echo "Pass"

else

 echo "Fail"

fi

if [ $chk_usr1 -eq 0 ];then
	echo "Pass"
else
	echo "Pass"
fi

if [ $chk_usr2 -eq 0 ];then
        echo "Pass"
else
        echo "Pass"
fi

if [ $chk_usr3 -eq 0 ];then
        echo "Pass"
else
        echo "Pass"
fi

if [ $u_mask == 0022 ];then
        echo "Pass"
else
        echo "Fail"
fi

if [ $sudo_chk -eq 0 ];then
        echo "Pass"
else
        echo "Pass"
fi

echo "============================"
echo "Question 4"
