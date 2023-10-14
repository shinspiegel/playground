class("SelectModeSidebar").extends(Sidebar)

function SelectModeSidebar:init()
	SelectModeSidebar.super.init(self)
end

function SelectModeSidebar:enter(context, selected)
	local config = {
		player = context.player.avatar,
		menuTitle = "Let's play!",
		menuItems = {
			{
				text = "Solve",
				ref = MODE_PLAY,
				selected = selected == MODE_PLAY,
			},
			{
				text = "Sketch",
				ref = MODE_CREATE,
				selected = selected == MODE_CREATE,
			},
			{
				text = "Share",
				ref = MODE_SHARE,
				selected = selected == MODE_SHARE,
			},
			{
				text = "Configure",
				ref = MODE_OPTIONS,
				selected = selected == MODE_OPTIONS,
			},
		}
	}

	SelectModeSidebar.super.enter(self, context, config)
end
