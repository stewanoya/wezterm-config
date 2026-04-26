local wezterm = require("wezterm")
local config = wezterm.config_builder()

local appearance = require("appearance")
local platform = require("platform")
local startup = require("startup")
local keys = require("keys")

appearance.apply(config)
platform.apply(config)
startup.apply()
keys.apply(config)

return config
