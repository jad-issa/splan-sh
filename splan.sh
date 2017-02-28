#!/bin/sh

# Read data directory
IFS=\= read -r key datadir <<< "$(grep datadir $HOME/.splan/splan.conf)"

if [ -d $datadir ]
then
    
    if [ $# -eq 0 ]
    then
	
	if [ "$(ls -A $datadir)" ]
	then
	    # Print the task list
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
