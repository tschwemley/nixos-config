{ nixosModules, ... }:
{
  inputs.home-manager.programs.direnv.enable = true;
  inputs.home-manager.programs.direnv.nix-direnv.enable = true;
}
