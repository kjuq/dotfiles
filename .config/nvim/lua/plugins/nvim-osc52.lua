return {
    "ojroques/nvim-osc52",
    event = { "BufNewFile", "BufReadPost" },
    opts = function ()
        local function copy(lines, _)
            require('osc52').copy(table.concat(lines, '\n'))
        end

        local function paste()
            return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
        end

        vim.g.clipboard = {
            name = 'osc52',
            copy = {['+'] = copy, ['*'] = copy},
            paste = {['+'] = paste, ['*'] = paste},
        }

        -- Now the '+' register will copy to system clipboard using OSC52

        return {
            max_length = 0,     -- Maximum length of selection (0 for no limit)
            silent     = true,  -- Disable message on successful copy
            trim       = true,  -- Trim surrounding whitespaces before copy
        }
    end,
}


