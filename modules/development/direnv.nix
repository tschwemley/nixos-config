{ self, ... }:
{
  self.inputs.home-manager.programs.direnv.enable = true;
  self.inputs.home-manager.programs.direnv.nix-direnv.enable = true;
}
