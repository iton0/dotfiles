local M = {}
local utils = require("iton.utils")

M.apply = function(config)
	---

	-- Colorscheme
	config.color_scheme = utils.dark_scheme

	-- Visual
	config.warn_about_missing_glyphs = false
	config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	config.font_size = 16.4

	-- Window
	config.audible_bell = "Disabled"
	config.default_workspace = "HOME"
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
	---
end

return M
