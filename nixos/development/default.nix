{pkgs, ...}: {
  imports = [
    ./dbs.nix
    ./go.nix
    ./tools.nix
  ];

  environment.systemPackages = [pkgs.android-tools];
}
