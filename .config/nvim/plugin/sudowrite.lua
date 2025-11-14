-- vim.api.nvim_create_user_command('Sudowrite', 'write !sudo tee % > /dev/null', {})
vim.api.nvim_create_user_command('Sudowrite', function()
	-- TODO: Suppress these warnings
	-- W10: Changing a readonly file
	-- W12: File * has changed and the buffer was changed in Vim as well
	-- And Press ENTER or type command to continue
	vim.cmd([[write !sudo tee % > /dev/null]])
end, {})
