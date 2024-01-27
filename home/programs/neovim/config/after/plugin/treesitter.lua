local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
local parser_install_dir = '~/.local/share/nvim/site/parser'

require 'nvim-treesitter.configs'.setup {
   parser_install_dir = parser_install_dir,

   -- A list of parser names, or "all" (the five listed parsers should always be installed)
   -- TODO: delete this once confirming changes work via nix
   -- ensure_installed = { "go", "haxe", "lua", "markdown", "nix", "php" },

   --TODO: add this if necessary in nixos (I assume nix adds the proper path(s) to the RTP)
   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)

   highlight = {
      enable = true,

      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
         local max_filesize = 1000 * 1024 -- 1 MB
         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
         if ok and stats and stats.size > max_filesize then
            return true
         end
      end,
   },
}

vim.opt.runtimepath:append(parser_install_dir)
parser_config.haxe = {
   install_info = {
      url = '~/.local/share/nvim/site/parser/haxe',
      files = { 'src/parser.c' },
   },
   filetype = 'haxe',
}
