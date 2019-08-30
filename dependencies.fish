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
	5a3a83c053c8d1db075c45d35693e092a47fad75 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
set sgDevice \
	sgDevice \
	https://github.com/EsGeh/sgDevice.git \
	91c7b096a86661ae18a94bf3c80123458df9258d \
	"scripts/init.fish --deps-dir \$DEP_DIR"
