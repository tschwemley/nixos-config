local getFlakeExpr = '(builtins.getFlake "' .. os.getenv("HOME") .. '/nixos-config")'
local host = vim.fn.hostname()
local user = vim.fn.getenv("USER")

return {
   settings = {
      ["nil"] = {
         nix = {
            flake = {
               autoArchive = true,
               -- autoEvalInputs = true,
            },
         },
      },
   },
}
