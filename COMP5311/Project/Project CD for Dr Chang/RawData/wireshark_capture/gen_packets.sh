#!/bin/sh
CUHK="137.189.27.61"	# "lbl.csc.cuhk.edu.hk"
US="64.57.17.162"	# "owamp.losa.net.internet2.edu"
CANADA="206.12.24.110" 	# "boom.westgrid.ca"
ping -c 4 $CUHK
traceroute $US
/usr/local/bin/owping -t -c 10 $CANADA
