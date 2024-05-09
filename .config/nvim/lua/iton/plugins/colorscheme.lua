return {
  'neanias/everforest-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('everforest').setup({
      transparent_background_level = 2,
      italics = false,
      disable_italic_comments = true,
      sign_column_background = 'none',
      diagnostic_text_highlight = false,
      diagnostic_virtual_text = 'coloured',
      diagnostic_line_highlight = false,
      float_style = 'dim',
      inlay_hints_background = 'none',
      ---You can override specific highlights to use other groups or a hex colour.
      ---This function will be called with the highlights and colour palette tables.
      ---@param highlight_groups Highlights
      ---@param palette Palette
      on_highlights = function(highlight_groups, palette)
        highlight_groups.CursorLine = { bg = palette.none }
      end,
    })
    require('everforest').load()
  end,
}
