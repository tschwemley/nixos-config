{
  imports = [
    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../xdg/netrc.nix
    ../xdg/ssh/default.nix
    ../terminal
  ];

  home.stateVersion = "24.11";
  sops.defaultSopsFile = ../secrets.yaml;
}
