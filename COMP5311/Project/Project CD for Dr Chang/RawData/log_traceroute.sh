#!/bin/sh
# Log traceroute output
# Author: QING Pei
# Last changed: 2011-11-12 20:09
# ---------------------------------------------------------------------------------------------------------

# date
# NOW=$(date +"%F")
CURRENT_TIME=$(date '+%Y%m%d-%H%M')

# log path
LOG_PATH="/home/owamp/Dropbox/PolyU/COMP5311/Project/OWAMP/log"
# mkdir $LOG_PATH

# measurement tool
TOOL="traceroute"

# ---------------------------------------------------------------------------------------------------------
# CUHK
CUHK="137.189.27.61"	# "lbl.csc.cuhk.edu.hk"
US="64.57.17.162"	# "owamp.losa.net.internet2.edu"
CANADA="206.12.24.110" 	# "boom.westgrid.ca"
FRANCE="193.48.99.79" 	# "ccperfsonar-lhcopn.in2p3.fr"
UK="130.246.179.197" 	# "perfsonar-ps02.gridpp.rl.ac.uk"
ITALY="90.147.67.252"	# "perfsonar2.na.infn.it"

TRACEROUTEFILE="$LOG_PATH/$CURRENT_TIME.traceroute.txt"
touch $TRACEROUTEFILE
$TOOL $CUHK > $TRACEROUTEFILE
$TOOL $US >> $TRACEROUTEFILE
$TOOL $CANADA >> $TRACEROUTEFILE
$TOOL $FRANCE >> $TRACEROUTEFILE
$TOOL $UK >> $TRACEROUTEFILE
$TOOL $ITALY >> $TRACEROUTEFILE

exit
