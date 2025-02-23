{pkgs, ...}: {
  environment.systemPackages = [pkgs.android-tools];
  programs.adb.enable = true;
}
