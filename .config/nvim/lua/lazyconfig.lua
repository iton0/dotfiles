-- Configuration for lazy.nvim
return {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'tokyonight' }
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,    -- Set this to true to enable update checking
    concurrency = 4,   -- You can configure the concurrency here
    notify = false,    -- Receive notifications when updates are found
    frequency = 43200, -- Check for updates every 12 hours
  },
  change_detection = {
    notify = false,
  },
}
