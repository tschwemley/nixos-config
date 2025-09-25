{ self, ... }:
{
  imports = [ self.inputs.lan-mouse.homeManagerModules.default ];

  programs.lan-mouse.enable = true;
}
