{pkgs, ...}: {
  imports = [
    ../system/xdg.nix
  ];

  services.flatpak.enable = true;
}
