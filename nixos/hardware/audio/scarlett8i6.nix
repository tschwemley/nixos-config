{pkgs, ...}: {
  boot.extraModprobeConfig = ''
    options snd_usb_audio vid=0x1235 pid=0x8213 device_setup=1
  '';

  environment.systemPackages = [pkgs.alsa-scarlett-gui];
}
