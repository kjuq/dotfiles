local success, conf_dir = pcall(os.getenv, "XDG_CONFIG_HOME")
if not success then
    conf_dir = os.getenv("HOME") .. "/.config"
end

return {
    skel_path = conf_dir .. "/nvim/ftplugin/skeleton/",
    paste_skeleton = function(filename)
        -- if vim.fn.filereadable(vim.fn.bufname()) == 0 and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
        if require("utils.common").is_empty_buffer() then
            vim.cmd.read({
                args = { require("utils.skeleton").skel_path .. filename },
                mods = { silent = true }
            })
            vim.cmd.delete({
                range = { 1 },
                mods = { silent = true }
            })
        end
    end
}
