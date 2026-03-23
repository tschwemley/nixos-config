{ pkgs, ... }:
{
  home.packages = with pkgs; [
    orca-slicer
  ];
}
