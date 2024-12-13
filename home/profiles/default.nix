{
  imports = [
    ../programs/development
    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/eza.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/thefuck.nix

    ../terminal/shell

    ../xdg/ssh/default.nix
  ];

  home.sessionVariables.TERM = "kitty";
  home.stateVersion = "24.11";
  # sops.defaultSopsFile = ../secrets.yaml;
}
