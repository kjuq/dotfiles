-- NOTE: If you ssh from a tmux session to a remote system and run neovim there,
-- NOTE: **pasting** does not work. In spite of copying is working flawlessly
-- https://github.com/neovim/neovim/discussions/29350#discussioncomment-11127983

-- TODO: Thus, map `"+p`, `"*p`, `"+P`, ... in normal mode to Paste just like
-- TODO: pressing <Super-V> and `<C-r>+` and `<C-r>*` in insert mode as well

-- Alacritty doesn't support XTGETTCAP, so built-in `/runtime/plugin/osc52.lua`
-- is not enough (`require('vim.termcap').query('Ms', function)` doesn't work
-- as expected)
-- https://github.com/alacritty/alacritty/issues/7268
-- https://github.com/alacritty/vte/issues/98

-- Wezterm has a bug that disables OSC52 copy to clipboard
-- https://github.com/wez/wezterm/issues/5917

if not os.getenv('SSH_TTY') then
	return
end

vim.g.clipboard = {
	name = 'OSC 52 (Copy and paste)',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
	},
	paste = {
		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
	},
}
