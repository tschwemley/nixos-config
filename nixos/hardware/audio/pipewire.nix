{pkgs, ...}: {
  environment = {
    # TODO: not really sure if these are necessary for anything I'm running or not yet reeval later
    # sessionVariables = {
    #   SDL_AUDIODRIVER = "pipewire";
    #   ALSOFT_DRIVERS = "pipewire";
    # };

    systemPackages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };

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

  # Enables the RealtimeKit system service, which hands out realtime scheduling priority to user
  # processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
  security.rtkit.enable = true;
}
