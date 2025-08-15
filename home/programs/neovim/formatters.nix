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

    plugins = with pkgs.vimPlugins; [
      conform-nvim
    ];
  };
}
