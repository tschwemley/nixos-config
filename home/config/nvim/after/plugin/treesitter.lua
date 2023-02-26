require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "go",
    "html",
    "javascript",
    "json",
    "markdown",
    "norg",
    "php",
    "python",
    "tsx",
    "typescript",
    "yaml",
  },

  auto_install = true,

  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- enables comment string context based on cursor position
  context_commentstring = {
    enable = true,
  },

  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int colors = {}, -- table of hex strings termcolors = {} -- table of colour name strings
  },
}

require("treesitter-context").setup()
