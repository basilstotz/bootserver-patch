#!/bin/sh


if test "$(systemctl is-active amxa-tunnel)" = "active"; then
    exit 0
fi


#patch puavo-bootserver-sync-images
echo "patch puavo-bootserver-sync-imeges"
sed -i 's/VERIFY_PEER/VERIFY_NONE/' /usr/sbin/puavo-bootserver-sync-images


#install packages
echo "install packages"
if ! dpkg -l autossh 2>/dev/null >/dev/null; then
    for N in debs/*.deb; do
	dpkg -i $N
    done
fi

if ! dpkg -l autossh  2>/dev/null >/dev/null; then
  echo "error: no autossh. exiting.."
  exit
fi

#start tunnel
#evtl port anpassen......
cp files/amxa-tunnel.service /etc/systemd/system/.

#if fping -q backup.amxa.ch; then
SSHOPT="-p443 -i /adm-home/adm-bstotz/keys/id_rsa -o StrictHostKeyChecking=no"
if ssh $SSHOPT root@backup.amxa.ch true; then
  systemctl start amxa-tunnel
fi


#if $(ps aux|grep -v grep|grep -q autossh); then
#  echo ja
#else
#  echo nein
#  autossh $SSHOPT -R $PORT:localhost:22 root@backup.amxa.ch sleep 999999999999999 &
#fi

cp files/language /etc/profile.d/.

exit
