{
  inputs,
  pkgs,
  ...
}: {
  # chromium gui flag
  environment.variables.NIXOS_OZONE_WL = "1";
  programs.hyprland.enable = true;
}
