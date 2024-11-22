{pkgs, ...}: {
  imports = [./go.nix];

  environment.systemPackages = [pkgs.android-tools];
}
