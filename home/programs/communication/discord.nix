{ self, ... }:
{

  imports = [ self.inputs.nixcord.homeModules.default ];

  programs.nixcord = {
    enable = true;
  };
}
