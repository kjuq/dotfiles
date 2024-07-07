local M = {}

M.setup = function()
	local textlint_root = vim.fn.stdpath("data") .. "/mason/packages/textlint"
	local has_rule = function(rule)
		local rules_root = textlint_root .. "/node_modules/"
		return vim.fn.isdirectory(rules_root .. rule) == 1
	end
	local install_rule = function(rule)
		if not has_rule(rule) then
			vim.notify("Installing: " .. rule)
			vim.fn.system({ "npm", "install", "--prefix", textlint_root, "--save", rule })
		end
	end

	install_rule("textlint-rule-write-good")
end

return M
