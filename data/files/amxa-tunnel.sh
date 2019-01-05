#!/bin/sh


### BEGIN INIT INFO
# Provides:          skeleton
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      S 0 1 6
# Short-Description: Example initscript
# Description:       This file should be used to construct scripts to be
#                    placed in /etc/init.d.
### END INIT INFO

#
# Function that starts the daemon/service
#
do_start()
{    
     if ! [ -f /run/tunnel.pid ]; then
        $0 daemon &
        echo $! > /run/tunnel.pid
        echo "info: tunnel established"
     else
        echo "warning: tunnel already running. Hint: Use   rm /run/tunnel.pid   if this is not true."
     fi
}


do_daemon()
{
  while true; do
    ssh -p443 -i /adm-home/adm-bstotz/id_rsa -o BatchMode=yes -o StrictHostKeyChecking=no -R 4567:localhost:22 root@backup.amxa.ch sleep 999999999999999
    sleep 300
  done
}

#
# Function that stops the daemon/service
#
do_stop()
{
  if [ -f /run/tunnel.pid ]; then 
    kill $(cat /run/tunnel.pid)
    rm /run/tunnel.pid;
    echo "info: tunnel closed." 
  else
    echo "warning: tunnel was not established"
  fi 
}

#
# Function that sends a SIGHUP to the daemon/service
#
do_reload() 
{
  do_stop
  do_start
}


case "$1" in
  start)
        do_start
	;;
  daemon)
        do_daemon
        ;;
   stop)
        do_stop
	;;
  restart|force-reload)
        do_reload
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|restart||force-reload}" >&2
	exit 3
	;;
esac
