{
  imports = [
    ../programs/common.nix
    ../programs/development
    ../programs/git.nix

    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/thefuck.nix
    ../terminal/shell
    ../xdg/ssh/default.nix
  ];

  home.sessionVariables.TERM = "kitty";
  home.stateVersion = "24.05";
  sops.defaultSopsFile = ../secrets.yaml;
}
