require('kjuq.utils.skeleton').paste_skeleton('python.py')

vim.g.python_recommended_style = false

-- not working in Lua way
vim.cmd([[ let g:python_indent = {} ]])
vim.cmd([[ let g:python_indent.open_paren = shiftwidth() ]])
vim.cmd([[ let g:python_indent.nested_paren = shiftwidth() ]])
vim.cmd([[ let g:python_indent.continue = shiftwidth() ]])
vim.cmd([[ let g:python_indent.closed_paren_align_last_line = v:false ]])
