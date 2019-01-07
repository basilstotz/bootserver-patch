#!/bin/sh

PORT=4567

SSH="ssh -i /home/pi/bootserver-patch/data/keys/id_rsa adm-bstotz@10.249.15.254 sudo "
   if  fping 10.249.15.254 -a >/dev/null 2>/dev/null;then

       if test "$($SSH systemctl is-active amxa-tunnel)" = "active"; then
	   exit 0
       fi
       rsync -v -r -e"ssh  -i /home/pi/bootserver-patch/data/keys/id_rsa" /home/pi/bootserver-patch/data/ adm-bstotz@10.249.15.254:.

       $SSH sudo bin/agent.sh $PORT
    fi
    exit
    
    
      
