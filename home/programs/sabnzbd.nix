{pkgs, ...}: {
  home.packages = with pkgs; [
    sabnzbd
    # rar
  ];
}
