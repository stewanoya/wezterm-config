local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

function M.apply()
	wezterm.on("gui-startup", function(cmd)
		local tab, pane, _ = mux.spawn_window(cmd or {})
		tab:set_title("     ⚡     ")
		pane:split({
			direction = "Bottom",
			size = 0.30,
		})
	end)
end

return M
