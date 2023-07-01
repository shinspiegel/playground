NAME="Vampire_Debt"
VERSION="0.0.0"
DATE="$(date +%s)"
FULL_HASH="$(git log -n 1 --pretty=format:"%H")"
HASH=${FULL_HASH:0:6}

if [ "$2" ]; then
  NAME="$2"
fi

if [ "$1" ]; then
  VERSION="$1"
fi

godot_build() {
	GODOT_PATH_CREATION=$2
	TYPE=$1
	BUILD_PATH="./dist/$DATE/$TYPE"
  ZIP_FILENAME="$NAME ($VERSION) $TYPE.zip"

  # Create path for the build
	mkdir -p "$BUILD_PATH"

	# Make the build
  echo "INFO:: Building    $ZIP_FILENAME"
	godot -q --headless --export-release "$TYPE" "$BUILD_PATH/$GODOT_PATH_CREATION"

	# Zip the file
  echo "INFO:: Zipped file $ZIP_FILENAME"
  zip -q -r "./dist/$DATE/$ZIP_FILENAME" "$BUILD_PATH"
  
	# Remove folder with unzip
  echo "INFO:: Cleaning files \n\n"
  rm -rf "$BUILD_PATH"
}

godot_build   "HTML5"   "index.html"
godot_build   "Linux"   "$NAME.x86_64"
godot_build   "MacOS"   "$NAME.dmg"
godot_build   "Win"     "$NAME.exe"

