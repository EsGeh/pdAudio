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
	5c5a4351592b5fda152be7d3a6b85fc5275b71b7 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
set sgDevice \
	sgDevice \
	https://github.com/EsGeh/sgDevice.git \
	c8c421e8de5703c7a6a4d5d440547c71d92807df \
	"scripts/init.fish --deps-dir \$DEP_DIR"
