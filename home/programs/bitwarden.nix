{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-desktop
  ];
}
