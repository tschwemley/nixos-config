{pkgs, ...}: {
  # environment.etc = let
  #   json = pkgs.formats.json {};
  # in {
  #   # low latency configuration
  #   "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
  #     context.properties = {
  #       default.clock.rate = 48000
  #       default.clock.quantum = 1024
  #       default.clock.min-quantum = 1024
  #       default.clock.max-quantum = 1024
  #     }
  #   '';
  #
  #   "pipewire/pipewire-pulse.d/92-low-latency.conf".source = json.generate "92-low-latency.conf" {
  #     context.modules = [
  #       {
  #         name = "libpipewire-module-protocol-pulse";
  #         args = {
  #           pulse.min.req = "1024/48000";
  #           pulse.default.req = "1024/48000";
  #           pulse.max.req = "1024/48000";
  #           pulse.min.quantum = "1024/48000";
  #           pulse.max.quantum = "1024/48000";
  #         };
  #       }
  #     ];
  #     stream.properties = {
  #       node.latency = "1024/48000";
  #       resample.quality = 1;
  #     };
  #   };
  #
  #   "wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = ''
  #     alsa_monitor.rules = {
  #       {
  #         matches = {{{ "node.name", "matches", "alsa_output.*" }}};
  #         apply_properties = {
  #           ["audio.format"] = "S32LE",
  #           ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
  #           ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
  #           -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
  #         },
  #       },
  #     }
  #   '';
  # };

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
