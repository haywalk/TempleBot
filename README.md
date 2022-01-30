# TempleBot

![GitHub last commit](https://img.shields.io/github/last-commit/haywalk/TempleBot)

**Visit the project homepage at [templebot.neocities.org](https://templebot.neocities.org)**

This is an updated and maintained version of TempleBot, the IRC bot written for the
\#templeos channel on Rizon. It was originally written in 2015 by GitHub user RingTech,
whose account has since been deleted.

The bot runs on top of [ii](https://tools.suckless.org/ii/), the Suckless IRC client.
Details about the bot, how to install it, and a list of commands, are available at
[templebot.neocities.org](https://templebot.neocities.org).

In the spirit of TempleOS, this project is dedicated to the public domain.

## Commands

These are all the available commands and their optional arguments:

<dl>
  <dt>!bible / !oracle <i>$LINENUM (default random)</i></dt>
  <dd>Displays line number <i>$LINENUM</i> from the Bible file.</dd>   
  
  <dt>!books</dt>
  <dd>Displays a random passage from a random book</dd>
  
  <dt>!feel</dt>
  <dd>Displays a random emoticon</dd>
  <dt>!happy <i>$NUMBER (default 10) </i></dt>
  <dd>Displays <i>$NUMBER</i> random 'happy' words from God.</dd>
  
  <dt>!help</dt>
  <dd>Displays available commands and description of the bot</dd>
      
  <dt>!movie</dt>
  <dd>Displays the title of a random movie</dd>
      
  <dt>!number <i>$MAX (default 10)</i></dt>
  <dd>Displays a number between 1 and <i>$MAX</i>.</dd>
      
  <dt>!quit / !exit / !stop</dt>
  <dd>Doesn't stop the bot</dd>
      
  <dt>!quote</dt>
  <dd>Displays a random fortune</dd>
      
  <dt>!recipe <i>$NUMBER (default 10)</i></dt>
  <dd>Generates a random recipe made up of <i>$NUMBER</i> ingredients.</dd>
      
  <dt>!restart</dt>
  <dd>Restarts the bot</dd>
      
  <dt>!source</dt>
  <dd>Displays credits and link to source code</dd>
      
  <dt>!words / !God <i>$NUMBER (default 10)</i></dt>
  <dd>Displays <i>$NUMBER</i> random words from God.</dd>
</dl>

## Original Description from 2015

This is TempleBot, written by ring for the #templeos channel at irc.rizon.net.
This script uses ii as its irc client. For setting it up, refer to the documentation of ii. ii can be found at http://tools.suckless.org/ii/.
The script should be run inside the directory of the channel, e.g. "~/irc/irc.rizon.net/#templeos/". This directory should also contain the text files.

I dedicate all copyright interest in this software to the public domain. Do what you want.

This bot uses random numbers to pick lines and words from a few files. You can use this to talk to God, by making an offering to Him first. An offering can be anything that pleases God, like charming conversation or a good question. You can compare this to praying and opening a book at random, and looking at what it says.

## TODO

* ~~Get the bot working~~
* ~~Make homepage and basic documentation~~
* ~~Add comments to source code and clean up formatting~~
* ~~Improve documentation for individual commands on website~~
* Comment and clean up standalone version of the bot
* Begin work on restoring Guest39's version of the bot
