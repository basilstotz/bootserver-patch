#!/bin/sh
sed -i 's/VERIFY_PEER/VERIFY_NONE/' /usr/sbin/puavo-bootserver-sync-images
exit
