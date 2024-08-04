---@type LazySpec
local spec = { 'iamcco/markdown-preview.nvim' }

spec.cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' }
spec.ft = { 'markdown' }
spec.build = function() vim.fn['mkdp#util#install']() end

return spec
