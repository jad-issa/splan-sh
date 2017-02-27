#!/bin/sh
IFS=\= read -r key datadir <<< "$(grep datadir $HOME/.splan/splan.conf)"
if test -d $datadir
then
    if [ $# -eq 0 ]
    then
	if [ "$(ls -A $datadir)" ]
	then
		cat $datadir*
	else
		echo "No task is created yet! Go ahead and create one with the \`create\` command!"
	fi
    else
	case $1 in

	"create")
		cat - > $datadir/$RANDOM && echo "Successfully wrote file" && exit 0
		;;
	"clear")
		echo "Are you sure you want to delete all of your tasks?[y/n]"
		read response
		[ $response = "n" ] && exit 1
		[ $response = "y" ] && rm $datadir* && echo "Emptied!" && exit 0
		echo "Invalid input!" && exit 2
		;;
	"help")
		echo "I don't feel like writing a help... I'll write it later..."
	*)
		echo "What? Invalid command! check \`help\`"
		exit 2
		;;
	esac
    fi
	   
else
    mkdir -p $datadir
    echo "Data directory $datadir was not an existing directory."
    echo "Just created $datadir. You may now start planning."
fi
