-- Set colorscheme, which is overridable at initprelocal.lua for example
if not _G.kjuq_colorscheme then
	_G.kjuq_colorscheme = 'catppuccin'
end

---@type LazySpec
local spec = {}

spec.import = 'plugins/colorscheme'
return spec
