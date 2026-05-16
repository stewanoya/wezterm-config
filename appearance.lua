local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	config.color_scheme = "Github Dark (Gogh)"
	config.font = wezterm.font("Hack Nerd Font")
	config.font_size = 10
	config.default_cursor_style = "BlinkingBar"

	-- WebGPU conflicts with KDE Wayland's DRM syncobj protocol
	if wezterm.target_triple:find("linux") then
		config.front_end = "OpenGL"
	end
end

return M
