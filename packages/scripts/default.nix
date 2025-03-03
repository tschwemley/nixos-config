{pkgs, ...}: {
  findDesktopEntries = pkgs.callPackage ./find-desktop-entries.nix {};
  rotateSopsFile = pkgs.callPackage ./rotate-sops-file.nix {};
}
