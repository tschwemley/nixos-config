{ pkgs, ... }: {
  enviornment.systemPackages = with pkgs; [mullvad-vpn mullvad-closest];
               }
