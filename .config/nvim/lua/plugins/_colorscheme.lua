local color = "catppuccin"
return {
    dir = "/tmp/70724411/_colorscheme",
    lazy = false,
    priority = 9999,
    config = function()
        require(color)
    end
}
