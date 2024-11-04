-- NOTE: If you ssh from a tmux session to a remote system and run neovim there, pasting does not work.
-- In spite of copying is working flawlessly
-- https://github.com/neovim/neovim/discussions/29350#discussioncomment-11127983

if not os.getenv('SSH_TTY') then
	return
end

local ssh_without_tmux = {
	name = 'OSC 52 (ssh without tmux)',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
	},
	paste = {
		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
	},
}

local paste_nothing = function()
	return {
		vim.fn.split(vim.fn.getreg(''), '\n'),
		vim.fn.getregtype(''),
	}
end

local ssh_within_tmux = {
	name = 'OSC 52 (SSH in tmux)',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
	},
	paste = {
		['+'] = paste_nothing,
		['*'] = paste_nothing,
	},
}

require('vim.termcap').query('Ms', function(_, found, _)
	if found then
		vim.g.clipboard = ssh_without_tmux
	else
		vim.g.clipboard = ssh_within_tmux
	end
end)
