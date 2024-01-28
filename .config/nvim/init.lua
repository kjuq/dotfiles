vim.loader.enable()

require("general")
require("options")
require("keymaps")
require("commands")
require("autocmd")

require("lazy_init")

-- should load colorscheme after initialize plugins
require("colorscheme")
