{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      gofumpt
      golines
      gotools # contains goimports, gopls, and more. see: https://go.googlesource.com/tools
      reftools # contains fillstruct, fillswitch, and fixplurals
    ];
    plugins = [pkgs.vimPlugins.go-nvim];
  };
}
