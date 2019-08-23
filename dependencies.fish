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
	7ce6e562ec94d406b77170ff73a4d38fa6a0b6f3 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
set sgDevice \
	sgDevice \
	https://github.com/EsGeh/sgDevice.git \
	64c9aa9f89836e452342c9507e2e31fcc6395fda \
	"scripts/init.fish --deps-dir \$DEP_DIR"
