{pkgs, ...}: {
  buildHost = pkgs.callPackage ./build-host.nix {};
  findDesktopEntries = pkgs.callPackage ./find-desktop-entries.nix {};
  rotateSecrets = pkgs.callPackage ./rotate-secrets.nix {};
  search-nf = pkgs.callPackage ./search-nerdfonts.nix {};
}
