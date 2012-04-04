#!/bin/bash
ZLMAPPLYDATE=`date`
ZLMLOGFILE="ZLMPoliciesApplied.log"
ZLMPOLICYNAME="Authentication "
ZLMPOLICYVERSION="002"
MOUNTPOINT="/mnt/linuxdist"
EMAILTOADDRESS="ots-linux-osadmin@smail-int.med.umich.edu"
ZLMSERVER="ZLM02"
#-------------------

# 
# Anyone changing the file must log who made the change
#
#
#      policy created by kumar 8/28/2007  
#      policy modified by kumar 1/10/2008 to include creating a crontab to merger the password file. 

if [ -e /etc/DontApplyLDAPPolicy ]; then
  echo "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION Policy NOT applied from $ZLMSERVER $ZLMAPPLYDATE (file /etc/DontApplyLDAPPolicy found)" >> /var/log/$ZLMLOGFILE
  echo "test\n.\n" | mail $EMAILTOADDRESS -s "Server requested to be excluded from LDAP Policy" -r root  
  exit
fi

if [ ! -d "${MOUNTPOINT}" ]; then
   mkdir $MOUNTPOINT
else
   MAXCOUNT=`df -h | grep ${MOUNTPOINT} | grep -v grep | wc -l`
   COUNT=1
   while [ "$COUNT" -le "$MAXCOUNT" ]
   do
      umount $MOUNTPOINT
      echo "Unmounted $COUNT"
      COUNT=$(($COUNT+1))
  done
fi

mount -t nfs 172.20.2.59:/linuxdist $MOUNTPOINT
sleep 3

MTAB=`grep $MOUNTPOINT /etc/mtab`
if [ -z "${MTAB}" ]; then
  echo "test\n.\n" | mail $EMAILTOADDRESS -s "Unable to mount linuxdist to apply $ZLMPOLICYNAME" -r root
  echo "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION Policy NOT applied $ZLMAPPLYDATE (linuxdist cannot be mounted)" >> /var/log/$ZLMLOGFILE
  exit
fi
if [ ! -e /etc/pam.d/sshd_preldap ]; then
    mkdir /etc/crypt
    mv /etc/pam.d/su /etc/pam.d/su_preldap
    mv /etc/pam.d/login /etc/pam.d/login_preldap
    mv /etc/pam.d/sshd /etc/pam.d/sshd_preldap
    mv /etc/ldap.conf /etc/ldap.conf_preldap
    cp /etc/passwd /etc/passwd_preldap
    cp /etc/shadow /etc/shadow_preldap
    cp /etc/passwd /etc/crypt/passwd_local
    cp /etc/shadow /etc/crypt/shadow_local
    cp -p $MOUNTPOINT/Auth_Scripts/login /etc/pam.d/
    cp -p $MOUNTPOINT/Auth_Scripts/su /etc/pam.d/
    cp -p $MOUNTPOINT/Auth_Scripts/sshd /etc/pam.d/
    cp -p $MOUNTPOINT/Auth_Scripts/ldap.conf /etc/
    cp -p $MOUNTPOINT/Auth_Scripts/validate_user_passwd.sh /etc/crypt/
    chmod -R 400 /etc/crypt/
    chmod 755 /etc/crypt/validate_user_passwd.sh
    echo "test\n.\n" | mail $EMAILTOADDRESS -s "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION applied" -r root
    echo "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION Policy applied from $ZLMSERVER $ZLMAPPLYDATE " >> /var/log/$ZLMLOGFILE
else
    echo "test\n.\n" | mail $EMAILTOADDRESS -s "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION NOT applied" -r root
    echo "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION Policy already applied from $ZLMSERVER $ZLMAPPLYDATE " >> /var/log/$ZLMLOGFILE
    exit
fi
if [ -z "`cat /etc/crontab | grep validate_user_passwd.sh`" ]
      then
        cat $MOUNTPOINT/Auth_Scripts/ldapschedcron.txt >> /etc/crontab

        if [ -z "`cat /etc/crontab | grep validate_user_passwd.sh`" ]
          then
          echo "test\n.\n" | mail $EMAILTOADDRESS -s "crontab cannot be modified to apply $ZLMPOLICYNAME" -r root
          echo "$ZLMPOLICYNAME v.$ZLMPOLICYVERSION not completely successfull as crontab cannot be modifed " >> /var/log/$ZLMLOGFILE
        fi
fi
# before unmounting, wait a little time
sleep 5
umount $MOUNTPOINT
