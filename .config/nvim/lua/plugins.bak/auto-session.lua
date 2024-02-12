---@type LazySpec
local spec = { "rmagatti/auto-session" }
spec.lazy = false

spec.opts = function()
	return {
		log_level = "error",
		auto_session_enable_last_session = true,
		auto_session_suppress_dirs = { "/", "~/" },
	}
end

return spec
