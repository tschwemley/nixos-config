{ self, ... }:
{
  imports = [
    self.inputs.sops-nix.homeManagerModule

    ../programs/development
    ../programs/media/gallery-dl.nix
    ../programs/media/yt-dlp.nix
    ../programs/neovim
    ../programs/utils
    ../programs/yazi

    ../terminal
  ];

  home.sessionVariables.TERM = "wezterm";
  home.stateVersion = "24.11";
  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
