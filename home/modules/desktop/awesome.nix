{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
  };

  hardware.video.hidpi.enable = lib.mkDefault true;
  services.xserver.dpi = 192;

  environment.systemPackages = with pkgs; [
  ];
}
