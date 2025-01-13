{pkgs, ...}: {
  environment.systemPackages = [pkgs.rustdesk-flutter];
  services.rustdesk-server = {
    enable = true;
  };
}
