#!/bin/bash


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

     echo "Pass: WebSite running inside container is accessible "

else

    echo "Fail"
fi



if [ "$selinux_chk" == "Practicing RHCSA9" ];then

     echo "Pass: Selinux is good, WebSite hosting on VM is accessible"

else

    echo "Fail"
fi


if [ $selinux_port -eq 0 ];then

     echo "Pass: Selinux webserver Port is good."

else

    echo "Fail"
fi


if [ $container_port -eq 0 ];then

     echo "Pass: Container webserver Port is good."

else

    echo "Fail"
fi



if [ $mnt_st -eq 0  ];then

     echo "Pass: Autofs filesystem is mounted"

else

    echo "Fail"
fi
