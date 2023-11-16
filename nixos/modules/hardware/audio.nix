{
  self,
  pkgs,
  ...
}: {
  imports = [self.inputs.musnix];

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  # The mSBC codec provides slightly better sound quality in calls than regular HFP/HSP, while the
  # SBC-XQ provides better sound quality for audio listening. see:
  # https://www.guyrutenberg.com/2021/03/11/replacing-pulseaudio-with-pipewire/
  environment.etc = {
    # "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
    #   context.properties = {
    #     default.clock.rate = 48000
    #     default.clock.quantum = 32
    #     default.clock.min-quantum = 32
    #     default.clock.max-quantum = 32
    #   }
    # '';

    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  musnix.enable = true;

  hardware.bluetooth.enable = true;
  # enables blueman-applet and blueman-manager for gui (can also connect via cli bluetoothctl)
  #services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # TODO: determine if needed for live-audio e.g. sonic pi or reaper
    jack.enable = true;
  };

  sound.enable = true;
}
