{pkgs, ...}: {
  home.packages = with pkgs; [
    freecad
    openscad-unstable
  ];
}
