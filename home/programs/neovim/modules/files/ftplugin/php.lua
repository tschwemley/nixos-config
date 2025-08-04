local use_spaces_for_tabs = false
require("user.helpers").set_tabs(4, use_spaces_for_tabs)

vim.bo.commentstring = "// %s"

vim.lsp.enable("intelephense")
