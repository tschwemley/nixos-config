{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fontconfig
  ];

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      # NOTE: Some fonts may break colour emojis in Chrome
      # cf. https://github.com/NixOS/nixpkgs/issues/69073#issuecomment-621982371
      # If this happens , keep noto-fonts-emoji and try disabling others (nerdfonts, etc.)
      noto-fonts-emoji
      fira-code
      cascadia-code
      hasklig
      b612
      #nerdfonts
    ];

    fontconfig = {
      antialias = true;
      hinting.enable = true;
      subpixel.rgba = "rgb";
    };
  };
}
