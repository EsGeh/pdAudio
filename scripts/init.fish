#!/bin/fish

set BASE_DIR (dirname (readlink -m (status filename)))/..
set SCRIPTS_DIR (dirname (readlink -m (status filename)))
set DEP_DIR_DEFAULT "$BASE_DIR/dependencies"

set get_deps_version "65da50672657e1edaf939291434853ad9fc16ff9"

mkdir -p "$DEP_DIR_DEFAULT"

set get_deps_uri "https://github.com/EsGeh/git_deps/raw/$get_deps_version/get_deps.fish"
begin
	wget \
		--output-document="$DEP_DIR_DEFAULT/get_deps.fish" \
			"$get_deps_uri" 2>/dev/null
	and chmod u+x "$DEP_DIR_DEFAULT/get_deps.fish"
end
or begin
	echo "ERROR while downloading '$repo_uri'"
	exit 1
end

and begin
	eval "$DEP_DIR_DEFAULT/get_deps.fish" $argv
end

# download freeverb
and begin
	set lib_name 'freeverb~-1.2'
	wget \
		--no-clobber \
		--directory-prefix "$DEP_DIR_DEFAULT" \
		"https://sourceforge.net/projects/pure-data/files/libraries/freeverb~/freeverb~-1.2.tar.gz"
	and cd "$DEP_DIR_DEFAULT"
	and tar xvzf "$lib_name.tar.gz"
	and cd "$lib_name"
	and make
end
