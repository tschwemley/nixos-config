{pkgs, ...}: {
  services.mullvad.enable = true;
  environment.systemPackages = with pkgs; [mullvad-closest];
}
