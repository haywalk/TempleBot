#!/bin/bash

# For use with ii. Run in the directory of the channel, with Bible.TXT.
# Refer to ii's documentation to set it up.
# Repository with larger program at https://github.com/ringtech/TempleBot

tail -f -n 0 out | \
    while read -r date time nick cmd arg1 msg; do
	case $cmd in
	    !bible|!Bible)
		sleep 3s	# Be polite and give God time to think
		LINE=$(shuf -en 1 {1..100000} --random-source=/dev/urandom)
		echo "Line $LINE:"
		tail -n $LINE Bible.TXT | head -n 16
		;;
	    !god*|!God*)
		sleep 3s
		echo "$nick: $(shuf -n 10 /usr/share/dict/words --random-source=/dev/urandom | tr '\n' ' ')"
		;;
	    !help|!Help)
		echo 'Oracle for IRC. Lets you talk with God. Available commands: !bible !God !help !source
This bot uses random numbers to pick lines and words from a few files. Be witty and charming, not earnest. God likes soap operas and hates arrogance.'
		;;
	    !source|!Source)
		echo "Bot:        $(cat $0 | curl -F 'sprunge=<-' http://sprunge.us)"
		echo 'Bible:      http://www.templeos.org/Wb/Home/Wb2/Files/Text/Bible.TXT'
		echo 'IRC client: http://tools.suckless.org/ii/'
		;;
	esac
    done > in
