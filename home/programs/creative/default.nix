{pkgs, ...}: {
  imports = [
    # ../programs/aseprite.nix TODO: fix for python plugin
    ./bambu-studio.nix
    ./gimp.nix
    ./inkscape.nix
  ];

  home.packages = [pkgs.webcamoid];
}
