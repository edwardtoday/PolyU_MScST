# Python script to convert text output to csv table
# Author: QING Pei
# Last changed: 2011-11-15 02:53

import os
import csv
import time
from datetime import datetime

def getTimestamp(filename):
	year = int(filename[0:4])
	month = int(filename[4:6])
	day = int(filename[6:8])
	hour = int(filename[9:11])
	minute = int(filename[11:13])
	timestamp = datetime(year,month,day,hour,minute)
	# print(timestamp)
	return timestamp

# print(os.getcwd())

logpath = "./log"
filenamelist = os.listdir(logpath)
pingfilenames = []
traceroutefilenames = []
owpingfilenames = []

for logfilename in filenamelist:
	# print(logfilename)
	if(logfilename.endswith('.ping.txt')):
		pingfilenames.append(logfilename)
	elif(logfilename.endswith(".traceroute.txt")):
		traceroutefilenames.append(logfilename)
	elif(logfilename.endswith(".owping.txt")):
		owpingfilenames.append(logfilename)

# print(pingfilenames)
# print(traceroutefilenames)
# print(owpingfilenames)

## process ping logs
pingreport = csv.writer(open('pingreport.csv', 'wb'), delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
pingreport.writerow(['Datetime', 'DestIP', 'Packet loss %', 'RTT min', 'RTT avg', 'RTT max', 'RTT mdev'])

for pingfilename in pingfilenames:
	pingfile = open(logpath + "/" + pingfilename,'r')
	timestamp = getTimestamp(pingfilename)
	destip = ''
	packetloss = 0
	rttmin = 0
	rttavg = 0
	rttmax = 0
	rttmdev = 0
	for line in pingfile:
		if 'ping statistics' in line:
			destip = line.split(' ')[1]
			# print(destip)
		elif 'packets transmitted' in line:
			packetloss = line.split(' ')[5][:-1]
			# print(packetloss)
		elif 'rtt min/avg/max/mdev' in line:
			chunks = line.split('=')[1].split(' ')[1].split('/')
			# print(chunks)
			rttmin = chunks[0]
			rttavg = chunks[1]
			rttmax = chunks[2]
			rttmdev = chunks[3]
			pingreport.writerow([timestamp, destip, packetloss, rttmin, rttavg, rttmax, rttmdev])

## process traceroute logs
traceroutereport = csv.writer(open('traceroutereport.csv', 'wb'), delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
traceroutereport.writerow(['Datetime', 'DestIP', 'hops'])

for traceroutefilename in traceroutefilenames:
	traceroutefile = open(logpath + "/" + traceroutefilename, 'r')
	timestamp = getTimestamp(traceroutefilename)
	destip = ''
	hops = 0
	for line in traceroutefile:
		if 'traceroute to' in line:
			destip = line.split(' ')[2]
			# print(destip)
		elif destip in line:
			hops = int(line[0:2])
			# print(hops)
			traceroutereport.writerow([timestamp,destip,hops])

## process owping logs
owpingreport = csv.writer(open('owpingreport.csv', 'wb'), delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
owpingreport.writerow(['Datetime', 'DestIP', 'Packets loss %', 'One-way Delay min', 'One-way Delay median', 'One-way Delay max', 'One-way Delay err', 'One-way jitter', 'Hops'])

for owpingfilename in owpingfilenames:
	owpingfile = open(logpath + "/" + owpingfilename, 'r')
	timestamp = getTimestamp(owpingfilename)
	destip = ''
	packetloss = 0
	delaymin = 0
	delaymed = 0
	delaymax = 0
	delayerr = 0
	jitter = 0
	hops = 0
	for line in owpingfile:
		if 'owping statistics from' in line:
			destip = line.split('[')[2].split(']')[0]
			# print(destip)
		elif 'duplicates' in line:
			packetloss = line.split('%')[0].split('(')[1]
			# print(packetloss)
		elif 'min/median/max' in line:
			chunk = line.split('=')[1].split(' ')[1].split('/')
			delaymin = chunk[0]
			delaymed = chunk[1]
			delaymax = chunk[2]
			delayerr = line.split('=')[2].split(' ')[0]
			# print(delayerr)
		elif 'jitter' in line:
			jitter = line.split('=')[1].split(' ')[1]
		elif 'Hops' in line:
			hops = line.split(' ')[2]
		elif 'reordering' in line:
			owpingreport.writerow([timestamp, destip, packetloss, delaymin, delaymed, delaymax, delayerr, jitter, hops])

print('Report files generated')