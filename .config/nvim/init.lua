vim.loader.enable()

require("general")
require("options")
require("keymaps")
require("commands")

require("lazy_init")

-- These two should be loaded after plugins loaded
-- for highlight on yank to work properly
require("colorscheme")
require("autocmd")
