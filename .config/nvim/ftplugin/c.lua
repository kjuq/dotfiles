if vim.bo.filetype ~= 'c' then
	return
end

require('kjuq.utils.skeleton').paste_skeleton('c.c')
