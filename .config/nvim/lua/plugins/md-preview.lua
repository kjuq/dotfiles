local ft = { "markdown", "markdownpreview" }

return {
	"topazape/md-preview.nvim",
	cond = vim.fn.executable("glow") ~= 0,
	ft = ft,
	opts = function()
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = ft,
			group = vim.api.nvim_create_augroup("user_md_preview", {}),
			callback = function()
				vim.keymap.set("n", "K", "<Cmd>MPToggle<CR>", { buffer = true, desc = "Md-preview: Toggle" })
			end,
		})
		return {
			viewer = {
				exec = "glow",
				exec_path = "",
				args = { "-s", "dark" },
			},
		}
	end,
}
