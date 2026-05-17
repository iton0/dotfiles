local c = vim.o.background == "light" and
    {
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
    }
    or
    {
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
    }

local groups = {
        -- === CORE UI ===
        Normal = { fg = c.foreground, bg = c.background },
        NormalNC = { fg = c.comment, bg = c.background },
        NormalFloat = { fg = c.foreground, bg = c.surface },
        FloatBorder = { fg = c.border, bg = c.surface },
        CursorLine = { bg = c.surface },
        LineNr = { fg = c.comment },
        Title = { fg = c.foreground, bg = c.surface, bold = true },
        CursorLineNr = { fg = c.type, bold = true },
        VertSplit = { fg = c.border },
        WinSeparator = { fg = c.border },
        Pmenu = { fg = c.foreground, bg = c.surface },
        PmenuSel = { fg = c.type, bg = c.accent, bold = true },
        Search = { fg = c.background, bg = c.warn },
        Visual = { bg = c.accent },
        Folded = { fg = c.comment, bg = c.surface },
        Question = { fg = c.type },
        MoreMsg = { fg = c.type, bold = true },
        WarningMsg = { fg = c.warn, bold = true },
        ErrorMsg = { fg = c.error, bold = true },
        CurSearch = { fg = c.background, bg = c.keyword, bold = true },
        IncSearch = { link = "CurSearch" },
        Todo = { link = "Comment" },
        MsgSeparator = { fg = c.border, bg = c.gutter },
        MatchParen = { fg = c.type, bold = true, underline = true },
        ModeMsg = { fg = c.foreground, bold = true },
        MsgArea = { fg = c.foreground },
        Directory = { fg = c.type, bold = true },
        StatusLine = { fg = c.type, bg = c.surface, bold = true },
        StatusLineNC = { fg = c.comment, bg = c.gutter },
        TabLine = { fg = c.comment, bg = c.gutter },
        TabLineFill = { bg = c.background },
        TabLineSel = { fg = c.background, bg = c.type, bold = true },
        NonText = { fg = c.gutter },
        EndOfBuffer = { link = "NonText" },
        SignColumn = { bg = c.background },
        FoldColumn = { bg = c.background },

        -- === THE 4 SEMANTIC PILLARS ===
        Keyword = { fg = c.keyword },
        Statement = { link = "Keyword" },
        Conditional = { link = "Keyword" },
        Repeat = { link = "Keyword" },
        Label = { link = "Keyword" },
        Operator = { fg = c.foreground },
        Exception = { link = "Keyword" },

        Type = { fg = c.foreground },
        StorageClass = { link = "Type" },
        Structure = { link = "Type" },
        Typedef = { link = "Type" },

        String = { fg = c.string },
        Character = { link = "String" },
        Number = { link = "String" },
        Boolean = { link = "String" },
        Float = { link = "String" },
        Constant = { link = "String" },

        Comment = { fg = c.comment },
        Special = { fg = c.comment },
        Debug = { fg = c.keyword },
        Delimiter = { fg = c.comment },

        -- Identifier/Functions
        Identifier = { fg = c.foreground },
        Function = { fg = c.foreground },
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
        DiffText = { bg = c.accent, fg = c.foreground, bold = true },
        ["@diff.plus"] = { link = "DiffAdd" },
        ["@diff.minus"] = { link = "DiffDelete" },
        ["@diff.delta"] = { link = "DiffChange" },
        ["diffAdded"] = { link = "DiffAdd" },
        ["diffRemoved"] = { link = "DiffDelete" },
        ["diffChanged"] = { link = "DiffChange" },

        -- === QUICKFIX ===
        QuickFixLine = { bg = c.accent, bold = true },
        qfFileName = { fg = c.type },
        qfLineNr = { fg = c.comment },
        qfError = { fg = c.error },

        -- === TREESITTER & LSP ===
        ["@variable"] = { fg = c.foreground },
        ["@variable.builtin"] = { fg = c.keyword },
        ["@variable.parameter"] = { fg = c.foreground },
        ["@variable.member"] = { fg = c.foreground },
        ["@property"] = { fg = c.foreground },

        ["@constant"] = { link = "Constant" },
        ["@constant.builtin"] = { link = "Constant" },
        ["@constant.macro"] = { link = "Macro" },

        ["@module"] = { fg = c.foreground },
        ["@module.builtin"] = { fg = c.foreground },
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
        ["@markup.heading"] = { fg = c.keyword, bold = true },
        ["@markup.raw"] = { bg = c.surface },
        ["@markup.link.url"] = { fg = c.info, underline = true },

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

        ["@lsp.mod.readonly"] = { fg = c.string },
        ["@lsp.mod.typeHint"] = { fg = c.comment },
        ["@lsp.mod.defaultLibrary"] = { fg = c.foreground },
        ["@lsp.mod.deprecated"] = { strikethrough = true },

        LspReferenceText = { bg = c.accent },
        LspReferenceRead = { bg = c.accent },
        LspReferenceWrite = { bg = c.accent, bold = true, underline = true },
        LspReferenceTarget = { fg = c.background, bg = c.type },
        LspInlayHint = { fg = c.comment, italic = true },
        LspCodeLens = { fg = c.comment },
        LspCodeLensSeparator = { fg = c.border },
        LspSignatureActiveParameter = { fg = c.type, bold = true, underline = true },

        -- === MINI.NVIM ECOSYSTEM ===
        MiniPickMatchCurrent = { bg = c.accent },
        MiniPickMatchRanges = { fg = c.keyword, bold = true },
}

local hl = vim.api.nvim_set_hl
for group, settings in pairs(groups) do
        hl(0, group, settings)
end

vim.g.colors_name = "fovea"
