local function cmd(command)
   os.execute(command)
end

vim.api.nvim_create_user_command("Decrypt", "!sops -d --in-place %", {})
