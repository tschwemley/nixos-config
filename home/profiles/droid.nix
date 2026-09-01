{
  imports = [
    # ./.
    ../programs/bat.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/terminal/ssh
  ];

  home = {
    stateVersion = "24.05";
  };
}
