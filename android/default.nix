{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.android-tools ];
  nixpkgs.config.android_sdk.accept_license = true;
  virtualisation.waydroid.enable = true;
}
