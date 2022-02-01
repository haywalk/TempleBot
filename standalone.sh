#!/bin/bash

# TempleBot, originally written by ring in 2015 for the #templeos 
# channel at irc.rizon.net. IRC bot that lets you talk to God.
#
# This is the standalone verison of TempleBot, meant to be run in
# your terminal instead of deployed on an IRC channel. The standalone
# version also lacks spam-prevention features present in the
# IRC version. It must be run in the same directory as the Fortune/ and
# Data/ directories in order to work.
#
# Project homepage: https://templebot.neocities.org
# Current repository: https://github.com/haywalk/TempleBot
# Original repository: https://github.com/ringtech/TempleBot
#
# This software is in the PUBLIC DOMAIN. "Do what you want."


# Information about where to download the source code
source='TempleBot was originally made by RingTech in 2015 for the '\
'#templeos channel on Rizon, and features were added in 2019 by '\
'Guest39.
You can download the TempleBot source code at: '\
'https://templebot.neocities.org
In the spirit of TempleOS, this software is dedicated to the public '\
'domain. "Do what you want."'

# Help message
help='Oracle for the #templeos channel. Lets you talk with God.
Available commands: !bible !books !checkem !feel !happy !help !movie '\
'!number !quote !recipe !source !tadquote !templeos !terry !words
This bot uses random numbers to pick lines and words from a few '\
'files. You can use this to talk to God, by making an offering to Him '\
'first. An offering can be anything that pleases God, like charming '\
'conversation or a good question. You can compare this to praying and '\
'opening a book at random, and looking at what it says.'

# Get random words from a file. The filename is passed in as an argument
# and number of words is an optional second argument.
wordchain () {	
	sleep 3s # Give God time to think, that's polite

	case $arg1 in
		# If 'random' is passed in, generate random number of words
		random)
			echo "$(shuf -n $(shuf -en 1 $(seq 1 40) \
				--random-source=/dev/urandom) $1 \
				--random-source=/dev/urandom | tr '\n' ' ')"
			;;

		# If no argument is passed in, generate 10 words
		''|*[!0-9]*)
			echo "$(shuf -n 10 $1 \
				--random-source=/dev/urandom | tr '\n' ' ')"
			;;

		# If a number is passed in, generate that number of words
		*)
			echo "$(shuf -n $arg1 $1 \
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

# Read from stdin file until EOF (whenever ii stops running)
while read -r cmd arg1 msg; do 
	
	# Switch statement checks what command was given
	case $cmd in
	
		# !bible / !oracle : Random bible passage
		# (original)
		!bible|!oracle)
			case $arg1 in
				''|*[!0-9]*)
					LINE=$(number 100000)
					;;
				*)
					LINE=$arg1
					;;
			esac
				
			echo "Line $LINE:"
			tail -n $LINE ./Data/Bible.TXT | head -n 16
			;;
		
		# !books : Random line from a book
		# (original)
		!books)
			LINE=$[$(number 100000)*3]
			echo "Line $LINE:"
			tail -n $LINE ./Data/Books.TXT | head -n 16
			;;
		
		# !checkem : Random number
		# (From Guest39 version)
		!checkem)
			echo $(( ( RANDOM % 10000 )  + 1 ))
			;;
		
		# !feel : Random emoticon
		# (original)
		!feel)
			sleep 3s
			shuf -n 1 --random-source=/dev/urandom ./Data/Smileys.TXT
			;;

		# !happy : Random happy words from God
		# (original)
		!happy)
			wordchain ./Data/Happy.TXT 10
			;;
		
		# !help : Display help message
		# (original)
		!help)
			echo "$help"
			;;

		# !movie : Random movie title
		# (original)
		!movie)
			movie="$(number 100)"
			grep -m 1 -A 1 "$movie " ./Data/Movies.TXT
			;;

		# !number : Random number
		# (original)
		!number)
			number $arg1
			;;
		
		# !quit / !exit / !stop : Don't quit (display snarky message)
		# (original)
		!quit|!exit|!stop)
			echo "The ride never ends"
			;;

		# !quote : Random fortune
		# (original)
		!quote)
			sleep 3s
			fortune=$(ls Fortunes | shuf -n 1 \
				--random-source=/dev/urandom)
			cat "Fortunes/$fortune"
			;;
		
		# !recipe : Random recipe
		# (original)
		!recipe)
			wordchain ./Data/Ingredients.TXT 10
			;;

		# !restart : Restart the IRC bot
		# (original)
		!restart)
			echo "TempleBot restarting..." 
			exec $0
			;;

		# !source : Display information about where to download the bot
		# (original)
		!source)
			echo "$source"
			;;

		# !tadquote / !tquote : Random (mostly clean) Terry Twitter quote
		# (from Guest39 version)
		!tadquote|!tquote)
			echo "Terry says..."
			sleep 3s
			shuf -n 1 --random-source=/dev/urandom ./Data/CleanTweets.TXT
			;;

		# !terry / !tad : Show an ASCII-art image of King Terry
		# (from Guest39 version)
		!terry|!tad)
			cat ./Data/TADPortrait-TERM.TXT
			;;

		# !tos : Show an ASCII-art image of the TempleOS logo.
		# (from 2022 version)
		!templeos|!tos)
			cat ./Data/TOSLogo-TERM.TXT
			;;

		# !words / !God / !gw : Random words from God
		# (original)
		!words|!God*|!god*|!gw)
			wordchain /usr/share/dict/words 10
			;;

		# If someone typed a line that started with '!' but wasn't a
		# command, display error message
		# (original)
		*)
			if [ "$(echo $cmd | cut -c-1)" == "!" ]; then
				echo "$cmd is not a known command."
			fi
			;;
	esac
done
