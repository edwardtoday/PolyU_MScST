What each file is for?

./gen_packets.sh
	Generate packets to be catpured. Including:
		ping(echo requests) to 137.189.27.61
		traceroute to 64.57.17.162
		owping to 206.12.24.110
	Log files are moved from ../log/ to ./
./wireshark_simple
	The captured packets of "./gen_packets.sh".
./capture_ping
	The captured packets of "../log_ping.sh".
./capture_traceroute
	The captured packets of "../log_traceroute.sh".
./capture_owping
	The captured packets of "../log_owping.sh".
