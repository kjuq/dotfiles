-- NOTE: `Cursor` of highlight group does not get applied

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/sphamba/smear-cursor.nvim' }
spec.event = 'VeryLazy'

spec.opts = {
	stiffness = 0.9,
	trailing_stiffness = 0.6,
	stiffness_insert_mode = 0.7,
	trailing_stiffness_insert_mode = 0.7,
	distance_stop_animating = 0.2,
}

return spec
