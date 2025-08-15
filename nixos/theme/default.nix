{ self, ... }:
{
  imports = [ self.inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
  };
}
