---@type LazySpec
local spec = { 'https://github.com/tpope/vim-fugitive' }

spec.cmd = {
	'G',
	'GBrowse',
	'GDelete',
	'GMove',
	'GRemove',
	'GUnlink',
	'Gcd',
	'Gclog',
	'Gdiffsplit',
	'Gdrop',
	'Gedit',
	'Ggrep',
	'Ghdiffsplit',
	'Git',
	'Glcd',
	'Glgrep',
	'Gllog',
	'Gpedit',
	'Gread',
	'Gsplit',
	'Gtabedit',
	'Gvdiffsplit',
	'Gvsplit',
	'Gwq',
	'Gwrite',
}

spec.dependencies = {
	'https://github.com/tpope/vim-rhubarb', -- for `:GBrowse`
}

return spec
