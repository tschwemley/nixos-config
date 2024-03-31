{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    # ./bluetooth.nix
    # ./pipewire.nix
    ./scarlett8i6.nix
  ];

  musnix.enable = true;
  # sound.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
    qjackctl
  ];

  # TODO: move this to own file when testing completed
  # Enable sound with pipewire.
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  # services.jack = {
  #   jackd.enable = true;
  #   alsa.enable = false;
  #   loopback = {
  #     enable = true;
  #   };
  # };
}
