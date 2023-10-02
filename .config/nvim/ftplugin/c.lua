if vim.bo.filetype ~= "c" then
    return
end

require("utils.skeleton").paste_skeleton("c.c")
