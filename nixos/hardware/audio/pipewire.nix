{ pkgs, ... }:
{
  environment = {
    # TODO: remove these dependent on
    #
    # sessionVariables = {
    #   SDL_AUDIODRIVER = "pipewire";
    #   ALSOFT_DRIVERS = "pipewire";
    # };

    systemPackages = with pkgs; [
      helvum

      # NOTE: these are for pulse... maybe split pulse into its own file?
      ncpamixer
      pavucontrol
      pamixer

      # TODO: remove dependent on final config
      # alsa-tools
      # alsa-utils
    ];
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;

    # TODO: remove these once confirming whether used or not
    #       ** see above todo when resolving
    #
    # alsa = {
    #   enable = true;
    #   support32Bit = true;
    # };
    #
    # pulse.enable = true;
  };

  # Enables the RealtimeKit system service, which hands out realtime scheduling priority to user
  # processes on demand. For example, the PulseAudio server uses this to acquire realtime priority.
  security.rtkit.enable = true;
}
