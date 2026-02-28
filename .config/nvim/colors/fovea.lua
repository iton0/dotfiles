-- Name: Fovea
-- Strategy: Foveal Attention + Pre-attentive Meta-Filtering
-- Criteria: APCA-Contrast + OKLCH Perceptual Balance

local palette = {
	dark = {
		-- Base & Neutral
		background = "#1a1b26",
		foreground = "#cfc9c2",

		-- Balanced Semantic Pillars
		keyword = "#d5befc",
		type = "#68def1",
		string = "#a6d588",
		comment = "#565f89",

		-- Balanced Diagnostics
		error = "#fd8493",
		warn = "#f0b86a",
		info = "#b2c7fd",
		hint = "#4cd7bb",

		-- UI Layering
		surface = "#24283b",
		gutter = "#1f2335",
		border = "#3b4261",
		accent = "#2e3c64",

		-- Diff Layers
		diff_add = "#283b31",
		diff_del = "#3f2d3d",
		diff_chg = "#4a4430",
	},
	light = {
		-- Base & Neutral
		background = "#faf8f5",
		foreground = "#373b41",

		-- Balanced Semantic Pillars
		keyword = "#7437cc",
		type = "#006789",
		string = "#388e3c",
		comment = "#8e95b3",

		-- Balanced Diagnostics
		error = "#b03038",
		warn = "#825300",
		info = "#0065a7",
		hint = "#007158",

		-- UI Layering
		surface = "#f0ede9",
		gutter = "#e8e5e1",
		border = "#d1d1d1",
		accent = "#d8d5d1",

		-- Diff Layers
		diff_add = "#e1f0e1",
		diff_del = "#f0e1e1",
		diff_chg = "#f9f0c2",
	},
}

local color = vim.o.background == "light" and palette.light or palette.dark

local highlight_groups = {
	-- === CORE UI ===
	Normal = { fg = color.foreground, bg = color.background },
	NormalNC = { fg = color.comment, bg = color.background },
	NormalFloat = { fg = color.foreground, bg = color.surface },
	FloatBorder = { fg = color.border, bg = color.surface },
	CursorLine = { bg = color.surface },
	LineNr = { fg = color.comment },
	Title = { fg = color.foreground, bg = color.surface, bold = true },
	CursorLineNr = { fg = color.type, bold = true },
	VertSplit = { fg = color.border },
	WinSeparator = { fg = color.border },
	Pmenu = { fg = color.foreground, bg = color.surface },
	PmenuSel = { fg = color.type, bg = color.accent, bold = true },
	Search = { fg = color.background, bg = color.warn },
	Visual = { bg = color.accent },
	Folded = { fg = color.comment, bg = color.surface },
	Question = { fg = color.type },
	MoreMsg = { fg = color.type, bold = true },
	WarningMsg = { fg = color.warn, bold = true },
	ErrorMsg = { fg = color.error, bold = true },
	CurSearch = { fg = color.background, bg = color.keyword, bold = true },
	IncSearch = { link = "CurSearch" },
	Todo = { link = "Comment" },
	MsgSeparator = { fg = color.border, bg = color.gutter },
	MatchParen = { fg = color.type, bold = true, underline = true },
	ModeMsg = { fg = color.foreground, bold = true },
	MsgArea = { fg = color.foreground },
	Directory = { fg = color.type, bold = true },
	StatusLine = { fg = color.type, bg = color.surface, bold = true },
	StatusLineNC = { fg = color.comment, bg = color.gutter },
	TabLine = { fg = color.comment, bg = color.gutter },
	TabLineFill = { bg = color.background },
	TabLineSel = { fg = color.background, bg = color.type, bold = true },
	NonText = { fg = color.gutter },
	EndOfBuffer = { link = "NonText" },
	SignColumn = { bg = color.background },
	FoldColumn = { bg = color.background },

	-- === THE 4 SEMANTIC PILLARS ===
	Keyword = { fg = color.keyword },
	Statement = { link = "Keyword" },
	Conditional = { link = "Keyword" },
	Repeat = { link = "Keyword" },
	Label = { link = "Keyword" },
	Operator = { fg = color.foreground },
	Exception = { link = "Keyword" },

	Type = { fg = color.foreground },
	StorageClass = { link = "Type" },
	Structure = { link = "Type" },
	Typedef = { link = "Type" },

	String = { fg = color.string },
	Character = { link = "String" },
	Number = { link = "String" },
	Boolean = { link = "String" },
	Float = { link = "String" },
	Constant = { link = "String" },

	Comment = { fg = color.comment },
	Special = { fg = color.comment },
	Debug = { fg = color.keyword },
	Delimiter = { fg = color.comment },

	-- Identifier/Functions
	Identifier = { fg = color.foreground },
	Function = { fg = color.foreground },
	PreProc = { fg = color.keyword },
	Include = { fg = color.keyword },
	Define = { fg = color.keyword },
	Macro = { fg = color.keyword },
	Tag = { fg = color.keyword },

	-- === DIAGNOSTICS ===
	DiagnosticOk = { fg = color.hint },
	DiagnosticUnnecessary = { link = "DiagnosticDeprecated" },
	DiagnosticError = { fg = color.error, bold = true },
	DiagnosticWarn = { fg = color.warn },
	DiagnosticInfo = { fg = color.info },
	DiagnosticHint = { fg = color.hint },
	DiagnosticUnderlineError = { sp = color.error, undercurl = true },
	DiagnosticUnderlineWarn = { sp = color.warn, undercurl = true },
	DiagnosticUnderlineInfo = { sp = color.info, undercurl = true },
	DiagnosticUnderlineHint = { sp = color.hint, undercurl = true },
	DiagnosticVirtualTextError = { fg = color.error, bg = color.surface },
	DiagnosticVirtualTextWarn = { fg = color.warn, bg = color.surface },
	DiagnosticVirtualTextInfo = { fg = color.info, bg = color.surface },
	DiagnosticVirtualTextHint = { fg = color.hint, bg = color.surface },

	-- === DIFF MODE ===
	DiffAdd = { bg = color.diff_add },
	DiffDelete = { bg = color.diff_del },
	DiffChange = { bg = color.diff_chg },
	DiffText = { bg = color.accent, fg = color.foreground, bold = true },
	["@diff.plus"] = { link = "DiffAdd" },
	["@diff.minus"] = { link = "DiffDelete" },
	["@diff.delta"] = { link = "DiffChange" },
	["diffAdded"] = { link = "DiffAdd" },
	["diffRemoved"] = { link = "DiffDelete" },
	["diffChanged"] = { link = "DiffChange" },

	-- === QUICKFIX ===
	QuickFixLine = { bg = color.accent, bold = true },
	qfFileName = { fg = color.type },
	qfLineNr = { fg = color.comment },
	qfError = { fg = color.error },

	-- === TREESITTER & LSP ===
	["@variable"] = { fg = color.foreground },
	["@variable.builtin"] = { fg = color.keyword },
	["@variable.parameter"] = { fg = color.foreground },
	["@variable.member"] = { fg = color.foreground },
	["@property"] = { fg = color.foreground },

	["@constant"] = { link = "Constant" },
	["@constant.builtin"] = { link = "Constant" },
	["@constant.macro"] = { link = "Macro" },

	["@module"] = { fg = color.foreground },
	["@module.builtin"] = { fg = color.foreground },
	["@label"] = { link = "Label" },

	["@string"] = { link = "String" },
	["@string.documentation"] = { fg = color.string, italic = true },
	["@string.regexp"] = { fg = color.warn },
	["@string.escape"] = { fg = color.keyword },
	["@string.special"] = { link = "Special" },
	["@character"] = { link = "String" },
	["@character.special"] = { link = "Special" },

	["@type"] = { link = "Type" },
	["@type.builtin"] = { link = "Type" },
	["@type.definition"] = { link = "Typedef" },
	["@attribute"] = { fg = color.keyword },
	["@attribute.builtin"] = { fg = color.keyword },

	["@function"] = { link = "Function" },
	["@function.builtin"] = { link = "Function" },
	["@function.call"] = { link = "Function" },
	["@function.macro"] = { link = "Macro" },
	["@function.method"] = { link = "Function" },
	["@function.method.call"] = { link = "Function" },
	["@constructor"] = { link = "Function" },

	["@keyword"] = { link = "Keyword" },
	["@keyword.function"] = { link = "Keyword" },
	["@keyword.operator"] = { link = "Operator" },
	["@keyword.import"] = { link = "Include" },
	["@operator"] = { link = "Operator" },

	["@punctuation.delimiter"] = { link = "Delimiter" },
	["@punctuation.bracket"] = { link = "Delimiter" },
	["@punctuation.special"] = { link = "Special" },

	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.heading"] = { fg = color.keyword, bold = true },
	["@markup.raw"] = { bg = color.surface },
	["@markup.link.url"] = { fg = color.info, underline = true },

	["@comment"] = { link = "Comment" },
	["@comment.todo"] = { link = "Comment" },
	["@comment.note"] = { link = "Comment" },
	["@comment.error"] = { link = "Comment" },
	["@comment.warning"] = { link = "Comment" },

	["@lsp.type.class"] = { link = "Structure" },
	["@lsp.type.decorator"] = { link = "@attribute" },
	["@lsp.type.enum"] = { link = "Structure" },
	["@lsp.type.enumMember"] = { link = "Constant" },
	["@lsp.type.function"] = { link = "Function" },
	["@lsp.type.interface"] = { link = "Structure" },
	["@lsp.type.macro"] = { link = "Macro" },
	["@lsp.type.method"] = { link = "Function" },
	["@lsp.type.namespace"] = { link = "@module" },
	["@lsp.type.parameter"] = { link = "@variable.parameter" },
	["@lsp.type.property"] = { link = "@property" },
	["@lsp.type.struct"] = { link = "Structure" },
	["@lsp.type.type"] = { link = "Type" },
	["@lsp.type.typeParameter"] = { link = "Type" },
	["@lsp.type.variable"] = { link = "@variable" },

	["@lsp.mod.readonly"] = { fg = color.string },
	["@lsp.mod.typeHint"] = { fg = color.comment },
	["@lsp.mod.defaultLibrary"] = { fg = color.foreground },
	["@lsp.mod.deprecated"] = { strikethrough = true },

	LspReferenceText = { bg = color.accent },
	LspReferenceRead = { bg = color.accent },
	LspReferenceWrite = { bg = color.accent, bold = true, underline = true },
	LspReferenceTarget = { fg = color.background, bg = color.type },
	LspInlayHint = { fg = color.comment, italic = true },
	LspCodeLens = { fg = color.comment },
	LspCodeLensSeparator = { fg = color.border },
	LspSignatureActiveParameter = { fg = color.type, bold = true, underline = true },

	-- === MINI.NVIM ECOSYSTEM ===
	MiniFilesBorder = { link = "FloatBorder" },
	MiniFilesDirectory = { link = "Directory" },
	MiniFilesFile = { fg = color.foreground },

	MiniDiffSignAdd = { fg = color.hint },
	MiniDiffSignChange = { fg = color.warn },
	MiniDiffSignDelete = { fg = color.error },
	MiniDiffOverAdd = { bg = color.diff_add },
	MiniDiffOverChange = { bg = color.diff_chg },
	MiniDiffOverDelete = { bg = color.diff_del },
	MiniDiffOverContext = { bg = color.surface },

	MiniPickBorder = { link = "FloatBorder" },
	MiniPickHeader = { fg = color.keyword, bold = true },
	MiniPickMatchCurrent = { bg = color.accent },
	MiniPickMatchMarked = { bg = color.diff_add },
	MiniPickPrompt = { fg = color.type, bg = color.surface, bold = true },
	MiniPickMatchRanges = { fg = color.keyword, bold = true },
}

local set_global_highlight = function(highlight_group, highlight_settings)
	local global_namespace = 0
	vim.api.nvim_set_hl(global_namespace, highlight_group, highlight_settings)
end
for highlight_group, highlight_settings in pairs(highlight_groups) do
	set_global_highlight(highlight_group, highlight_settings)
end

vim.g.colors_name = "fovea"
