#!/bin/bash

: ' This Script is Created to test following
   - User Exists
   - UID Match
   - login Shell Match
   - User is member of right supplementary
  ' 

user_name="phill"
grp_name="hr"
des_user_id=2000
user_id=`id -u $user_name 2>/dev/null`
grp_st=`groups $user_name 2>/dev/null|grep -c $grp_name 2>/dev/null`
lg_shell=`grep phill /etc/passwd|awk -F : '{ print $7 }'|awk -F / '{ print $NF }'`
des_shell="nologin"

id -un $user_name &>/dev/null
user_st=$?

if [ `id -u` != 0 ];then
	echo ""
	echo -e "\e[31m Warning: Please Run this Script as root\e[0m\n"
	exit 1
fi

if [  $user_st -ne 0 ];then
	echo ""
	echo -e "\e[31m Warning: This program only test user 'Phill'\e[0m"
	echo -e "\e[31m Warning: If you have not created user 'Phill', create it then rerun the program\e[0m\n"
fi
if [ `getent passwd "$user_name" |grep $user_name 2>/dev/null` ]\
       	&& [ $user_id -eq $des_user_id ]  && [ $grp_st == 1 ]\
	&& [ $lg_shell == $des_shell ]

then
 
  echo -e "Result: Pass\n"

else

  echo -e "Result: Fail\n"

fi  

# Author: Zeeshan Ali
