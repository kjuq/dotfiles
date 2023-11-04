return {
    generate_map = function(prefix, desc_source)
        return function(suffix, mode, func, comment)
            local key = prefix .. suffix
            local func = func
            local desc = desc_source .. comment

            return { key, mode = mode, func, desc = desc }
        end
    end
}
