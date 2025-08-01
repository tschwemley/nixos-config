{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      # go
      go
      golines

      # nix
      nixfmt

      # lua
      stylua
    ];

    plugins = [{
      plugin = pkgs.vimPlugins.conform-nvim;
      type = "lua";
      config = 
        # lua
        ''
          require("conform").setup({
            formatters_by_ft = {
              go = {  "gofmt", "goimports", "golines", },
              lua = { "stylua" },
              nix = { "nixfmt" },
            }
          })
        '';
    }];
  };
}
