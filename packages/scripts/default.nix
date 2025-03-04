{pkgs, ...}: {
  findDesktopEntries = pkgs.callPackage ./find-desktop-entries.nix {};
  rotateSecrets = pkgs.callPackage ./rotate-secrets.nix {};
}
