#!/bin/fish


set BASE_DIR (dirname (readlink -m (status filename)))/..
set SCRIPTS_DIR (dirname (readlink -m (status filename)))
set DEP_DIR_DEFAULT "$BASE_DIR/dependencies"

source "$BASE_DIR/dependencies.fish"

# (syntax: short/long/description)
set options \
	'h/help' \
	"d/deps-dir="

#################################################
# functions
#################################################

function print_help
	echo "usage: "(status -f)" [OPTIONS...]"
	echo
	echo "OPTIONS:"
	echo "  -h | --help"
	echo "  -d | --deps-dir"
end

#################################################
# cmd line interface
#################################################

# parse command line arguments:
argparse $options -- $argv 2>/dev/null
or begin
	print_help
	exit 1
end
if set -q _flag_h
	print_help
	exit 0
else
	if set -q _flag_deps_dir
		set deps_dir $_flag_deps_dir
	end
end

#################################################
# actual script
#################################################

if set -q deps_dir
	set DEP_DIR $deps_dir
else
	set DEP_DIR $DEP_DIR_DEFAULT
end

mkdir -p -v $DEP_DIR


# check and install dependencies if necessary:
cd "$DEP_DIR"
echo (pwd)
and begin
	for dep in $dependencies
		set lib_name $$dep[1][1]
		set lib_url $$dep[1][2]
		set lib_version $$dep[1][3]
		if [ $$dep[1][3] != "" ]
			set init_cmd $$dep[1][4]
		end

		echo "dependency: $dep"
		echo "url: $lib_url, version: $lib_version"
	
		# download if missing:
		if [ -d "$DEP_DIR/$lib_name" ]
			echo "found in $DEP_DIR/$lib_name"
		else
			git clone "$lib_url"
			cd "$lib_name/"
			git checkout "$lib_version"
			cd -
		end
		# check if we have the correct version:
		cd "$lib_name"
		if [ (git rev-parse HEAD) != $lib_version ]
			echo "$lib_name: ERROR: incompatible versions. Try cleaning $DEP_DIR and run again!"
		else
			echo "$lib_name is up to date"
		end
		# call init script:
		if set -q init_cmd
			set init_cmd (echo $init_cmd | sed "s:\$DEP_DIR:$DEP_DIR:g")
			echo "calling '$init_cmd' ..."
			eval "$init_cmd"
		end
		cd -
	end
end
cd "$BASE_DIR"

# update link to fish utilities:
if [ $DEP_DIR != $DEP_DIR_DEFAULT ]
	rm $SCRIPTS_DIR/utils/cmd_args.fish
	ln -s (readlink -m $DEP_DIR/fishshell-cmd-opts/cmd_args.fish) $SCRIPTS_DIR/utils/cmd_args.fish
end
