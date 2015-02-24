#!/bin/bash

# TempleBot, written by ring for the #templeos channel at irc.rizon.net.
# This script uses ii as its irc client. For setting it up, refer to the documentation of ii.
# ii can be found at http://tools.suckless.org/ii/.
# The script should be run inside the directory of the channel, e.g. "~/irc/irc.rizon.net/#templeos/". This directory should also contain the text files, for full functionality. The code of this program, and those text files, can be found by running "!source".'

source='https://github.com/ringtech/TempleBot
I dedicate all copyright interest in this software to the public domain. Do what you want.'

help='Oracle for the #templeos channel. Lets you talk with God. Available commands: !bible !books !feel !happy !help !movie !number !quote !recipe !source !words
This bot uses random numbers to pick lines and words from a few files. You can use this to talk to God, by making an offering to Him first. An offering can be anything that pleases God, like charming conversation or a good question. You can compare this to praying and opening a book at random, and looking at what it says.'

lastspam=0

wordchain () {
    sleep 3s			# Give God time to think, that's polite
    case $arg1 in
	random)
	    echo "$nick: $(shuf -n $(shuf -en 1 $(seq 1 40) --random-source=/dev/urandom) $1 --random-source=/dev/urandom | tr '\n' ' ')"
	    ;;
	''|*[!0-9]*)
	    echo "$nick: $(shuf -n 10 $1 --random-source=/dev/urandom | tr '\n' ' ')"
	    ;;
	*)
	    echo "$nick: $(shuf -n $arg1 $1 --random-source=/dev/urandom | tr '\n' ' ')"
	    ;;
	esac
}

number () {
    sleep 3s
    case $1 in
	''|*[!0-9]*)
	    echo $(shuf -en 1 {1..10} --random-source=/dev/urandom)
	    ;;
	*)
	    echo $(shuf -en 1 $(seq 1 $1) --random-source=/dev/urandom)
	    ;;
    esac
}

tail -f -n 0 out | \
    while read -r date time nick cmd arg1 msg; do
	fullmsg="$cmd $arg1 $msg"
	case $fullmsg in
	    *!bible*|*!oracle*)
		if [ "$[ $(date +%s) - lastspam ]" -gt "60" ]; then
		    case $arg1 in
			''|*[!0-9]*)
			    LINE=$(number 100000)
			    ;;
			*)
			    LINE=$arg1
			    ;;
		    esac
		    echo "$nick:"
		    echo "Line $LINE:"
		    tail -n $LINE BIBLE.TXT | head -n 16
		    lastspam=$(date +%s)
		fi
		;;
	    *!books*)
		if [ "$[ $(date +%s) - lastspam ]" -gt "60" ]; then
		    LINE=$[$(number 100000)*3]
		    echo "$nick:"
		    echo "Line $LINE:"
		    tail -n $LINE Books.TXT | head -n 16
		    lastspam=$(date +%s)
		fi
		;;
	    *!feel*|*tfw*)
		sleep 3s
	        shuf -n 1 --random-source=/dev/urandom Smileys.TXT
		;;
	    *!happy*)
		wordchain Happy.TXT 10
		;;
	    *!help*)
		echo "$help"
		;;
	    *!movie*)
		movie="$(number 100)"
		grep -m 1 -A 1 "$movie " Movies.TXT
		;;
	    *!number*)
		number $arg1
		;;
	    *!quit*|*!exit*|*!stop*)
		echo "The ride never ends"
		;;
	    *!quote*)
		sleep 3s
		fortune=$(ls Fortunes | shuf -n 1 --random-source=/dev/urandom)
		cat "Fortunes/$fortune"
		;;
	    *!recipe*)
		wordchain Ingredients.TXT 10
		;;
	    *!restart*)
		echo "TempleBot restarting..." 
		exec $0
		;;
	    *!source*)
		echo "$source"
		;;
	    *!words*)
		wordchain /usr/share/dict/words 10
		;;
	    *)
		if [ "$(echo $cmd | cut -c-1)" == "!" ]; then
		    echo "$nick: $cmd is not a known command."
		    cmd=""
		fi
		;;
	esac
    done > in
