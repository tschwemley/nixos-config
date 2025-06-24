{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jack2
    jack2Full
    jack_capture
    libjack2
    qjackctl
  ];
  services.pipewire.jack.enable = true;
}
