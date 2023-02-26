local null_ls = require 'null-ls'

require ('mason-null-ls').setup({
  automatic_setup = true,
  ensure_installed = {'stylua', 'jq'},
})

require 'mason-null-ls'.setup_handlers {
  function(source_name, methods)
    -- all sources with no handler get passed here
    -- Keep original functionality of `automatic_setup = true`
    require('mason-null-ls.automatic_setup')(source_name, methods)
  end,
  stylua = function(source_name, methods)
    null_ls.register(null_ls.builtins.formatting.stylua)
  end,
  jq = function(source_name, methods)
    null_ls.register(null_ls.builtins.formatting.jq)
  end
}

-- will setup any installed and configured sources above
null_ls.setup()
