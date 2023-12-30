return {
  -- Better notification manager
  'rcarriga/nvim-notify',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    background_colour = '#000000',
    fps = 5,
    render = 'wrapped-compact',
    minimum_width = 25,
    stages = 'static',
    timeout = 3000,
  },
}
