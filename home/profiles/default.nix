{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModule

    ../programs/development
    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/eza.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/thefuck.nix

    ../terminal

    ../xdg/ssh/default.nix
  ];

  home.sessionVariables.TERM = "wezterm";
  home.stateVersion = "24.11";
  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
