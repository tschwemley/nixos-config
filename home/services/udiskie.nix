{ lib, pkgs, ... }:
{
  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = lib.getExe pkgs.yazi;
      };
    };
  };
}
