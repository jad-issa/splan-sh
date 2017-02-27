#!/bin/sh
echo "Directory to use for storing data:"
echo "Recommended: $HOME/.splan/data/ [type RETURN to select this]"
echo "Do not include variables such as \$HOME, instead use full path, and include a forward slash at the end."
read directory
[ "$directory" = "" ] && directory=$HOME/.splan/data/ && echo "Chose recommened directory!";
if [ -d $directory ]
then
	if [ $(ls -A $directory) ] 
	then
		echo "Data directory is not an empty directory!"
		echo "Please choose another directory or empty the one chosen!"
		echo "Failure initializing splan!"
		exit 1
	else
		cp res/splan-default.conf $HOME/.splan/splan.conf && echo "Initialized at $HOME/.splan"
		echo "datadir=$directory" >> $HOME/.splan/splan.conf && echo "Successfully written configuration!" && exit 0
	fi
else
	mkdir -p $HOME/.splan && cp res/splan-default.conf $HOME/.splan/splan.conf && echo "Initialized at $HOME/.splan"
	echo "datadir=$directory" >> $HOME/.splan/splan.conf && echo "Successfully written configuration!"
	printf "Creating new data directory..."
	mkdir -p $directory && printf "    done!" && exit 0 || echo "Failed creating directory!" && exit 1
fi
