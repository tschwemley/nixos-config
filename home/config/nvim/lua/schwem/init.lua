PackerInstalled = function(install_path)
  return not (vim.fn.empty(vim.fn.glob(install_path)) > 0)
end

-- Improve startup time
if PackerInstalled() then
  require("impatient")
end

require("schwem.opt")
require("schwem.packer")
require("schwem.autocmds")
