{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.noisetorch ];
  programs.noisetorch.enable = true;
  systemd.user.services.pipewire-pulse.environment.LADSPA_PATH = "/tmp";
}
