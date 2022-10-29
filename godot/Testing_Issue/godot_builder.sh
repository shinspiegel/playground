NAME="uteoi"
FULL_HASH="$(git log -n 1 --pretty=format:"%H")"
HASH=${FULL_HASH:0:6}
DATE="$(date +%s)"

godot_build() {
	TYPE=$1
	GODOT_PATH_CREATION=$2
	BUILD_PATH="./build/$DATE/$TYPE"
	ZIP_FILENAME="$NAME.$TYPE.$HASH.zip"

	# Create path for the build
	mkdir -p "$BUILD_PATH"

	# Make the build
	godot -v --quiet --no-window --export "$TYPE" "$BUILD_PATH/$GODOT_PATH_CREATION"

	# Zip the file
	# GameJolt prefer the files in this way
	cd "$BUILD_PATH"
	zip -r "$ZIP_FILENAME" .
	cd -
	mv "$BUILD_PATH/$ZIP_FILENAME" "./build/$DATE/$ZIP_FILENAME"

	# Remove folder with unzip
	rm -rf "$BUILD_PATH"
}

godot_build   "HTML5"   "index.html"
godot_build   "Linux"   "until-the-end-of-it.x86_64"
godot_build   "MacOS"   "until-the-end-of-it.dmg"
godot_build   "Win"     "until-the-end-of-it.exe"
