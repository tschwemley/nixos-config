{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.chrysalis ];
  services.udev.packages = [ pkgs.chrysalis ];
  # services.udev.extraRules = ''
  #   ${lib.readFile ./chrysalis-udev.rules}
  # '';
}
