local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

local function dir_exists(path)
	local ok, _, code = os.rename(path, path)
	return ok or code == 13
end

local function cmd_exists(cmd)
	local ok, _, _ = wezterm.run_child_process({ "which", cmd })
	return ok
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

		local has_zsh = cmd_exists("zsh")
		local has_omz = dir_exists(wezterm.home_dir .. "/.oh-my-zsh")

		local bottom_args = { "zsh" }
		local bottom_size = 0.30

		if has_zsh and not has_omz then
			bottom_size = 0.40
			bottom_args = {
				"zsh", "-c",
				[[
printf "\nOh My Zsh is not installed.\nWould you like to install it? [y/N] "
read choice
case "$choice" in
  y|Y)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ;;
  *)
    echo "Skipping Oh My Zsh installation."
    sleep 2
    ;;
esac
exec zsh
]],
			}
		end

		pane:split({
			direction = "Bottom",
			size = bottom_size,
			cwd = has_gems and gems_path or nil,
			args = bottom_args,
		})
	end)
end

return M
