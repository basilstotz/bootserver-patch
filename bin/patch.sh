#!/bin/sh

PORT=4567

SSH="ssh -i /home/pi/bootserver-patch/data/keys/id_rsa adm-bstotz@10.249.15.254 "
   if  fping -q 10.249.15.254;then

       if test "$($SSH systemctl is-active amxa-tunnel)" = "active"; then
	   echo "is active"
	   exit 0
       fi

       if ! fping -q backup.amxa.ch;then
	  echo "kein internet"
	  exit 1
       fi
       
       rsync -v -r -e"ssh  -i /home/pi/bootserver-patch/data/keys/id_rsa" /home/pi/bootserver-patch/data/ adm-bstotz@10.249.15.254:.

       $SSH sudo bin/agent.sh $PORT
    fi
    exit
    
    
      
