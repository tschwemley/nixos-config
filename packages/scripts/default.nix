{ pkgs, ... }:
{
  buildHost = pkgs.callPackage ./build-host.nix { };
  rotateSecrets = pkgs.callPackage ./rotate-secrets.nix { };
}

# { pkgs, ... }:
# [
#   (pkgs.callPackage ./build-host.nix { })
#   (pkgs.callPackage ./find-desktop-entries.nix { })
#   (pkgs.callPackage ./rotate-secrets.nix { })
#   (pkgs.callPackage ./search-nerdfonts.nix { })
# ]
