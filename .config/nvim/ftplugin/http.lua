-- http header should use CRLF according to the specification of that
if vim.bo.fileformat ~= 'dos' then
	vim.cmd.edit('++ff=dos')
end

vim.opt_local.fixeol = false
