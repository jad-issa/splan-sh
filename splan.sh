#!/bin/sh

# Read data directory
if [ -d $HOME/.splan/ ]
then
    if [ -e $HOME/.splan/splan.conf ]
    then
	IFS=\= read -r key datadir <<< "$(grep datadir $HOME/.splan/splan.conf)"
    else
	echo "Did not find configuration file! Did you install it correctly?"
	exit 32
    fi
else
    echo "Did not find ~/.splan/ directory! Did you install it correctly?"
    exit 32
fi	  

if [ -d $datadir ]
then
    if [ $# -eq 0 ]
    then
	
	if [ "$(ls -A $datadir)" ]
	then
	    for file in $datadir*
	    do
		echo
		echo $file
		cat $file
	    done
	else
	    echo "No task is created yet! Go ahead and create one with the \`create\` command!"
	fi
	
    else
	case $1 in

	"create")
	    cat - > $datadir/$RANDOM && echo "Successfully written file" && exit 0
	    ;;
	"remove")
	    if [ "$2" = "" ]
	    then
		echo "No task is given to be removed!"
		echo "Synopsis: "
		echo "splan remove task-id"
		exit 2
	    else
		if [ -e $datadir$2 ]
		then
		    if [ -d $datadir$2 ]
		    then
			echo "Are you trying to remove a directory?"
			exit 2
		    else
			rm $datadir$2
			echo "Successfully removed task $2!"
			exit 0
		    fi
		else
		    echo "Unable to remove unexistant task $2"
		    exit 2
		fi
	    fi
	    ;;
	"clear")
	    echo "Are you sure you want to delete all of your tasks?[y/n]"
	    read response
	    [ $response = "n" ] && exit 1
	    [ $response = "y" ] && rm $datadir* && echo "Emptied!" && exit 0
	    echo "Invalid input!" && exit 2
	    ;;
	"help")
	    echo "I hate writing help (but I love reading it.) I should write it someday..."
	    echo "If you feel like doing some good to another human being, write it for me\
 on Github (https://github.com/FOSS-the-world/splan-sh) Thanks :)"
	    echo "Also, if you like documentation, you can write manpages for me and help me incorporate them :D"
	    exit 0 # Do I choose a non-zero number, because help is not successul...
	    ;;
	*)
	    echo "What? Invalid command! check \`help\`"
	    exit 2
	    ;;
	esac
    fi
    
else
    echo "Cannot find data directory, did you initialize (and configure) the program?"
    echo "If you used install.sh, then you did."
    echo "If it is so, then... we don't know what happened... Just try reinstalling or something... Look into the source code in the worst case scenario."
    exit 32; # 32 means the error is just too weird and unexpected...
fi
