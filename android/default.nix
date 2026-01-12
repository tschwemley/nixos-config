{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.andorid-tools ];
  nixpkgs.config.android_sdk.accept_license = true;
  virtualisation.waydroid.enable = true;
}
