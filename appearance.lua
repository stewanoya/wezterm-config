local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	config.color_scheme = "Github Dark (Gogh)"
	config.font = wezterm.font("Hack Nerd Font")
	config.font_size = 10
	config.default_cursor_style = "BlinkingBar"
end

return M
