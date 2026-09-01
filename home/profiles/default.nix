{ self, ... }:
{
  imports = [
    self.inputs.sops-nix.homeManagerModule

    ../programs/development
    ../programs/media/gallery-dl.nix
    ../programs/media/yt-dlp.nix
    ../programs/neovim
    ../programs/terminal
    ../programs/utils
    ../programs/yazi
  ];

  home.sessionVariables.TERM = "wezterm";
  home.stateVersion = "26.05";
  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
