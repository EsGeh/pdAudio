#!/bin/fish

########################################
# dependencies of this repository
########################################

set dependencies \
	fishshell_cmd_opts \
	pdUtils \
	sgDevice

# for every entry in $dependencies:
# 	name uri version [initcommand]
set fishshell_cmd_opts \
	fishshell-cmd-opts  \
	https://github.com/EsGeh/fishshell-cmd-opts.git \
	e446daf1741b416ecb83e4741b4cb7f99645bc11
set pdUtils \
	pdUtils \
	https://github.com/EsGeh/pdUtils.git \
	65716466121672f55ea028b718021b0758e852df \
	"scripts/init.fish --deps-dir \$DEP_DIR"
set sgDevice \
	sgDevice \
	https://github.com/EsGeh/sgDevice.git \
	a902497cbea3c0106ffe767d71163200f1555a73 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
