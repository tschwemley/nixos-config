{ pkgs, ... }:
{
  home.packages = with pkgs; [
    godot
    godot-mcp
  ];
}
