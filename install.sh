#!/bin/sh

# Snippet by Tanktalus at stackoverflow.com

me=`basename "$0"`

# End of snippet

# Warning not to be root


if [ $UID -eq 0 ]
then
    echo "$me: WARNING: You have root permissions!"
    echo "$me: Do you want to continue[y/n]? I don't know what might happen if anything fails to run right!"
    read continue
    case $continue in
	"y")
	    echo "$me: OK, then... You take care of what might happen!"
	    ;;
	"n")
	    echo "$me: Better safe than sorry!"
	    exit 4
	    ;;
	*)
	    echo "$me: Invalid input! Please use only 'y' or 'n'!"
	    exit 2
	    ;;
    esac
fi

echo "$me: Running initialization script..."

# Installation procedure
installsplan () {
    echo "$me: copying splan.sh to $installdir. Let's hope it works!"
    if cp splan.sh $installdir/splan
    then
	echo "$me: Congrats! It worked!"
    else
	echo "$me: Sorry it failed!"
	exit 32
    fi
}

# Extract necessary data

echo "$me: Where do you want to store the executable? [/usr/bin] (it might be helpful to choose a directory in PATH)"
echo "$me: PATH: $PATH"
echo "$me: Don't include a slash at the end."
echo "$me: Directory needs to already exist!"
echo "$me: One more thing: don't use variable such as $HOME, use full path."
read installdir
[ $installdir = "" ] && installdir=/usr/bin

echo "$me: Does this directory need root permissions to be written on? [y/n]"
echo "$me: WARNING: the script is yet unstable and giving it root permissions may prove to be unwanted!"
read rootpermissions

case $rootpermissions in
    "y")
	echo "$me: OK, then we'll use sudo"
	echo "$me: Note: only the main executable will be included; if you want to reconfigure or anything, return to the original code."
	if sh init.sh # init.sh shouldn't be run with root priviledges!
	then
	    sudo installsplan && echo "$me: Installation complete! Thank you! LICENSE: GPL3.0" && exit 0
	else
	    echo "$me: Initialization unsuccessul; see errors givin by init script."
	    exit 32
	fi
	;;
    "n")
	echo "$me: Better not (safer because the software isn't so stable just yet)"
	echo "$me: Note: only the main executable will be included; if you want to reconfigure or anything, return to the original code."
	if sh init.sh # init.sh shouldn't be run with root priviledges!
	then
	    installsplan && echo "$me: Installation complete! Thank you! LICENSE: GPL3.0" && exit 0
	else
	    echo "$me: Initialization unsuccessul; see errors givin by init script."
	    exit 32
	fi
	;;
    *)
	echo "$me: Invalid input! Please use only 'y' or 'n'."
	exit 2
	;;
esac
