local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
    ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i" }),
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }, { "i" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif has_words_before() then
      --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources(
    { -- group 1
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- For luasnip users.
      { name = "neorg" }
    },
    { -- group 2
      { name = "buffer" },
      { name = "path" },
    })
})

--  todo: check which (if any) of below I want to keep

-- -- Set configuration for specific filetype.
-- cmp.setup.filetype("gitcommit", {
--   sources = cmp.config.sources({
--     { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = "buffer" },
--   })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
  {
    { name = "path" }
  },
  {
    { name = "cmdline" }
  })
})
