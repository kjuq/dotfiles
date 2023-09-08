skel_path = "~/.config/nvim/ftplugin/skeleton/"

function paste_skeleton(filename)
    -- https://stackoverflow.com/questions/72165140/vim-bufnewfile-autocmd-does-not-work-when-inside-filetype-plugin
    if vim.fn.filereadable(vim.fn.bufname()) then
        if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
            vim.cmd.read({ range = { 0 }, args = { skel_path .. filename }, mods = { silent = true }}) -- 0r ./c.c
        end
    end
end

