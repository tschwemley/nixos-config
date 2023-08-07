{pkgs, ...}: {
  environment.systemPackages = with pkgs; [mullvad-vpn mullvad-closest];
}
