#!/usr/bin/env bash

# [$1]: Version
# [$2]: Game Name

NAME="Untitle Infinity Runner"
VERSION=$(head -n 1 VERSION.txt)
DATE="$(date +%s)"
FULL_HASH="$(git log -n 1 --pretty=format:"%H")"
HASH=${FULL_HASH:0:6}

if [ "$2" ]; then
	NAME="$2"
fi

if [ "$1" ]; then
	VERSION="$1"
fi

# [$1] Named OS type in the export screen
# [$2] Filename to be generated
godot_build() {
	GODOT_PATH_CREATION=$2
	TYPE=$1
	BUILD_PATH="./dist/$DATE/$TYPE"
	ZIP_FILENAME="$NAME ($VERSION) $TYPE.zip"

	# Create path for the build
	mkdir -p "$BUILD_PATH"

	# Make the build
	echo "INFO:: Building $ZIP_FILENAME"
	godot -q --headless --export-release "$TYPE" "$BUILD_PATH/$GODOT_PATH_CREATION"

	# Zip the file
	echo "INFO:: Zipped file $ZIP_FILENAME"
	zip -q -r "./dist/$DATE/$ZIP_FILENAME" "$BUILD_PATH"
	
	# Remove folder with unzip
	echo "INFO:: Cleaning files"
	rm -rf "$BUILD_PATH"
	echo ""
}

godot_build		"html5"		"index.html"
godot_build		"linux"		"$NAME.x86_64"
godot_build		"macos"		"$NAME.dmg"
godot_build		"win"		"$NAME.exe"

