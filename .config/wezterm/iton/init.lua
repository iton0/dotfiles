local config = require("wezterm").config_builder()
require("iton.setting").apply(config)
require("iton.event")
require("iton.key").apply(config)
return config
