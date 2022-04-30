GAME_FILE=a_witch_call
BUILD_PATH=./Build

godot_build_project() {
  if [ ! -d $BUILD_PATH ]; then mkdir -p $BUILD_PATH; fi
  if [ ! -d $BUILD_PATH/$2 ]; then mkdir -p $BUILD_PATH/$2; fi

  godot_mono --export "$1" $BUILD_PATH/$2/$3

  zip $BUILD_PATH/$2/$4.zip $BUILD_PATH/$2/*

  mv $BUILD_PATH/$2/$4.zip $BUILD_PATH/$4.zip

  rm -rf $BUILD_PATH/$2
}

# Clean old builds
if [ -d $BUILD_PATH ]; then
  rm -rf $BUILD_PATH
fi

godot_build_project "HTML5" "html" "index.html" "$GAME_FILE.html"
godot_build_project "Linux/X11" "unix" "$GAME_FILE.x86_64" "$GAME_FILE.unix"
godot_build_project "Mac OSX" "macos" "$GAME_FILE.zip" "$GAME_FILE.macos"
godot_build_project "Windows Desktop" "win" "$GAME_FILE.exe" "$GAME_FILE.win"
