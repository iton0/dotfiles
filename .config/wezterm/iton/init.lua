local config = require('wezterm').config_builder()
require('iton.events')
require('iton.settings').apply(config)
require('iton.keys').apply(config)
return config
