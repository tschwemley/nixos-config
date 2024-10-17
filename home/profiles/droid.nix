{
  imports = [
    # ./.
    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../xdg/ssh/default.nix
    # ../terminal/shell
  ];

  home = {
    homeDirectory = "/home/schwem";
    stateVersion = "24.05";
    username = "schwem";
  };
}
