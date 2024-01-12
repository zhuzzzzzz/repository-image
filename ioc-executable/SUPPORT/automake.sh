#!/bin/bash

# ordered name(path name) list of modules to install, set this variable if add new modules.
#modules_to_install=("asyn" "StreamDevice")
modules_to_install=("seq" "asyn" "autosave" "caPutLog" "iocStats" "StreamDevice")


script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)


# check modules and execute make to install, accept only one input arg: relative module dir path.
check_install(){
if test $# -eq 0 
then
	echo check_install got no input argument.
elif test $# -gt 1 
then
	echo check_install only accpet one argument, but "$#" were given: "$*".
else
	#echo `readlink -f $1`
	# if a sub-directory lib/ exists, assume it has been installed.
	if test -d $1 -a -d $1/lib
	then
		echo $1 has already installed, skipped.
	elif test -d $1
	then
		echo Move to path $1/ and execute make to install.
		cd $script_dir/$1
		make
		if test $? -eq 0
		then
			echo $1 successfully installed.
		else
			echo $1 install failed.
		fi
		cd $script_dir
	fi
fi
}


for item in ${modules_to_install[*]}
do
	./checkDependency.sh $item
	if [ $? -eq 0 ]
	then
		pkg=`ls | grep -i $item`
		if test -z $pkg
		then
			echo $item was set to install, but not found!
		else
			check_install $pkg
		fi
	else
		echo "dependency check failed for $item, execute automake.sh stopped."
	fi
done






