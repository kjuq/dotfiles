local has_colorschemes = vim.fn.isdirectory(os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/plugins/colorschemes") == 1

return {
    has_colorschemes and { import = "plugins.colorschemes" } or {},
}
