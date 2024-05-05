NAME=$(grep "config/name" "./project.godot" | sed 's/^.*=//' | sed 's/"//g')
VERSION=$(grep "config/version" "./project.godot" | sed 's/^.*=//' | sed 's/"//g')
DATE="$(date +%s)"
FULL_HASH="$(git log -n 1 --pretty=format:"%H")"
HASH=${FULL_HASH:0:6}

godot_build() {
	local TYPE=$1
	local GODOT_PATH_CREATION=$2
	local BUILD_PATH="./dist/$DATE/$TYPE"
	local ZIP_FILENAME="$NAME ($VERSION) $TYPE.zip"

	# Create path for the build
	mkdir -p "$BUILD_PATH"

	# Make the build
	echo "INFO:: Building $ZIP_FILENAME"
	godot -q --headless --export-release "$TYPE" "$BUILD_PATH/$GODOT_PATH_CREATION"

	# Zip the file
	echo "INFO:: Zipped file $ZIP_FILENAME"
	cd $BUILD_PATH
	zip -q -r "$ZIP_FILENAME" ./
	cd -
	mv "$BUILD_PATH/$ZIP_FILENAME" "./dist/$DATE"

	Remove folder with unzip
	echo "INFO:: Cleaning files \n\n"
	rm -rf "$BUILD_PATH"
}

godot_build		"web"		"index.html"
godot_build		"linux"		"$NAME.x86_64"
godot_build		"mac"		"$NAME.dmg"
godot_build		"win"		"$NAME.exe"

