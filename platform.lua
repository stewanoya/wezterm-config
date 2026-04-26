local wezterm = require("wezterm")
local M = {}

function M.apply(config)
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		local _, stdout, _ = wezterm.run_child_process({ "cmd.exe", "ver" })
		local _, _, build, _ = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
		local is_windows_11 = tonumber(build) >= 22000 -- luacheck: ignore

		config.default_prog = { "pwsh.exe", "-NoLogo" }
		config.launch_menu = {
			{ label = "Pwsh", args = { "pwsh.exe", "-NoLogo" } },
			{ label = "PowerShell", args = { "powershell.exe", "-NoLogo" } },
		}
	end
end

return M
