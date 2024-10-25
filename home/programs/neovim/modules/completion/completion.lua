local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = {
      ["<C-y>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.confirm({ select = true })
         else
            fallback()
         end
      end),
      ["<CR>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            if luasnip.expandable() then
               luasnip.expand()
            else
               cmp.confirm({ select = true })
            end
         else
            fallback()
         end
      end),

      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<Down>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<Up>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         else
            fallback()
         end
      end, { "i", "s" }),
   },

   sources = {
      { name = "buffer" },
      {
         name = "lazydev",
         group_index = 0, -- group_index = 0 to skip loading LuaLS completions
      },
      { name = "luasnip" },
      { name = "neorg" },
      { name = "nvim_lsp" },
      { name = "path" },
   },
})

-- command line setup for buffer search ('/') and commands (':')
cmp.setup.cmdline("/", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "buffer" },
   },
})

cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = cmp.config.sources({
      { name = "path" },
      {
         name = "cmdline",
         option = {
            ignore_cmds = { "Man", "!" },
         },
      },
   }),
   -- sources = cmp.config.sources({
   --    { name = "path" },
   --    }, {
   --    {
   --       name = "cmdline",
   --       option = {
   --          ignore_cmds = { "Man", "!" },
   --       },
   --    },
   -- }),
})

-- require("neodev").setup({
-- 	library = { plugins = { "nvim-dap-ui" }, types = true },
-- 	override = function(root_dir, library)
-- 		if root_dir:find("/etc/nixos", 1, true) == 1 then
-- 			library.enabled = true
-- 			library.plugins = true
-- 		end
-- 	end,
-- })
