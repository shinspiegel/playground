create_icon() {
	rm -rf ./icons
	mkdir -p ./icons

	magick convert $1 -define icon:auto-resize=256,128,64,48,32,16 icons/icon_base.png
	magick convert $1 -define icon:auto-resize=256,128,64,48,32,16 icons/icon_win.ico
	magick convert $1 -define icon:auto-resize=256,128,64,48,32,16 icons/icon_macos.icns
	magick convert $1 -define icon:auto-resize=144 icons/icon_web_144.png
	magick convert $1 -define icon:auto-resize=180 icons/icon_web_180.png
	magick convert $1 -define icon:auto-resize=512 icons/icon_web_512.png
}

create_icon $1
