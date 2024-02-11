{pkgs, ...}: {
  environment.systemPackages = with pkgs; [pavucontrol];

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
