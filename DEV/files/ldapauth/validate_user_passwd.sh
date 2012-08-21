#!/bin/bash
 
#------------------------------------------
# kumar 08/17/2007
#
# Password creation file
#------------------------------------------

#-------------------
# Variable assignments
#-------------------
HOSTNAME=`hostname`
LIMIT=1001
MOUNTPOINT="/mnt/linuxdist"
LOCALPASSWD_FILE="/etc/crypt/passwd_local"
LOCALSHADOW_FILE="/etc/crypt/shadow_local"
EMAILTOADDRESS="ots-linux-osadmin@smail-int.med.umich.edu"
EMAILSUBJECT="Warning !!  password merge did not complete for $HOSTNAME"
TIMESTAMP=`date +"%b %d %Y %H:%M:%S"`
LOGFILE="/var/log/passwd_merge.log"

if [ ! -d "${MOUNTPOINT}" ]; then
   mkdir $MOUNTPOINT
else
   MAXCOUNT=`df -h | grep ${MOUNTPOINT} | grep -v grep | wc -l`
   COUNT=1
   while [ "$COUNT" -le "$MAXCOUNT" ]
   do 
      umount $MOUNTPOINT
     #  echo "Unmounted $COUNT"
      COUNT=$(($COUNT+1))
  done 
fi

mount -t nfs 172.20.2.59:/linuxdist $MOUNTPOINT
sleep 3 

MTAB=`grep $MOUNTPOINT /etc/mtab`
if [ -z "${MTAB}" ]; then
   echo "$TIMESTAMP Problem mounting linuxdist, password merging stopped" >> $LOGFILE
   echo "Please check and fix the linuxdist mount issue on $HOSTNAME before proceeding further" | mail "-s $EMAILSUBJECT" $EMAILTOADDRESS  
   exit
fi

if [ ! -e "$MOUNTPOINT/user_maint/$HOSTNAME" ]; then
   echo "$TIMESTAMP user password file $HOSTNAME missing on $MOUNTPOINT/user_maint, please create it before running the script" >> $LOGFILE
   echo "user password file $HOSTNAME missing on $MOUNTPOINT/user_maint" | mail "-s $EMAILSUBJECT" $EMAILTOADDRESS  
   exit
fi

IDS=`cat $MOUNTPOINT/user_maint/$HOSTNAME | tr :  " " | awk  '{print $3}'`
for ID in $IDS; do
        if [ $ID -le "$LIMIT" ];  then
           echo "$TIMESTAMP Users have UID less than 1001, password merging stopped" >> $LOGFILE
           echo "Users have UID less than 1001.warning password merge did not complete for $HOSTNAME" | mail "-s $EMAILSUBJECT" $EMAILTOADDRESS  
#           echo "id is " $ID
           exit 1
        fi
done

NAMES=`cat $MOUNTPOINT/user_maint/$HOSTNAME | tr : " " | awk '{print $1}'`
for NAME in $NAMES; do
       SHAD=`grep $NAME /etc/shadow`
       if [ -n "${SHAD}" ]; then
           echo "$TIMESTAMP Shadow entry exists for the user, user $NAME deleted from shadow file" >> $LOGFILE
           echo "User $NAME exist in the Shadow file on $HOSTNAME, user deleted from shadow file" | mail "-s $EMAILSUBJECT" $EMAILTOADDRESS  
#           echo "Name is " $NAME
           sed "/$NAME/d" /etc/shadow >> /etc/shadow.script
           mv /etc/shadow.script /etc/shadow
        fi
done

NAMES=`cat $MOUNTPOINT/user_maint/$HOSTNAME | tr : " " | awk '{print $1}'`
for NAME in $NAMES; do
       MSYS=`grep $NAME $MOUNTPOINT/user_maint/master_sys`
       if [ -n "${MSYS}" ]; then
           echo "$TIMESTAMP User exist in the master system account file, password merging stopped" >> $LOGFILE
           echo "User $NAME exist in the master_sys file, so it could be a system account" | mail "-s $EMAILSUBJECT" $EMAILTOADDRESS  
#           echo "Name is " $NAME
           exit 1
        fi
done

if [ ! -d /etc/backup ]; then
   mkdir /etc/backup
fi 
cp /etc/passwd /etc/backup/passwd.`date +%y%m%d%H%M%S`
cp /etc/shadow /etc/backup/shadow.`date +%y%m%d%H%M%S`

NAMES=`cat $MOUNTPOINT/user_maint/$HOSTNAME | tr : " " | awk '{print $1}'`
for NAME in $NAMES; do
       MUSR=`grep $NAME $MOUNTPOINT/user_maint/master_user`
       if [ "${MUSR}" ]; then
           cat $LOCALPASSWD_FILE $MOUNTPOINT/user_maint/$HOSTNAME > /etc/passwd 
           cp $LOCALSHADOW_FILE /etc/shadow
           echo "$TIMESTAMP User $NAME exists in the master user account file" >> $LOGFILE
      else
           echo "$TIMESTAMP User $NAME does not exist in the master user account file" >> $LOGFILE
           echo "User $NAME does not exist in the master_user file" | mail "-s $EMAILSUBJECT" $EMAILTOADDRESS  
#           echo "Name is " $NAME
           exit 1
        fi
done

sleep 5 
umount $MOUNTPOINT
