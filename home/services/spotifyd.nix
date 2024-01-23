{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    spotify-tui
  ];

  services.spotifyd = let
    sopsFile = "${config.home.homeDirectory}/nixos-config/home/secrets.yaml";
  in {
    enable = true;
    package = pkgs.spotifyd.override {withMpris = true;};
    settings.global = {
      autoplay = true;
      backend = "pulseaudio";
      bitrate = 320;
      cache_path = "${config.xdg.cacheHome}/spotifyd";
      device_type = "computer";
      initial_volume = "100";
      password_cmd = "sops -d --extract '[\"spotify\"][\"password\"]' ${sopsFile}";
      use_mpris = true;
      username_cmd = "sops -d --extract '[\"spotify\"][\"username\"]' ${sopsFile}";
      volume_normalisation = false;
    };
  };
}
