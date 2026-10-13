-- http header should use CRLF according to the specification of that
if vim.bo.fileformat == 'dos' then
	return
end
vim.cmd.edit('++ff=dos')
