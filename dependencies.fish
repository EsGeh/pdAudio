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
	91a845eb8d8859a19f7bc33d2a2633b950476fd9 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
set sgDevice \
	sgDevice \
	https://github.com/EsGeh/sgDevice.git \
	9c1f990e699bef84f340adb7e43fc41af130a277 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
