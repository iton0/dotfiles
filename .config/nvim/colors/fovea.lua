-- Name: Fovea
-- Strategy: Foveal Attention + Pre-attentive Meta-Filtering
-- Criteria: APCA-Contrast + OKLCH Perceptual Balance

local p = {
	dark = {
		-- Base & Neutral
		bg = "#1a1b26",
		fg = "#cfc9c2",

		-- Semantic Pillars (Balanced for Scaffolding)
		keyword = "#bb9af7",
		type = "#7ad9e5", -- High Acuity Cyan
		string = "#a6d388", -- Muted Green (The "Elite" Fix)
		comment = "#565f89",

		-- Diagnostics & UI
		error = "#f7768e",
		warn = "#e0af68",
		info = "#7aa2f7",
		hint = "#1abc9c",
		surface = "#24283b",
		gutter = "#1f2335",
		border = "#3b4261",
		accent = "#2e3c64", -- Stable Selection Anchor

		diff_add = "#283b26",
		diff_del = "#3f2d3d",
		diff_chg = "#3e3723",
	},
	light = {
		-- Base & Neutral (Ink on Paper)
		bg = "#faf8f5",
		fg = "#373b41",

		-- Semantic Pillars (Deepened for Legibility)
		keyword = "#8631ef",
		type = "#006a8d", -- Adjusted: Slightly deeper Teal for APCA LC80+
		string = "#3d7a34", -- Adjusted: "Forest" shift to prevent "Neon-on-White" fatigue
		comment = "#8a8a8a", -- Adjusted: Darker grey (Ghost Grey was too low contrast)

		-- Diagnostics & UI
		error = "#d02c2c",
		warn = "#8c5e00", -- Deepened for better visibility on white
		info = "#005da3",
		hint = "#007a66",
		surface = "#f0ede9",
		gutter = "#e8e5e1",
		border = "#d1d1d1",
		accent = "#d8d5d1", -- Neutral Muted selection

		diff_add = "#e1f0e1",
		diff_del = "#f0e1e1",
		diff_chg = "#f9f0c2",
	},
}

local c = vim.o.background == "light" and p.light or p.dark

local groups = {
	-- === CORE UI (Achromatic Isolation) ===
	Normal = { fg = c.fg, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.surface },
	FloatBorder = { fg = c.border, bg = c.surface },
	CursorLine = { bg = c.surface },
	LineNr = { fg = c.comment },
	Title = { fg = c.fg, bg = c.surface, bold = true },
	CursorLineNr = { fg = c.type, bold = true },
	VertSplit = { fg = c.border },
	WinSeparator = { fg = c.border },
	Pmenu = { fg = c.fg, bg = c.surface },
	PmenuSel = { fg = c.type, bg = c.accent, bold = true },
	Search = { fg = c.bg, bg = c.warn },
	Visual = { bg = c.accent },
	Folded = { fg = c.comment, bg = c.surface },
	Question = { fg = c.type },
	MoreMsg = { fg = c.type, bold = true },
	WarningMsg = { fg = c.warn, bold = true },
	ErrorMsg = { fg = c.error, bold = true },
	CurSearch = { fg = c.bg, bg = c.keyword, bold = true },
	IncSearch = { link = "CurSearch" },
	MatchParen = { fg = c.type, bold = true, underline = true },
	ModeMsg = { fg = c.fg, bold = true },
	MsgArea = { fg = c.fg },
	Directory = { fg = c.type, bold = true },
	StatusLine = { fg = c.type, bg = c.surface, bold = true },
	StatusLineNC = { fg = c.comment, bg = c.gutter },
	TabLine = { fg = c.comment, bg = c.gutter },
	TabLineFill = { bg = c.bg },
	TabLineSel = { fg = c.bg, bg = c.type, bold = true },
	NonText = { fg = c.gutter },
	EndOfBuffer = { link = "NonText" },
	SignColumn = { bg = c.bg },
	FoldColumn = { bg = c.bg },

	-- === THE 4 SEMANTIC PILLARS ===
	Keyword = { fg = c.keyword },
	Statement = { link = "Keyword" },
	Conditional = { link = "Keyword" },
	Repeat = { link = "Keyword" },
	Label = { link = "Keyword" },
	Operator = { link = "Keyword" },
	Exception = { link = "Keyword" },

	Type = { fg = c.type },
	StorageClass = { link = "Type" },
	Structure = { link = "Type" },
	Typedef = { link = "Type" },

	String = { fg = c.string },
	Character = { link = "String" },
	Number = { link = "String" },
	Boolean = { link = "String" },
	Float = { link = "String" },
	Constant = { link = "String" },

	Comment = { fg = c.comment, italic = true },
	Special = { fg = c.comment }, -- Muted punctuation (brackets, delimiters)
	Debug = { fg = c.keyword },
	Delimiter = { fg = c.comment },

	-- Identifier/Functions (Neutral context)
	Identifier = { fg = c.fg },
	Function = { fg = c.fg },
	PreProc = { fg = c.keyword },
	Include = { fg = c.keyword },
	Define = { fg = c.keyword },
	Macro = { fg = c.keyword },
	Tag = { fg = c.keyword },

	-- === DIAGNOSTICS ===
	DiagnosticOk = { fg = c.hint },
	DiagnosticUnnecessary = { link = "DiagnosticDeprecated" },
	DiagnosticError = { fg = c.error, bold = true },
	DiagnosticWarn = { fg = c.warn },
	DiagnosticInfo = { fg = c.info },
	DiagnosticHint = { fg = c.hint },
	DiagnosticUnderlineError = { sp = c.error, undercurl = true },
	DiagnosticUnderlineWarn = { sp = c.warn, undercurl = true },
	DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
	DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
	DiagnosticVirtualTextError = { fg = c.error, bg = c.surface },
	DiagnosticVirtualTextWarn = { fg = c.warn, bg = c.surface },
	DiagnosticVirtualTextInfo = { fg = c.info, bg = c.surface },
	DiagnosticVirtualTextHint = { fg = c.hint, bg = c.surface },

	-- === DIFF MODE ===
	DiffAdd = { bg = c.diff_add },
	DiffDelete = { bg = c.diff_del },
	DiffChange = { bg = c.diff_chg },
	DiffText = { bg = c.type, fg = c.bg },
	["@diff.plus"] = { link = "DiffAdd" },
	["@diff.minus"] = { link = "DiffDelete" },
	["diffAdded"] = { link = "DiffAdd" },
	["diffRemoved"] = { link = "DiffDelete" },
	["diffChanged"] = { link = "DiffChange" },

	-- === QUICKFIX ===
	QuickFixLine = { bg = c.accent, bold = true },
	qfFileName = { fg = c.type },
	qfLineNr = { fg = c.comment },
	qfError = { fg = c.error },

	-- === TREESITTER & LSP ===
	["@variable"] = { fg = c.fg },
	["@variable.builtin"] = { fg = c.keyword },
	["@variable.parameter"] = { fg = c.fg },
	["@variable.member"] = { fg = c.fg },
	["@property"] = { fg = c.fg },

	["@constant"] = { link = "Constant" },
	["@constant.builtin"] = { link = "Constant" },
	["@constant.macro"] = { link = "Macro" },

	["@module"] = { fg = c.fg },
	["@module.builtin"] = { fg = c.type },
	["@label"] = { link = "Label" },

	["@string"] = { link = "String" },
	["@string.documentation"] = { fg = c.string, italic = true },
	["@string.regexp"] = { fg = c.warn },
	["@string.escape"] = { fg = c.keyword },
	["@string.special"] = { link = "Special" },
	["@character"] = { link = "String" },
	["@character.special"] = { link = "Special" },

	["@type"] = { link = "Type" },
	["@type.builtin"] = { link = "Type" },
	["@type.definition"] = { link = "Typedef" },
	["@attribute"] = { fg = c.keyword },
	["@attribute.builtin"] = { fg = c.keyword },

	["@function"] = { link = "Function" },
	["@function.builtin"] = { link = "Function" },
	["@function.call"] = { link = "Function" },
	["@function.macro"] = { link = "Macro" },
	["@function.method"] = { link = "Function" },
	["@function.method.call"] = { link = "Function" },
	["@constructor"] = { fg = c.type },

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
	["@markup.heading"] = { fg = c.keyword, bold = true },
	["@markup.raw"] = { bg = c.surface },
	["@markup.link.url"] = { fg = c.info, underline = true },

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

	["@lsp.mod.readonly"] = { fg = c.string },
	["@lsp.mod.typeHint"] = { fg = c.comment },
	["@lsp.mod.defaultLibrary"] = { fg = c.type },
	["@lsp.mod.deprecated"] = { strikethrough = true },

	LspReferenceText = { bg = c.accent },
	LspReferenceRead = { bg = c.accent },
	LspReferenceWrite = { bg = c.accent, bold = true, underline = true },
	LspReferenceTarget = { fg = c.bg, bg = c.type },
	LspInlayHint = { fg = c.comment, italic = true },
	LspCodeLens = { fg = c.comment },
	LspCodeLensSeparator = { fg = c.border },
	LspSignatureActiveParameter = { fg = c.type, bold = true, underline = true },

	-- === MINI.NVIM ECOSYSTEM ===
	MiniFilesBorder = { link = "FloatBorder" },
	MiniFilesDirectory = { link = "Directory" },
	MiniFilesFile = { fg = c.fg },

	MiniDiffSignAdd = { fg = c.hint },
	MiniDiffSignChange = { fg = c.warn },
	MiniDiffSignDelete = { fg = c.error },
	MiniDiffOverAdd = { bg = c.diff_add },
	MiniDiffOverChange = { bg = c.diff_chg },
	MiniDiffOverDelete = { bg = c.diff_del },
	MiniDiffOverContext = { bg = c.surface },

	MiniPickBorder = { link = "FloatBorder" },
	MiniPickHeader = { fg = c.keyword, bold = true },
	MiniPickMatchCurrent = { bg = c.accent },
	MiniPickMatchMarked = { bg = c.diff_add },
	MiniPickPrompt = { fg = c.type, bg = c.surface, bold = true },
	MiniPickMatchRanges = { fg = c.keyword, bold = true },
}

local set_hl = vim.api.nvim_set_hl
for group, settings in pairs(groups) do
	set_hl(0, group, settings)
end

vim.g.colors_name = "fovea"
