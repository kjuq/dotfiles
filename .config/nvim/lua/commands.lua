vim.api.nvim_create_user_command("Sudowrite", "write !sudo tee % > /dev/null", {})
