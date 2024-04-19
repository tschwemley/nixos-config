local function prettifyJSON()
   vim.cmd("%!jq .");
end

local function minifyJSON()
   vim.cmd("%!jq -r tostring");
end

require('which-key').register({
   J = {
      name = 'JSON',
      p = { prettifyJSON, 'Prettify' },
      m = { minifyJSON, 'Minify' },
   },
}, { prefix = '<leader>' })
