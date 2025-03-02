local getFlakeExpr = '(builtins.getFlake "' .. os.getenv("HOME") .. '/nixos-config")'
local host = vim.fn.hostname()
local user = vim.fn.getenv("USER")

return {
   settings = {
      nixd = {
         nixpkgs = {
            expr = "import " .. getFlakeExpr .. ".inputs.nixpkgs { }",
         },
         options = {
            nixos = {
               expr = getFlakeExpr .. ".nixosConfigurations." .. host .. ".options",
            },
            -- home_manager = {
            --    expr = getFlakeExpr .. ".homeConfigurations." .. user .. ".options",
            -- },
         },
         ["semantic-tokens"] = true,
      },
   },
}
