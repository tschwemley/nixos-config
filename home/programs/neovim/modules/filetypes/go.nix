{pkgs, ...}: {
  programs.neovim = {
    # TODO: uncomment this if issues... but it looks like the nixpkg for the nvim plugin contains
    # the necessary tools by default
    # extraPackages = with pkgs; [
    #   gofumpt
    #   golines
    #   gotools  # contains goimports, gopls, and more. see: https://go.googlesource.com/tools
    #   reftools # contains fillstruct, fillswitch, and fixplurals
    # ];
    plugins = [pkgs.vimPlugins.go-nvim];
  };

  xdg.config."nvim/after/ftplugin/go.lua" = ''
  '';
}
