{pkgs, ...}: {
  services.nginx.virtualHosts."cyberchef.schwem.io" = {
    root = "${pkgs.cyberchef}/share/cyberchef";
    locations."/" = {};
  };
}
