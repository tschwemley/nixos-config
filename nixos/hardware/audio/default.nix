{
  # inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bluetooth.nix
    # ./pipewire.nix
    ./scarlett8i6.nix
  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
    pamixer
    pipewire.jack
  ];

  hardware.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
