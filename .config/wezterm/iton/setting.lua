local M = {}
M.apply = function(config)
	config.color_scheme = require("iton.util").dark_scheme
	config.warn_about_missing_glyphs = false
	config.harfbuzz_features = { "calt=0" }
	config.font_size = 25
	config.audible_bell = "Disabled"
	config.default_workspace = "HOME"
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.window_padding = { top = "0cell", bottom = "0cell" }
end
return M
