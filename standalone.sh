#!/bin/bash

# TempleBot, written by ring for the #templeos channel at irc.rizon.net.
# This is a standalone version that doesn't use IRC.
# Run it in a directory together with the text files, and just enter your commands.

# I dedicate all copyright interest in this software to the public domain.
# Do what you want.

explanation="This bot uses random numbers to pick lines and words from a few files. You can use this to talk to God, by making an offering to Him first. An offering can be anything that pleases God, like charming conversation or a good question. You can compare this to praying and opening a book at random, and looking at what it says."

help="Bot for the #templeos channel. Lets you talk with god. For an explanation, say '!explain'. Available commands: !bible !words !happy !recipe !chat !inane !explain !restart !source !help"

wordchain () {
    sleep 3s			# Give God time to think, that's polite
    echo $(shuf -n 10 $1 --random-source=/dev/random | tr '\n' ' ')
}

cat | \
    while read -r date time nick cmd mesg; do
	case $cmd in
	    '!bible'|'!oracle')
		sleep 3s
		LINE=$(shuf -en 1 {1..100000} --random-source=/dev/random)
		echo "Line $LINE:"
		tail -n $LINE BIBLE.TXT | head -n 16
		;;
	    '!words')
		wordchain /usr/share/dict/words
		;;
	    '!happy')
		wordchain Happy.TXT
		;;
	    '!recipe')
		wordchain Ingredients.TXT
		;;
	    '!chat')
		shuf -n 1 out --random-source=/dev/random
		;;
	    '!inane')
		shuf -n 5 noob.txt --random-source=/dev/random
		;;
	    '!source')
		echo "https://github.com/ringtech/TempleBot"
		;;
	    '!explain')
		echo "$explanation"
		;;
	    '!restart')
		echo "TempleBot restarting..." 
		exec $0
		;;
	    '!help')
		echo "$help"
		;;
	esac
    done
