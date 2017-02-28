#!/bin/sh

# Snippet from Tanktalus at stackoverflow.com

me=`basename "$0"`

# End of snippet


initialize () {
	    
    echo "$me: Directory to use for storing data:"
    echo "$me: Recommended: $HOME/.splan/data/ [type RETURN to select this]"
    echo "$me: Do not include variables such as \$HOME, instead use full path, and include a forward slash at the end."
    read directory
    [ "$directory" = "" ] && directory=$HOME/.splan/data/ && echo "$me: Chose recommened directory!";
    if [ -d $directory ]
    then
	
	if [ $(ls -A $directory) ] 
	then
		echo "$me: Data directory is not an empty directory!"
		echo "$me: Please choose another directory or empty the one chosen!"
		echo "$me: Failure initializing splan!"
		exit 1
		
	else
		cp res/splan-default.conf $HOME/.splan/splan.conf && echo "$me: Initialized at $HOME/.splan"
		echo "datadir=$directory" >> $HOME/.splan/splan.conf && echo "$me: Successfully written configuration!" && exit 0
	fi
	
    else
	cp res/splan-default.conf $HOME/.splan/splan.conf && echo "$me: Initialized at $HOME/.splan"
	echo "datadir=$directory" >> $HOME/.splan/splan.conf && echo "$me: Successfully written configuration!"
	printf "$me: Creating new data directory..."
	mkdir -p $directory && printf "    done!" && exit 0 || echo "$me: Failed creating directory!" && exit 1
    fi
}


if [ -d $HOME/.splan/ ] && [ -e $HOME/.splan/splan.conf ]
then
    
    echo "$me: Configuration already exists."
    echo "$me: Do you want to reinitialize[y/n]?"
    read reinitialize
    case $reinitialize in
	
	"y")
	    initialize
	    ;;
	"n")
	    echo "$me: Then what are you doing with this script? (In case you don't know, you're running init.sh.)"
	    exit 0
	    ;;
	"k")
	    echo "$me: Bayyak k! (For those who don't understand, your answer is not valid, use only 'y' or 'n' and not k.)"
	    exit 2
	    ;;
	*)
	    echo "$me: Invalid answer! Please use 'y' or 'n.' Exiting because of you! :D"
	    exit 2
	    ;;
    esac
    
else
    
    if [ -d $HOME/.splan/ ]
    then
	initialize
    else
	mkdir -p $HOME/.splan/ && initialize
    fi
fi
