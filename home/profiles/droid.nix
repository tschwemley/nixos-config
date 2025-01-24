{
  imports = [
    # ./.
    ../programs/bat.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../xdg/ssh/default.nix
    # ../terminal/shell
  ];

  home = {
    stateVersion = "24.05";
  };
}
