-- Bootstrap mini.nvim
local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
	vim.cmd("echo 'Installing `mini.nvim`' | redraw")
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/nvim-mini/mini.nvim", mini_path })
	vim.cmd("packadd mini.nvim | helptags ALL")
end

-- Config state
_G.MyConfig = {
	later_queue = {},
	exec_errors = {},
	finish_is_scheduled = false,
	group = vim.api.nvim_create_augroup("MyConfig", { clear = true }),
}

-- Error notification
local function report_errors()
	if #_G.MyConfig.exec_errors == 0 then
		return
	end
	local ok, msg = pcall(table.concat, _G.MyConfig.exec_errors, "\n")
	if ok then
		vim.notify("Config Errors:\n" .. msg, vim.log.levels.ERROR)
	else
		vim.notify("Config Errors: (Failed to format error list)", vim.log.levels.ERROR)
	end
	_G.MyConfig.exec_errors = {}
end

-- Sequential queue processor
local queue_idx = 1
local function schedule_finish()
	if _G.MyConfig.finish_is_scheduled then
		return
	end
	_G.MyConfig.finish_is_scheduled = true

	vim.schedule(function()
		local f = _G.MyConfig.later_queue[queue_idx]
		if f ~= nil then
			local ok, err = pcall(f)
			if not ok then
				table.insert(_G.MyConfig.exec_errors, tostring(err))
			end
			queue_idx = queue_idx + 1
			_G.MyConfig.finish_is_scheduled = false
			schedule_finish()
			return
		end
		report_errors()
		_G.MyConfig.finish_is_scheduled = false
		_G.MyConfig.later_queue = {}
		queue_idx = 1
	end)
end

-- Run immediately with error catching
_G.MyConfig.now = function(f)
	local ok, err = pcall(f)
	if not ok then
		table.insert(_G.MyConfig.exec_errors, tostring(err))
	end
	schedule_finish()
end

-- Defer execution to next event loop
_G.MyConfig.later = function(f)
	table.insert(_G.MyConfig.later_queue, f)
	schedule_finish()
end

-- Strategy based on startup arguments
_G.MyConfig.now_if_args = vim.fn.argc(-1) > 0 and _G.MyConfig.now or _G.MyConfig.later

-- Safe autocmd wrapper
_G.MyConfig.new_autocmd = function(event, pattern, callback, opts)
	opts = opts or {}
	local safe_callback = function(args)
		if type(callback) == "function" then
			local status, err = pcall(callback, args)
			if not status then
				vim.notify(
					string.format("[Autocmd Error] %s: %s", opts.desc or event, tostring(err)),
					vim.log.levels.ERROR
				)
			end
		end
	end

	vim.api.nvim_create_autocmd(event, {
		group = _G.MyConfig.group,
		pattern = pattern,
		buffer = opts.buffer,
		callback = safe_callback,
		once = opts.once or false,
		nested = opts.nested or false,
		desc = opts.desc or "Custom Autocmd",
	})
end

-- Plugin change listener
_G.MyConfig.on_packchanged = function(plugin_name, kinds, callback, desc)
	local f = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
			return
		end
		if not ev.data.active then
			vim.cmd.packadd(plugin_name)
		end
		callback()
	end
	_G.MyConfig.new_autocmd("PackChanged", "*", f, desc)
end
