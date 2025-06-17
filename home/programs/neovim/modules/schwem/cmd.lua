--- Decrypts the current buffer using sops.
vim.api.nvim_create_user_command("SopsDecrypt", "!sops -d --in-place %", {})

--- Encrypts the current buffer using sops.
vim.api.nvim_create_user_command("SopsEncrypt", "!sops -e --in-place %", {})
