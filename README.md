# TempleBot

**Visit the project homepage at [templebot.neocities.org](https://templebot.neocities.org)**

This is an updated and maintained version of TempleBot, the IRC bot written for the
\#templeos channel on Rizon. It was originally written in 2015 by GitHub user RingTech,
whose account has since been deleted, and further added onto by Guest39 in 2019.

See below for installation instructions.

In the spirit of TempleOS, this project is dedicated to the public domain.

## Commands

These are all the available commands and their optional arguments:

<dl>
  <dt>!bible / !oracle <i>$LINENUM (default random)</i></dt>
  <dd>Displays line number <i>$LINENUM</i> from the Bible file.</dd>   
  
  <dt>!books</dt>
  <dd>Displays a random passage from a random book.</dd>
  
  <dt>!checkem</dt>
  <dd>Random numbers, chan style.</dd>

  <dt>!feel</dt>
  <dd>Displays a random emoticon.</dd>

  <dt>!happy <i>$NUMBER (default 10) </i></dt>
  <dd>Displays <i>$NUMBER</i> random 'happy' words from God.</dd>
  
  <dt>!help</dt>
  <dd>Displays available commands and description of the bot.</dd>
      
  <dt>!movie</dt>
  <dd>Displays the title of a random movie.</dd>
      
  <dt>!number <i>$MAX (default 10)</i></dt>
  <dd>Displays a number between 1 and <i>$MAX</i>.</dd>
      
  <dt>!quit / !exit / !stop</dt>
  <dd>Doesn't stop the bot.</dd>
      
  <dt>!quote</dt>
  <dd>Displays a random fortune.</dd>
      
  <dt>!recipe <i>$NUMBER (default 10)</i></dt>
  <dd>Generates a random recipe made up of <i>$NUMBER</i> ingredients.</dd>
      
  <dt>!restart</dt>
  <dd>Restarts the bot.</dd>
      
  <dt>!source</dt>
  <dd>Displays credits and link to source code.</dd>
  
  <dt>!tadquote / !tquote</dt>
  <dd>Display a random (clean) Terry Davis quote.</dd>

  <dt>!templeos / !tos</dt>
  <dd>Display a color ASCII art picture of the TempleOS logo.</dd>

  <dt>!terry</dt>
  <dd>Display a color ASCII art picture of Terry Davis.</dd>

  <dt>!words / !God / !gw <i>$NUMBER (default 10)</i></dt>
  <dd>Displays <i>$NUMBER</i> random words from God.</dd>
</dl>

## Installation

TempleBot runs on [ii](https://tools.suckless.org/ii). ii is a file-based IRC client that is excellent for writing bots. Each server, channel, and user gets an in-file (actually a named pipe) and an out-file. Text sent by the server/others in a channel will appear in the out-file, and text that gets sent to the in-file will be sent to the server/channel/etc. In order for TempleBot to work, bot.sh and all the other data files must be in the directory of the channel you want it to run on. [See ii's website](https://tools.suckless.org/ii) for information about setting up ii.

### Requirements
- A UNIX-like system
- [ii](https://tools.suckless.org/ii)
- A system dictionary file located at /usr/share/dict/words

## Original Description from 2015

This is TempleBot, written by ring for the #templeos channel at irc.rizon.net.
This script uses ii as its irc client. For setting it up, refer to the documentation of ii. ii can be found at http://tools.suckless.org/ii/.
The script should be run inside the directory of the channel, e.g. "~/irc/irc.rizon.net/#templeos/". This directory should also contain the text files.

I dedicate all copyright interest in this software to the public domain. Do what you want.

This bot uses random numbers to pick lines and words from a few files. You can use this to talk to God, by making an offering to Him first. An offering can be anything that pleases God, like charming conversation or a good question. You can compare this to praying and opening a book at random, and looking at what it says.

## Past Repositories

Original: https://github.com/ringtech/TempleBot
Guest39's Version: https://gitgud.io/Guest39/TempleBot
