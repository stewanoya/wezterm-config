-- The only required line is this one.
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
-- Some empty tables for later use
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	--- Grab the ver info for later use.
	local success, stdout, stderr = wezterm.run_child_process({ "cmd.exe", "ver" })
	local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
	local is_windows_11 = tonumber(build) >= 22000

	--- Set Pwsh as the default on Windows
	config.default_prog = { "pwsh.exe", "-NoLogo" }

	table.insert(launch_menu, {
		label = "Pwsh",
		args = { "pwsh.exe", "-NoLogo" },
	})
	
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
end

--- Default config settings
config.color_scheme = "Github Dark (Gogh)"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 10
config.launch_menu = launch_menu
config.default_cursor_style = "BlinkingBar"
config.disable_default_key_bindings = true

return config
