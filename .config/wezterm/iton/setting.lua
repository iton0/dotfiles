local M = {}
local util = require("iton.util")

M.apply = function(config)
	config.color_scheme = util.dark_scheme
	config.warn_about_missing_glyphs = false
	config.harfbuzz_features = { "calt=0" }
	config.font_size = 20.5
	config.animation_fps = 1
	config.max_fps = 30
	config.audible_bell = "Disabled"
	config.default_workspace = "HOME"
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
end

return M
