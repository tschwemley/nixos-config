{ self, ... }:
{
  default = {
    system.stateVersion = "24.05";

    # insert Nix-on-Droid config
    home-manager.config = # { pkgs, ... }:
      {
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
