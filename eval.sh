ip_test=`nmcli con show enp0s3|grep ipv4.method|awk '{print $2}'`
dnf repolist --enabled -q|egrep -v '^rhel|^repo'|grep -i app&>/dev/null
app_chk=$?
dnf repolist --enabled -q|egrep -v '^rhel|^repo'|grep -i base&>/dev/null
base_chk=$?

usr_shell=` getent passwd sarah|awk -F ':' '{print $NF}'|grep nologin`
usr_chk=$?

getent group admins|grep sarah
chk_usr1=$?

getent group admins|grep harry
chk_usr2=$?

getent group admins|grep natasha
chk_usr3=$?

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

if [ $usr_chk -eq 0 ] 
