local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

local ensure_installed = {
  "bash",
  "docker",
  "gopls",
  "intelephense",
  "jsonls",
  "sqlls",
  "sumneko_lua",
  "tsserver",
  "yamlls"
}
local nvim_lsp = require "lspconfig"
local on_attach = function(_, bufnr)
  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<space>li", "<cmd>LspInfo<CR>", opts)
  vim.keymap.set("n", "<space>lI", "<cmd>Mason<CR>", opts)
end


require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed })

-- Set up lspconfig for enabled servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local ignore = { bash = true, docker = true }

for _, lsp_server in pairs(ensure_installed) do
  -- Skip any ignored  lsp servers
  if ignore[lsp_server] ~= nil then goto continue end

  nvim_lsp[lsp_server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  ::continue::
end

require("lspconfig").sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(";", package.path),
      },

      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  }
})

-- Setup lsp saga
require("lspsaga").setup({})
