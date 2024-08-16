local M = {}

local install_rules = function()
	local textlint_root = vim.fn.stdpath('data') .. '/mason/packages/textlint'
	local has_rule = function(rule)
		local rules_root = textlint_root .. '/node_modules/'
		return vim.fn.isdirectory(rules_root .. rule) == 1
	end
	local install_rule = function(rule)
		if not has_rule(rule) then
			vim.notify('Installing: ' .. rule)
			vim.fn.system({ 'npm', 'install', '--prefix', textlint_root, '--save', rule })
		end
	end

	-- install_rule("textlint-rule-write-good")
end

local register = function()
	local null_ls = require('null-ls')
	null_ls.register(null_ls.builtins.diagnostics.textlint)
end

M.setup = function()
	install_rules()
	register()
end

return M
