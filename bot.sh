#!/bin/bash

# TempleBot, originally written by ring in 2015 for the #templeos 
# channel at irc.rizon.net. IRC bot that lets you talk to God.
#
# Project homepage: https://templebot.neocities.org
# Current repository: https://github.com/haywalk/TempleBot
# Original repository: https://github.com/ringtech/TempleBot
#
# This software is in the PUBLIC DOMAIN. "Do what you want."
#
# This script uses ii as its irc client. For setting it up, refer to the
# documentation of ii.
# 
# ii can be found at: https://tools.suckless.org/ii/
#
# The script should be run inside the directory of the channel, e.g.
# "~/irc/irc.rizon.net/#templeos/". The other files associated with
# the bot (e.g. Bible.TXT) should also be in that directory.

# Information about where to download the source code
source='TempleBot was originally made by RingTech in 2015 for the '\
'#templeos channel on Rizon.

You can download the TempleBot source code at: '\
'https://templebot.neocities.org

In the spirit of TempleOS, this software is dedicated to the public '\
'domain. "Do what you want"'

# Help message
help='Oracle for the #templeos channel. Lets you talk with God.

Available commands: !bible !books !feel !happy !help !movie !number '\
'!quote !recipe !source !words

This bot uses random numbers to pick lines and words from a few '\
'files. You can use this to talk to God, by making an offering to Him '\
'first. An offering can be anything that pleases God, like charming '\
'conversation or a good question. You can compare this to praying and '\
'opening a book at random, and looking at what it says.'

# Keep track of time a command was last issued, to avoid spam
lastspam=0

# Get random words from a file. The filename is passed in as an argument
# and number of words is an optional second argument.
wordchain () {	
	sleep 3s # Give God time to think, that's polite

	case $arg1 in
		# If 'random' is passed in, generate random number of words
		random)
			echo "$nick: $(shuf -n $(shuf -en 1 $(seq 1 40) \
				--random-source=/dev/urandom) $1 \
				--random-source=/dev/urandom | tr '\n' ' ')"
			;;

		# If no argument is passed in, generate 10 words
		''|*[!0-9]*)
			echo "$nick: $(shuf -n 10 $1 \
				--random-source=/dev/urandom | tr '\n' ' ')"
			;;

		# If a number is passed in, generate that number of words
		*)
			echo "$nick: $(shuf -n $arg1 $1 \
				--random-source=/dev/urandom | tr '\n' ' ')"
			;;
	esac
}

# This function generates a random number.
number () {	
	sleep 3s # Give God time to think, that's polite

	case $1 in
		# If no argument is passed, generate # between 1 and 10
		''|*[!0-9]*)
			echo $(shuf -en 1 {1..10} --random-source=/dev/urandom)
			;;
		# If an argument is passed, generate # between 1 and argument
		*)
			echo $(shuf -en 1 $(seq 1 $1) --random-source=/dev/urandom)
			;;
	esac
}

# Read from the output file until EOF (whenever ii stops running)
tail -f -n 0 out | \
	# Input split into timestamp, nick, command, argument, and message.
	while read -r date nick cmd arg1 msg; do 

	# Remove < and > from around nick
	nick="${nick#<}"
	nick="${nick%>}"

	# Switch statement checks what command was given
	case $cmd in
	
		# !bible / !oracle : Random bible passage
		!bible|!oracle)
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
				tail -n $LINE Bible.TXT | head -n 16
				lastspam=$(date +%s)
			fi
			;;
		
		# !books : Random line from a book
	    !books)
			if [ "$[ $(date +%s) - lastspam ]" -gt "60" ]; then
				LINE=$[$(number 100000)*3]
				echo "$nick:"
				echo "Line $LINE:"
				tail -n $LINE Books.TXT | head -n 16
				lastspam=$(date +%s)
			fi
			;;
		
		# !feel : Random emoticon
		!feel)
			sleep 3s
			shuf -n 1 --random-source=/dev/urandom Smileys.TXT
			;;

		# !happy : Random happy words from God
		!happy)
			wordchain Happy.TXT 10
			;;
		
		# !help : Display help message
		!help)
			echo "$help"
			;;

		# !movie : Random movie title
		!movie)
			movie="$(number 100)"
			grep -m 1 -A 1 "$movie " Movies.TXT
			;;

		# !number : Random number
		!number)
			number $arg1
			;;
		
		# !quit / !exit / !stop : Don't quit (display snarky message)
		!quit|!exit|!stop)
			echo "The ride never ends"
			;;

		# !quote : Random fortune
		!quote)
			sleep 3s
			fortune=$(ls Fortunes | shuf -n 1 \
				--random-source=/dev/urandom)
			cat "Fortunes/$fortune"
			;;
		
		# !recipe : Random recipe
		!recipe)
			wordchain Ingredients.TXT 10
			;;

		# !restart : Restart the IRC bot
		!restart)
			echo "TempleBot restarting..." 
			exec $0
			;;

		# !source : Display information about where to download the bot
		!source)
			echo "$source"
			;;

		# !words / !God : Random words from God
		!words|!God*|!god*)
			wordchain /usr/share/dict/words 10
			;;

		# If someone typed a line that started with '!' but wasn't a
		# command, display error message
		*)
			if [ "$(echo $cmd | cut -c-1)" == "!" ]; then
				echo "$nick: $cmd is not a known command."
			fi
			;;
	esac

	# Send the bot's output to the 'in' file (to be sent to the channel)
	done > in
