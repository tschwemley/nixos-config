{
  self,
  pkgs,
  ...
}: {
  imports = [self.inputs.musnix.nixosModules.musnix];

  musnix = {
    enable = true;

    alsaSeq.enable = true;
    das_watchdog.enable = true; # ensures realtime process wont hang machine

    # kernel = {
    #   # packages = pkgs.linuxPackages_latest_rt;
    #   packages = pkgs.linuxPackages_rt;
    #   realtime = true;
    # };

    rtcqs.enable = true;
    soundcardPciId = "00:1f.3"; # this is the same across machines
  };
}
