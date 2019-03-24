#!/bin/fish

set BASE_DIR (dirname (readlink -m (status filename)))/..
set SCRIPTS_DIR (dirname (readlink -m (status filename)))

source "$SCRIPTS_DIR/utils/cmd_args.fish"


#################################################
# variables
#################################################

set install_dest "$BASE_DIR/install"

set patch "audio_doc.pd"

# (syntax: short/long/description)
set options_descr \
	"h/help/print help"

#################################################
# functions
#################################################

function print_help
	echo "usage: "(status -f)" [OPTIONS...] [PATCH]"
	echo
	echo "ARGUMENTS:"
	echo "  the patch to run. default: '$patch'"
	echo "OPTIONS:"
	print_options_descr $options_descr
end


#################################################
# cmd line interface
#################################################

set options (options_descr_to_argparse $options_descr)

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
end

if test (count $argv) -gt 0
	set patch $argv
end

#################################################
# actual script
#################################################

pd \
	-jack \
	-path "$install_dest/pdUtils" \
	-lib zexy \
	-lib structuredDataC \
	-lib sdScript \
	"$install_dest/$patch"
