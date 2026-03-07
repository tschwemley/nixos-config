require("helpers").set_tabs(4)

vim.lsp.enable("intelephense")
vim.treesitter.start()

vim.bo.commentstring = "// %s"

require("dap").adapters.php = {
	type = "executable",
	command = "node",
	args = { os.getenv("PHP_DEBUG_PATH") },
}
