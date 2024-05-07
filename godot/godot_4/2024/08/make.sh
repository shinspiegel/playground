# Global variables for project
GODOT_PRROJECT_NAME=$(grep "config/name" "./project.godot" | sed 's/^.*=//' | sed 's/"//g')
GODOT_PROJECT_VERSION=$(grep "config/version" "./project.godot" | sed 's/^.*=//' | sed 's/"//g')
GODOT_PROJECT_DATE="$(date +%s)"

# Helper function to generate the build process
# $1: Name in the export.cfg needs to match
# $2: Filename for the generation
godot_build() {
	local TYPE=$1
	local GODOT_PATH_CREATION=$2
	local BUILD_PATH="./dist/$GODOT_PROJECT_DATE/$TYPE"
	local ZIP_FILENAME="$GODOT_PRROJECT_NAME ($GODOT_PROJECT_VERSION) $TYPE.zip"

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
	mv "$BUILD_PATH/$ZIP_FILENAME" "./dist/$GODOT_PROJECT_DATE"

	Remove folder with unzip
	echo "INFO:: Cleaning files \n\n"
	rm -rf "$BUILD_PATH"
}

godot_build		"web"		"index.html"
# godot_build		"linux"		"$GODOT_PRROJECT_NAME.x86_64"
# godot_build		"mac"		"$GODOT_PRROJECT_NAME.dmg"
# godot_build		"win"		"$GODOT_PRROJECT_NAME.exe"

