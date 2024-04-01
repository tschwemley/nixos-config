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

  musnix = {
    enable = true;
    kernel = {
      realtime = true;
      packages = pkgs.linuxPacakges_latest_rt;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    qpwgraph
  ];

  # TODO: move this to own file when testing completed
  # Enable sound with pipewire.
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # services.jack = {
  #   jackd.enable = true;
  #   alsa.enable = false;
  #   loopback = {
  #     enable = true;
  #   };
  # };
}
