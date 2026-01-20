{ lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  imports = [ ../../../services/mako.nix ];

  options = {
    programs.niri = {
      enable = mkEnableOption;
    };
  };

  config = {

    home.packages = with pkgs; [
      fuzzel
      swaylock
    ];

    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
