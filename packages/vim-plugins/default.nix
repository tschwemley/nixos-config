{ pkgs, ... }:
{
  blink-cmp-env = pkgs.callPackage ./blink-cmp-env.nix { };
  css-vars-nvim = pkgs.callPackage ./css-vars-nvim.nix { };
  smart-splits-backend-wezterm = pkgs.callPackage ./smart-splits-backend-wezterm.nix { };
  videre-nvim = pkgs.callPackage ./videre-nvim.nix { };
}
