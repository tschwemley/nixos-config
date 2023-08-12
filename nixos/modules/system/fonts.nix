{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fontconfig
  ];

  fonts = {
    #TODO: this option was renamed from enableDefaultFonts on 07/24/23. Now is a good time to decide
    # if I want to keep it or not
    #enableDefaultPackages = true;

    packages = with pkgs; [
      # NOTE: Some fonts may break colour emojis in Chrome
      # cf. https://github.com/NixOS/nixpkgs/issues/69073#issuecomment-621982371
      # If this happens , keep noto-fonts-emoji and try disabling others (nerdfonts, etc.)
      noto-fonts-emoji
      fira-code
      hasklig
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
