local color = "catppuccin"
local dummy_path = "/tmp/70724411/_colorscheme"

return {
    dir = dummy_path,
    lazy = false,
    priority = 9999,
    config = function()
        require(color)
    end
}
