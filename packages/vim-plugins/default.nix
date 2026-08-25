{ pkgs, ... }:
{
  blink-cmp-env = pkgs.callPackage ./blink-cmp-env.nix { };
  css-vars-nvim = pkgs.callPackage ./css-vars-nvim.nix { };
  videre-nvim = pkgs.callPackage ./videre-nvim.nix { };
}
