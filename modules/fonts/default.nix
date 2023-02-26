{ pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
	  hasklig
      # nerdfonts override example. I may not need anymore since Hasklig available directly
      # (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;
    fontconfig.defaultFonts = {
      # serif = ["Noto Serif"];
      # sansSerif = ["Noto Sans"];
      monospace = ["Hasklig"];
      # emoji = ["Noto Color Emoji"];
    };
  };
}
