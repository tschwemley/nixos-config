{pkgs, ...}: {
  imports = [
    # ../programs/aseprite.nix TODO: fix for python plugin
    ./3d-printing.nix
    ./gimp.nix
    ./inkscape.nix
  ];
}
