local M = require("iton.util")
local map = M.map
local noremap_silent = M.noremap_silent
local silent = M.silent
local function set_mapping(mappings)
	for _, mapping in ipairs(mappings) do
		map(table.unpack(mapping))
	end
end
set_mapping({
	{ "n", "<leader>che", ":Lazy load all<cr>:checkhealth<cr>/ERROR<cr>" },
	{ "n", "<leader>chl", ":checkhealth vim.lsp<cr>" },
	{ "n", "<leader>z",   ":Lazy<cr>" },
	{ "n", "k",           "v:count == 0 ? 'gk' : 'k'",                             { expr = true, silent = true } },
	{ "n", "j",           "v:count == 0 ? 'gj' : 'j'",                             { expr = true, silent = true } },
	{ "n", "<leader>f",   [[:%s/]],                                                { desc = "Find and Replace" } },
	{ "v", "<leader>f",   [[:s/]],                                                 { desc = "Find and Replace (Visual)" } },
	{ "x", "<leader>f",   [[:s/]],                                                 { desc = "Find and Replace (Visual Block)" } },
	{ "n", "<M-f>",       [[:cdo s/]],                                             { desc = "Quickfix Find and Replace" } },
	{ "n", "<c-b>",       "<Nop>",                                                 { desc = "None (to not conflict with tmux)" } },
	{ "n", "<c-f>",       ":!tmux neww ~/.local/scripts/tmux-sessionizer<CR><cr>", { desc = "Tmux Sessionizer" } },
	{ "v", "<C-c>", function()
		local original_reg = vim.fn.getreg('"')
		vim.cmd('normal! "+y')
		vim.fn.setreg('"', original_reg)
	end, noremap_silent },
	{ "i", "jk",       "<esc>",            noremap_silent },
	{ "n", "<c-q>",    "<cmd>q<cr>",       silent },
	{ "n", "<c-u>",    "<c-u>zz" },
	{ "n", "<c-d>",    "<c-d>zz" },
	{ "n", "<S-Up>",   ":m .-2<CR>==",     silent },
	{ "n", "<S-Down>", ":m .+1<CR>==",     silent },
	{ "v", "<S-Up>",   ":m '<-2<CR>gv=gv", silent },
	{ "v", "<S-Down>", ":m '>+1<CR>gv=gv", silent },
	{ "n", "<",        "<<" },
	{ "n", ">",        ">>" },
	{ "v", "<",        "<gv" },
	{ "v", ">",        ">gv" },
	{ "n", "H",        "_" },
	{ "n", "L",        "$" },
	{ "n", "<CR>", function()
		if vim.bo.filetype == "qf" then
			return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
		elseif vim.opt.hlsearch:get() then
			vim.cmd.nohl()
			return ""
		else
			return vim.keycode("<CR>")
		end
	end, { expr = true } },
	{ "n", "qn", ":cnext<CR>zz", noremap_silent },
	{ "n", "qp", ":cprev<CR>zz", noremap_silent },
	{ "n", "<leader>q",
		":lua local qf_open = false for _, win_info in ipairs(vim.fn.getwininfo()) do if win_info.quickfix == 1 then qf_open = true break end end if qf_open then vim.cmd('cclose') else vim.cmd('copen') end<CR>",
		noremap_silent,
	},
	{ "n", "gu",    "g~" },
	{ "n", "<M-c>", '<cmd>:echo ""<cr>', { desc = "Clear Command line" } },
})
