#!/bin/bash

# check dependency for given module and create RELEASE.local file.

# define a dict form module to modules_dependency. 
# set this variable if add new module that has module dependecy with other modules.
declare -A module_dict
module_dict["StreamDevice"]="asyn " 

# define a dict form path name to module name.
# set this variable if add new modules.
declare -A path_name
path_name["asyn"]="ASYN"



script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)

if [ $EPICS_BASE ]
then 
	echo EPICS_BASE=$EPICS_BASE > $script_dir/RELEASE.local
else

	echo EPICS_BASE not defined in system.
	exit 1
fi

modules_needed=${module_dict["$1"]}
read -ra modules_needed <<< "$modules_needed"

if [ -n "${modules_needed[*]}" ]
then
for module in "${modules_needed[@]}"
do	
	pkg=`ls | grep -i $module`
	if test -n "$pkg" -a -d "$pkg/lib"
	then 
		echo ${path_name["$module"]}=$script_dir/$pkg >> $script_dir/RELEASE.local
		echo package \""$module"\" needed by \""$1"\".
	elif test  -n "$pkg" -a ! -d "$pkg/lib"
	then
		echo package \""$module"\" found but not an epics module.
		exit 1
	else
		echo package \""$module"\" not found.
		exit 1
	fi
done 
else
echo package \""$1"\" needs no other package.
fi





