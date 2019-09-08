#!/bin/fish

set BASE_DIR (dirname (readlink -m (status filename)))/..
set SCRIPTS_DIR (dirname (readlink -m (status filename)))
set DEP_DIR "$BASE_DIR/dependencies"

source "$SCRIPTS_DIR/utils/cmd_args.fish"


#################################################
# variables
#################################################

set install_dest "$BASE_DIR/install"
set dev_version 2

set patch "audio_doc.pd"
# set io_patch

# (syntax: short/long/description)
set options_descr \
	"h/help/print help" \
	"o/pd-options=/options for pd" \
	"v/dev-version=/sgDevice version. default: $dev_version"

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
	if set -q _flag_dev_version
		set dev_version $_flag_dev_version
	end
end

if test (count $argv) -gt 0
	set patch $argv
end

#################################################
# actual script
#################################################


if [ "$dev_version" = 1 ]
	set baud_rate 38400

	status is-full-job-control
	echo "full job control: $status"

	eval "$SCRIPTS_DIR/utils/ttymidi --baudrate=$baud_rate --serialdevice=/dev/ttyACM0 --name=ttymidi_test &"

	set tty_pid (ps -C ttymidi -o pid=)
	# set tty_pid (jobs -l | awk '{print $2}')

	if test "$tty_pid" != ""
		echo "ttymidi pid: $tty_pid"
	else
		echo "WARNING: sgDevice propably unplugged"
	end

	function on_exit
		if test "$tty_pid" != ""
			echo "killing tty ($tty_pid)..."
			kill $tty_pid
			echo "done"
		end
	end

	trap on_exit EXIT
end

set io_patch (string split -r --max=1 '.' "$patch")[1]"-io.pd"
if test -f "$install_dest/$io_patch"
	echo "io-patch: $io_patch"

	## audio:
	pd \
		-noprefs \
		-jack \
		-path "$install_dest/pdUtils" \
		-path "$install_dest/sgDevice" \
		-lib zexy \
		-lib structuredDataC \
		-lib sgDevice \
		"$install_dest/$patch" &

	set pd_pid $last_pid

	## io:
	pd \
		-noprefs \
		-noaudio \
		-alsamidi \
		-mididev 1 \
		-path "$install_dest/pdUtils" \
		-path "$install_dest/sgDevice" \
		-lib zexy \
		-lib structuredDataC \
		-lib sgDevice \
		-send "dev_version $dev_version" \
		"$install_dest/$io_patch" &

	set io_pid $last_pid

else

	set pd_options (string split -- ' ' $_flag_pd_options)

	echo "pd options: '$pd_options', count: "(count $pd_options)

	## audio:
	pd \
		-noprefs \
		-nostdpath \
		-stderr \
		-jack \
		-alsamidi \
		-mididev 1 \
		$pd_options \
		-path "/usr/lib/pd/extra" \
		-path "$install_dest/pdUtils" \
		-path "$install_dest/sgDevice" \
		-path "$DEP_DIR/zexy" \
		-path "$DEP_DIR/freeverb~-1.2" \
		-lib zexy \
		-lib structuredDataC \
		-lib sgDevice \
		-send "dev_version $dev_version" \
		"$install_dest/$patch" &

	set pd_pid $last_pid

end

if [ "$dev_version" = 1 ]

	if test "$tty_pid" != ""
		sleep 1
		aconnect ttymidi_test 'Pure Data'
	end

	wait $pd_pid
	if set -q io_pid
		wait $io_pid
	end
else
	sleep 1
	and aconnect 'sgDevice 2' 'Pure Data'
	wait
end
