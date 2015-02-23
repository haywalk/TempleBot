#!/bin/bash

code='https://github.com/ringtech/TempleBot'

copying='I dedicate all copyright interest in this software to the public domain. Do what you want.'

info='TempleBot, written by ring for the #templeos channel at irc.rizon.net.
This script uses ii as its irc client. For setting it up, refer to the documentation of ii.
ii can be found at http://tools.suckless.org/ii/.
The script should be run inside the directory of the channel, e.g. "~/irc/irc.rizon.net/#templeos/". This directory should also contain the BIBLE.TXT and noob.txt files, for full functionality. The code of this program, and those text files, can be found by running "!source".'

explanation='This bot uses random numbers to pick lines and words from a few files. You can use this to talk to God, by making an offering to Him first. An offering can be anything that pleases God, like charming conversation or a good question. You can compare this to praying and opening a book at random, and looking at what it says.'

help='Bot for the #templeos channel. Lets you talk with god. For an explanation, say "!explain". Available commands: !bible !chat !explain !happy !help !inane !info !number !recipe !restart !source !words'

wordchain () {
    sleep 3s			# Give God time to think, that's polite
    case $arg1 in
	''|*[!0-9]*)
	    echo $(shuf -n 10 $1 --random-source=/dev/urandom | tr '\n' ' ')
	    ;;
	*)
	    echo $(shuf -n $arg1 $1 --random-source=/dev/urandom | tr '\n' ' ')
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
	case $cmd in
	    '!bible'|'!oracle')
		sleep 3s
		LINE=$(number 100000)
		echo "Line $LINE:"
		tail -n $LINE BIBLE.TXT | head -n 16
		;;
	    '!chat')
		shuf -n 1 out --random-source=/dev/urandom
		;;
	    '!explain')
		echo "$explanation"
		;;
	    '!happy')
		wordchain Happy.TXT 10
		;;
	    '!help')
		echo "$help"
		;;
	    '!inane')
		shuf -n 5 noob.txt --random-source=/dev/urandom
		;;
	    '!info')
		echo "$info"
		;;
	    '!number')
		number $arg1
		;;
	    '!recipe')
		wordchain Ingredients.TXT 10
		;;
	    '!restart')
		echo "TempleBot restarting..." 
		exec $0
		;;
	    '!source')
		echo "$code"
		echo "$copying"
		;;
	    '!words')
		wordchain /usr/share/dict/words 10
		;;
	esac
    done > in
