#!/bin/sh

PORT=4567
if ! test -z "$1"; then
    PORT=$1
fi

#install packages
echo "install packages"
if ! dpkg -l autossh 2>/dev/null >/dev/null; then
    for N in debs/*.deb; do
	dpkg -i $N
    done
fi

#establish tunnel
if ! dpkg -l autossh  2>/dev/null >/dev/null; then
  echo "error: no autossh. exiting.."
  exit
fi

SSHOPT="-p443 -i /adm-home/adm-bstotz/keys/id_rsa -o BatchMode=yes -o StrictHostKeyChecking=no"

if $(ps aux|grep -v grep|grep -q autossh); then
  echo ja
else
  echo nein
  autossh $SSHOPT -R $PORT:localhost:22 root@backup.amxa.ch sleep 999999999999999 &
fi


#patch puavo-bootserver-sync-images
echo "patch puavo-bootserver-sync-imeges"
sed -i 's/VERIFY_PEER/VERIFY_NONE/' /usr/sbin/puavo-bootserver-sync-images

cp files/language /etc/profile.d/.

exit
