#!/bin/fish

set BASE_DIR (dirname (readlink -m (status filename)))/..
set DEP_DIR $BASE_DIR/dependencies

set install_dest "$BASE_DIR/install"

pd \
	-jack \
	-path "$install_dest/pdUtils" \
	-lib zexy \
	-lib structuredDataC \
	-lib sdScript \
	"$install_dest/audio_doc.pd"
