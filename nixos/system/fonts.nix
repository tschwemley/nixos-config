{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fontconfig
  ];

  fonts = {
    packages = with pkgs; [
      fira-code
      hasklig
      nerd-fonts.hasklug
      nerd-fonts.symbols-only
      noto-fonts-emoji
    ];

    fontconfig = {
      enable = true;
      # TODO: useful for oled? test with secondary monitor
      # antialias = true;
      # hinting.enable = true;
      # subpixel.rgba = "rgb";
    };
  };
}
