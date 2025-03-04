{pkgs, ...}: rec {
  findDesktopEntries = pkgs.callPackage ./find-desktop-entries.nix {};
  rotateSecrets = pkgs.callPackage ./rotate-secrets.nix {};
  rotateSopsFile = pkgs.callPackage ./rotate-sops-file.nix {};
}
