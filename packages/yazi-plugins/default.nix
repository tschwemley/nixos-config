{ pkgs, ... }:
{
  f3d-preview = pkgs.callPackage ./f3d-preview.nix { inherit (pkgs.yaziPlugins) mkYaziPlugin; };
}
