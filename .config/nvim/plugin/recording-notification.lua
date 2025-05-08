local group = vim.api.nvim_create_augroup('kjuq_recording_notification', {})

vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
	group = group,
	callback = function()
		-- vim.api.nvim_echo({ { 'Recording started: ' .. vim.fn.reg_recording(), 'Number' } }, true, {})
		vim.notify('Recording started: ' .. vim.fn.reg_recording(), vim.log.levels.OFF, { hl_group = 'Number' })
	end,
})

vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
	group = group,
	callback = function()
		-- vim.api.nvim_echo({ { 'Recording ended: ' .. vim.fn.reg_recording(), 'Number' } }, true, {})
		vim.notify('Recording ended: ' .. vim.fn.reg_recording(), vim.log.levels.OFF, { hl_group = 'Number' })
	end,
})
