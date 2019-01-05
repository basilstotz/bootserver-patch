#!/bin/sh

PORT=4567

SSH="ssh -i /home/pi/bootserver-patch-raspi/data/keys/id_rsa adm-bstotz@10.249.15.254 sudo "

    if  fping 10.249.15.254 -a >/dev/null 2>/dev/null;then

       rsync -v -r -e"ssh  -i /home/pi//bootserver-patch-raspidata/keys/id_rsa" /home/pi//bootserver-patch-raspi/data/ adm-bstotz@10.249.15.254:.

       $SSH sudo bin/agent.sh $PORT
    fi
    exit
    
    
      
