{pkgs, ...}: {
  # Read Nix-on-Droid changelog before changing this value
  system.stateVersion = "24.05";

  # insert Nix-on-Droid config

  home-manager.config = {pkgs, ...}: {
    # Read home-manager changelog before changing this value
    home.stateVersion = "24.05";

    # insert home-manager config
    imports = [
      ../home/programs/neovim
    ];
  };
}
