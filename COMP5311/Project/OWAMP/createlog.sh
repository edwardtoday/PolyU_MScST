#!/bin/sh
# Log ping/traceroute/owping output
# Author: QING Pei
# Last changed: 2011-11-24 04:26
# ---------------------------------------------------------------------------------------------------------

# date
# NOW=$(date +"%F")
CURRENT_TIME=$(date '+%Y%m%d-%H%M')

# log path
LOG_PATH="/home/owamp/Dropbox/PolyU/COMP5311/Project/OWAMP/log"
# mkdir $LOG_PATH

# ---------------------------------------------------------------------------------------------------------
# CUHK
CUHK="137.189.27.61"	# "lbl.csc.cuhk.edu.hk"
US="64.57.17.162"	# "owamp.losa.net.internet2.edu"
CANADA="206.12.24.110" 	# "boom.westgrid.ca"
FRANCE="193.48.99.79" 	# "ccperfsonar-lhcopn.in2p3.fr"
UK="130.246.179.197" 	# "perfsonar-ps02.gridpp.rl.ac.uk"
ITALY="90.147.67.252"	# "perfsonar2.na.infn.it"

PINGFILE="$LOG_PATH/$CURRENT_TIME.ping.txt"
touch $PINGFILE
ping -c 16 $CUHK > $PINGFILE
ping -c 16 $US >> $PINGFILE
ping -c 16 $CANADA >> $PINGFILE
ping -c 16 $FRANCE >> $PINGFILE
ping -c 16 $UK >> $PINGFILE
ping -c 16 $ITALY >> $PINGFILE


TRACEROUTEFILE="$LOG_PATH/$CURRENT_TIME.traceroute.txt"
touch $TRACEROUTEFILE
traceroute $CUHK > $TRACEROUTEFILE
traceroute $US >> $TRACEROUTEFILE
traceroute $CANADA >> $TRACEROUTEFILE
traceroute $FRANCE >> $TRACEROUTEFILE
traceroute $UK >> $TRACEROUTEFILE
traceroute $ITALY >> $TRACEROUTEFILE


OWPINGFILE="$LOG_PATH/$CURRENT_TIME.owping.txt"
touch $OWPINGFILE
/usr/local/bin/owping -t -c 300 $CUHK > $OWPINGFILE
/usr/local/bin/owping -t -c 300 $US >> $OWPINGFILE
/usr/local/bin/owping -t -c 300 $CANADA >> $OWPINGFILE
/usr/local/bin/owping -t -c 300 $FRANCE >> $OWPINGFILE
/usr/local/bin/owping -t -c 300 $UK >> $OWPINGFILE
/usr/local/bin/owping -t -c 300 $ITALY >> $OWPINGFILE

OWPINGFROMFILE="$LOG_PATH/$CURRENT_TIME.owping.from.txt"
touch $OWPINGFROMFILE
/usr/local/bin/owping -f -c 300 -P 60000-60010 $CUHK > $OWPINGFROMFILE
/usr/local/bin/owping -f -c 300 -P 60000-60010 $US >> $OWPINGFROMFILE
/usr/local/bin/owping -f -c 300 -P 60000-60010 $CANADA >> $OWPINGFROMFILE
/usr/local/bin/owping -f -c 300 -P 60000-60010 $FRANCE >> $OWPINGFROMFILE
/usr/local/bin/owping -f -c 300 -P 60000-60010 $UK >> $OWPINGFROMFILE
/usr/local/bin/owping -f -c 300 -P 60000-60010 $ITALY >> $OWPINGFROMFILE

exit
