{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModule

    ../programs/development
    ../programs/utils

    ../programs/neovim
    ../programs/yazi.nix

    ../terminal

    ../xdg/ssh/default.nix
  ];

  home.sessionVariables.TERM = "wezterm";
  home.stateVersion = "24.11";
  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
