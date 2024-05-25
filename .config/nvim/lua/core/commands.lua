vim.api.nvim_create_user_command("Sudowrite", "write !sudo tee % > /dev/null", {})

local edit = vim.cmd.edit
local doc = "~/docs"
local confroot = os.getenv("XDG_CONFIG_HOME") .. "/nvim"

vim.api.nvim_create_user_command("EditTodo", function()
	edit(doc .. "/__todo/todo.txt")
end, { desc = "Edit todo.txt" })

vim.api.nvim_create_user_command("EditBookmarks", function()
	edit(doc .. "/__bookmarks/bookmarks.txt")
end, { desc = "Edit bookmarks.txt" })

vim.api.nvim_create_user_command("EditReadinglist", function()
	edit(doc .. "/__bookmarks/readinglist.txt")
end, { desc = "Edit readinglist.txt" })

vim.api.nvim_create_user_command("EditDailynote", function()
	edit(doc .. "/__daily/" .. os.date("%Y-%m-%d.md"))
end, { desc = "Edit daily note" })

vim.api.nvim_create_user_command("EditSnippet", function()
	edit(confroot .. "/snippets/" .. vim.o.ft .. ".snippets")
end, { desc = "Edit snippet" })

vim.api.nvim_create_user_command("ExMode", function()
	vim.api.nvim_feedkeys("gQ", "n", true)
end, {})
vim.api.nvim_create_user_command("GQ", function()
	vim.api.nvim_feedkeys("gQ", "n", true)
end, {})

vim.api.nvim_create_user_command("SelectMode", function()
	vim.api.nvim_feedkeys("gh", "n", true)
end, {})
vim.api.nvim_create_user_command("Gh", function()
	vim.api.nvim_feedkeys("gh", "n", true)
end, {})

vim.api.nvim_create_user_command("SelectLineMode", function()
	vim.api.nvim_feedkeys("gH", "n", true)
end, {})
vim.api.nvim_create_user_command("GH", function()
	vim.api.nvim_feedkeys("gH", "n", true)
end, {})

vim.api.nvim_create_user_command("VirtualReplace", function()
	vim.api.nvim_feedkeys("gr", "n", true)
end, {})
vim.api.nvim_create_user_command("Gr", function()
	vim.api.nvim_feedkeys("gr", "n", true)
end, {})

vim.api.nvim_create_user_command("VirtualReplaceMode", function()
	vim.api.nvim_feedkeys("gR", "n", true)
end, {})
vim.api.nvim_create_user_command("GR", function()
	vim.api.nvim_feedkeys("gR", "n", true)
end, {})
