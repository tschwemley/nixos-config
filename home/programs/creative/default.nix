{pkgs, ...}: {
  imports = [
    # ../programs/aseprite.nix TODO: fix for python plugin
    ./3d-printing.nix.nix
    ./gimp.nix
    ./inkscape.nix
  ];
}
