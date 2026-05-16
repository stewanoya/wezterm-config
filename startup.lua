local wezterm = require("wezterm")
local M = {}

function M.apply()
	if wezterm.target_triple:find("windows") then
		require("startup_windows").apply()
	else
		require("startup_linux").apply()
	end
end

return M
