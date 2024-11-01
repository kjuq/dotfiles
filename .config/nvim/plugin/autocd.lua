-- Neovim change its cwd by detecting terminal's `cd`
vim.api.nvim_create_autocmd({ 'TermRequest' }, {
	callback = function(_)
		if string.sub(vim.v.termrequest, 1, 4) == '\x1b]7;' then
			local dir = string.gsub(vim.v.termrequest, '\x1b]7;file://[^/]*', '')
			if vim.fn.isdirectory(dir) == 0 then
				vim.notify('invalid dir: ' .. dir)
				return
			else
				vim.notify('cd ' .. dir)
				vim.cmd.cd(dir)
			end
		end
	end,
	desc = 'Handles OSC 7 dir change requests',
	group = vim.api.nvim_create_augroup('kjuq_auto_cd', {}),
})
