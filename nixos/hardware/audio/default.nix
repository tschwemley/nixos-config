{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    # ./bluetooth.nix
    # ./pipewire.nix
    ./scarlett8i6.nix
  ];

  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
    pipewire.jack
  ];

  hardware.pulseaudio.enable = lib.mkForce false;

  musnix.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
