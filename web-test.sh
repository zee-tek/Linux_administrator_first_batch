#!/bin/bash


container_chk=`curl localhost:8085 2>/dev/null`
selinux_chk=`curl localhost:82 2>/dev/null`
container_port=`firewall-cmd --list-ports |grep '8085'`
selinux_port=`firewall-cmd --list-ports |grep '82'`
cd /share/john &>/dev/null
df -h /share/john &>/dev/null
mnt_st=$?


if [ "$container_chk" == "Hello From myweb1 Container" ];then

     echo "Pass: Container is running"

else

    echo "Fail"
fi



if [ "$selinux_chk" == "Practicing RHCSA9" ];then

     echo "Pass: Selinux is good, web content is showing"

else

    echo "Fail"
fi


if [ "$selinux_port" == "82"  ];then

     echo "Pass: Selinux webpage Port is good."

else

    echo "Fail"
fi


if [ "$container_port" == "8085"  ];then

     echo "Pass: Container webpage Port is good."

else

    echo "Fail"
fi



if [ $mnt_st -eq 0  ];then

     echo "filesystem is mounted"

else

    echo "Fail"
fi
