local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

local function dir_exists(path)
	local ok, _, code = os.rename(path, path)
	return ok or code == 13
end

function M.apply()
	wezterm.on("gui-startup", function(cmd)
		local gems_path = wezterm.home_dir .. "/gems-workspace"
		local has_gems = dir_exists(gems_path)

		local spawn_args = cmd or {}
		if has_gems then
			spawn_args.cwd = gems_path
		end

		local tab, pane, _ = mux.spawn_window(spawn_args)
		tab:set_title("         ⚡         ")

		if has_gems then
			pane:split({
				direction = "Right",
				size = 0.35,
				cwd = gems_path,
				args = { "pwsh.exe", "-NoLogo", "-NoExit", "-Command", "cd '" .. gems_path .. "'; claude" },
			})
		end

		pane:split({
			direction = "Bottom",
			size = 0.30,
			cwd = has_gems and gems_path or nil,
		})
	end)
end

return M
