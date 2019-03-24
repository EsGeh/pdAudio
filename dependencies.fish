#!/bin/fish

########################################
# dependencies of this repository
########################################

set dependencies \
	fishshell_cmd_opts \
	pdUtils 

# for every entry in $dependencies:
# 	name uri version [initcommand]
set fishshell_cmd_opts \
	fishshell-cmd-opts  \
	git@github.com:EsGeh/fishshell-cmd-opts.git	\
	e446daf1741b416ecb83e4741b4cb7f99645bc11
set pdUtils \
	pdUtils \
	git@github.com:EsGeh/pdUtils.git	\
	b3d87f37d5782ebf6a00f003068ed6429f44a006 \
	"scripts/init.fish --deps-dir \$DEP_DIR"
