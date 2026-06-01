{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    crosspipe

    # NOTE: these are for pulse... maybe split pulse into its own file?
    ncpamixer
    pavucontrol
    pamixer

    # TODO: remove dependent on final config
    # alsa-tools
    # alsa-utils
  ];

  services.pipewire = {
    enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Enables the RealtimeKit system service, which hands out realtime scheduling priority to user
  # processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
  security.rtkit.enable = true;
}
