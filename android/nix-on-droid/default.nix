{ self, ... }:
{
  default = {
    # Read Nix-on-Droid changelog before changing this value
    system.stateVersion = "24.05";

    # insert Nix-on-Droid config
    # home-manager.config = {pkgs, ...}: {
    home-manager.config = {
      home.enableNixpkgsReleaseCheck = false;
      home.stateVersion = "24.05";

      extraSpecialArgs = {
        inherit self;
        inherit (self) inputs;
      };

      # insert home-manager config
      imports = [
        ../../home/profiles/default.nix
      ];
    };
  };
}
