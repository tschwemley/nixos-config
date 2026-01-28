{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModule

    ../programs/development
    ../programs/utils

    ../programs/neovim
    ../programs/yazi

    ../terminal
  ];

  home.sessionVariables.TERM = "wezterm";
  home.stateVersion = "24.11";
  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
