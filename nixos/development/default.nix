{pkgs, ...}: {
  imports = [
    ./go.nix
    ./tools.nix
  ];

  environment.systemPackages = [pkgs.android-tools];
}
