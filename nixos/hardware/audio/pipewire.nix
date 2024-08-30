{pkgs, ...}: {
  environment = {
    # sessionVariables = {
    #   SDL_AUDIODRIVER = "pipewire";
    #   ALSOFT_DRIVERS = "pipewire";
    # };

    systemPackages = with pkgs; [
      alsa-utils
      pavucontrol
      pwvucontrol
      pamixer
      pipewire.jack
    ];
  };

  hardware.pulseaudio.enable = false;

  # Enables the RealtimeKit system service, which hands out realtime scheduling priority to user
  # processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
