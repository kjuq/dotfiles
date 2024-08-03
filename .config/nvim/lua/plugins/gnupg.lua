---@type LazySpec
local spec = { "jamessan/vim-gnupg" }

spec.lazy = not require("utils.common").argv_contains({ ".gpg", ".pgp", ".asc" })

spec.event = "VeryLazy"

return spec
