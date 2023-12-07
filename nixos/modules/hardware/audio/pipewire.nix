{pkgs, ...}: {
  environment = {
    etc = {
      # low latency configuration
      "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
        context.properties = {
          default.clock.rate = 48000
          default.clock.quantum = 32
          default.clock.min-quantum = 32
          default.clock.max-quantum = 32
        }
      '';
      # TODO: configuration for pulse audio and alsa
      # see: {https://nixos.wiki/wiki/PipeWire#Low-latency_setup}
    };

    systemPackages = with pkgs; [pwvucontrol];
  };

  # Enables the RealtimeKit system service, which hands out realtime scheduling priority to user
  # processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # TODO: determine if needed for live-audio e.g. sonic pi or reaper
  };
}
