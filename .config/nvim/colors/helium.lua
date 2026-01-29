-- Helium (Zhao): OKLab-perceptual balance for Selenzied-level system focus
local hl = vim.api.nvim_set_hl
local cmd = vim.api.nvim_command
local g = vim.g
local is_light = vim.o.background == "light"

cmd("highlight clear")
if g.syntax_on then
	cmd("syntax reset")
end
g.colors_name = "helium"

-- Palette
local c = is_light
		and {
			bg = "#f1e9d2",
			subtle_bg = "#e5ddc6",
			selection = "#d8cfb7",
			fg = "#343c41",
			teal = "#1e858a",
			green = "#527d2c",
			magenta = "#9b5692",
			muted = "#859296",
			blue = "#2b70af",
			red = "#ba1a31",
			orange = "#a85600",
			yellow = "#846200",
			diff_add = "#e1eddb",
			diff_remove = "#f2e1e1",
		}
	or {
		bg = "#0d2b30",
		subtle_bg = "#16363c",
		selection = "#214a56",
		fg = "#b6c4c6",
		teal = "#469d96",
		green = "#83ad61",
		magenta = "#b692bc",
		muted = "#606e6e",
		blue = "#72a7e2",
		red = "#e68084",
		orange = "#d69466",
		yellow = "#bda043",
		diff_add = "#1a3d31",
		diff_remove = "#441a1a",
	}

-- Core UI
hl(0, "Normal", { fg = c.fg, bg = c.bg })
hl(0, "NormalNC", { link = "Normal" })
hl(0, "Cursor", { fg = c.bg, bg = c.fg })
hl(0, "lCursor", { link = "Cursor" })
hl(0, "TermCursor", { link = "Cursor" })
hl(0, "TermCursorNC", { fg = c.bg, bg = c.muted })
hl(0, "LineNr", { fg = c.muted })
hl(0, "CursorLineNr", { fg = c.fg })
hl(0, "CursorLine", { bg = c.subtle_bg })
hl(0, "CursorColumn", { link = "CursorLine" })
hl(0, "ColorColumn", { link = "CursorLine" })
hl(0, "SignColumn", { bg = "NONE" })
hl(0, "WinSeparator", { fg = c.subtle_bg, bg = "NONE" })
hl(0, "VertSplit", { link = "WinSeparator" })
hl(0, "NonText", { fg = c.muted })
hl(0, "EndOfBuffer", { link = "NonText" })
hl(0, "Whitespace", { link = "NonText" })
hl(0, "SpecialKey", { link = "NonText" })
hl(0, "Conceal", { fg = c.blue })

-- Selection & Search
hl(0, "Visual", { bg = c.selection })
hl(0, "VisualNOS", { link = "Visual" })
hl(0, "Search", { fg = c.yellow, bg = "NONE", reverse = true })
hl(0, "CurSearch", { fg = c.orange, bg = "NONE", reverse = true, bold = true })
hl(0, "IncSearch", { link = "CurSearch" })
hl(0, "Substitute", { fg = c.bg, bg = c.yellow })
hl(0, "SpellBad", { sp = c.magenta, undercurl = true })

-- Menus & Navigation
hl(0, "Pmenu", { fg = c.fg, bg = c.subtle_bg })
hl(0, "PmenuSel", { fg = c.bg, bg = c.fg })
hl(0, "PmenuExtra", { fg = c.muted, bg = c.subtle_bg })
hl(0, "PmenuExtraSel", { fg = c.bg, bg = c.fg })
hl(0, "PmenuSbar", { bg = c.subtle_bg })
hl(0, "PmenuThumb", { bg = c.muted })
hl(0, "WildMenu", { link = "PmenuSel" })
hl(0, "Directory", { fg = c.blue })

-- Floats & Messages
hl(0, "NormalFloat", { link = "Pmenu" })
hl(0, "FloatBorder", { fg = c.muted, bg = c.subtle_bg })
hl(0, "FloatTitle", { fg = c.yellow, bold = true })
hl(0, "StatusLine", { fg = c.fg, bg = c.subtle_bg })
hl(0, "StatusLineNC", { fg = c.muted, bg = c.subtle_bg })
hl(0, "TabLine", { link = "StatusLineNC" })
hl(0, "TabLineFill", { bg = c.subtle_bg })
hl(0, "TabLineSel", { fg = c.fg, bg = c.bg, bold = true })
hl(0, "Folded", { fg = c.muted, bg = c.subtle_bg })
hl(0, "FoldColumn", { fg = c.muted })
hl(0, "MsgArea", { fg = c.fg })
hl(0, "MsgSeparator", { fg = c.muted })
hl(0, "ModeMsg", { fg = c.fg, bold = true })
hl(0, "MoreMsg", { fg = c.blue })
hl(0, "WarningMsg", { fg = c.yellow })
hl(0, "ErrorMsg", { fg = c.red })
hl(0, "Question", { fg = c.magenta })
hl(0, "Title", { fg = c.fg, bold = true })

-- Syntax Base
hl(0, "Comment", { fg = c.orange })
hl(0, "String", { fg = c.green })
hl(0, "Number", { link = "String" })
hl(0, "Boolean", { link = "Number" })
hl(0, "Constant", { link = "Number" })
hl(0, "Type", { fg = c.teal })
hl(0, "Keyword", { fg = c.magenta })
hl(0, "Statement", { link = "Keyword" })
hl(0, "PreProc", { link = "Keyword" })
hl(0, "Include", { fg = c.fg })
hl(0, "Function", { fg = c.fg })
hl(0, "Identifier", { fg = c.fg })
hl(0, "Operator", { fg = c.fg })
hl(0, "Delimiter", { fg = c.fg })
hl(0, "Special", { fg = c.fg })
hl(0, "Todo", { fg = c.bg, bg = c.green })
hl(0, "Error", { fg = c.red, reverse = true })

-- TreeSitter & LSP
hl(0, "@variable", { fg = c.fg })
hl(0, "@variable.builtin", { link = "@variable" })
hl(0, "@variable.parameter", { link = "@variable" })
hl(0, "@member", { link = "@variable" })
hl(0, "@property", { link = "@variable" })
hl(0, "@field", { link = "@variable" })
hl(0, "@tag.attribute", { link = "@variable" })
hl(0, "@lsp.type.variable", { link = "@variable" })
hl(0, "@function", { link = "Function" })
hl(0, "@function.builtin", { link = "Function" })
hl(0, "@function.call", { link = "Function" })
hl(0, "@method", { link = "Function" })
hl(0, "@method.call", { link = "Function" })
hl(0, "@lsp.type.function", { link = "Function" })
hl(0, "@lsp.type.method", { link = "Function" })
hl(0, "@lsp.type.class", { link = "Function" })
hl(0, "@constructor", { fg = c.fg })
hl(0, "@keyword", { link = "Keyword" })
hl(0, "@keyword.function", { link = "Keyword" })
hl(0, "@keyword.return", { link = "Keyword" })
hl(0, "@tag", { link = "Keyword" })
hl(0, "@label", { link = "Keyword" })
hl(0, "@operator", { link = "Operator" })
hl(0, "@punctuation.bracket", { link = "Delimiter" })
hl(0, "@punctuation.delimiter", { link = "Delimiter" })
hl(0, "@tag.delimiter", { fg = c.muted })
hl(0, "@string", { link = "String" })
hl(0, "@string.escape", { link = "String" })
hl(0, "@comment", { link = "Comment" })
hl(0, "@lsp.type.comment", { link = "Comment" })

-- Diagnostics
hl(0, "DiagnosticOk", { fg = c.green })
hl(0, "DiagnosticError", { fg = c.red, bold = true })
hl(0, "DiagnosticWarn", { fg = c.yellow })
hl(0, "DiagnosticInfo", { fg = c.blue })
hl(0, "DiagnosticHint", { fg = c.green })
hl(0, "DiagnosticVirtualTextError", { fg = c.red, bg = c.subtle_bg, bold = true })
hl(0, "DiagnosticVirtualTextWarn", { fg = c.yellow, bg = c.subtle_bg })
hl(0, "DiagnosticVirtualTextInfo", { fg = c.blue, bg = c.subtle_bg })
hl(0, "DiagnosticVirtualTextHint", { fg = c.green, bg = c.subtle_bg })
hl(0, "DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hl(0, "DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })
hl(0, "DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hl(0, "DiagnosticUnderlineHint", { sp = c.green, undercurl = true })

-- Diff
hl(0, "DiffAdd", { fg = c.green, bg = c.diff_add })
hl(0, "DiffDelete", { fg = c.red, bg = c.diff_remove })
hl(0, "DiffChange", { fg = c.yellow, bg = c.subtle_bg })
hl(0, "DiffText", { fg = c.bg, bg = c.blue })
hl(0, "@diff.plus", { link = "DiffAdd" })
hl(0, "@diff.minus", { link = "DiffDelete" })
hl(0, "diffAdded", { link = "DiffAdd" })
hl(0, "diffRemoved", { link = "DiffDelete" })
hl(0, "diffChanged", { link = "DiffChange" })

-- Plugins
hl(0, "MiniPickMatchCurrent", { bg = c.selection })
hl(0, "MiniPickMatchRanges", { fg = c.blue })
