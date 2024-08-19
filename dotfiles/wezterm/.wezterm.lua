local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Batman"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16.0
-- config.line_height = 1.2
-- config.cell_width = 0.95

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
