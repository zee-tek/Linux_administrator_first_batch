#!/bin/bash

: ' This Script evaluates following Tasks
   - Check if web container is running or not
   - Check if Selinux fixed and webserver on VM is running or not
   - Check if websites running on container and vm are accessible or not
   - Check if Container and VM webservers Ports are open on firewall or not
   - Check if autofs filesystem is mounted or not
  '

################################################################ 

container_chk=`curl localhost:8085 2>/dev/null`
selinux_chk=`curl localhost:82 2>/dev/null`
firewall-cmd --list-ports |grep '8085' &>/dev/null
container_port=$?
firewall-cmd --list-ports |grep '82' &>/dev/null
selinux_port=$?

cd /share/john &>/dev/null
df -h /share/john &>/dev/null
mnt_st=$?


if [ "$container_chk" == "Hello From myweb1 Container" ];then

	echo
	echo -e "\e[32m Pass: Container Website is accessible \e[0m\n"

else
    echo
    echo -e "\e[31m Fail: Container Website is not accessible \e[0m\n"
fi



if [ "$selinux_chk" == "Practicing RHCSA9" ];then


	echo -e "\e[32m Pass: Selinux is good, WebSite hosting on VM is accessible \e[0m\n"

else

    echo -e "\e[31m Fail: Selinux WebSite hosting on VM is not accessible \e[0m\n"
fi


if [ $selinux_port -eq 0 ];then


	echo -e "\e[32m Pass: Selinux webserver Port is good. \e[0m\n"
else

    echo -e "\e[31m Fail: Selinux webserver Port is not good. \e[0m\n"
fi


if [ $container_port -eq 0 ];then


	echo -e "\e[32m Pass: Container webserver Port is good. \e[0m\n"

else

    echo -e "\e[31m Fail: Container webserver Port is not good. \e[0m\n"
fi



if [ $mnt_st -eq 0  ];then


	echo -e "\e[32m Pass: Autofs filesystem is mounted \e[0m\n"

else

    echo -e "\e[31m Fail: Autofs filesystem is not mounted \e[0m\n"
fi


#Author: Zeeshan Ali
