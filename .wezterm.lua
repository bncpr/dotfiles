-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Adventure"
config.default_domain = "WSL:Ubuntu"

config.font = wezterm.font("Hack Nerd Font")
config.window_padding = { top = 0, left = 0, right = 0, bottom = 0 }

-- and finally, return the configuration to wezterm
return config
