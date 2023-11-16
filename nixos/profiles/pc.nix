# steam has to be installed system wide/as a nixos module instead of via home-manager 🤷
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
