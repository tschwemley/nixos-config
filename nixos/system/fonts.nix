{
  pkgs,
  ...
}:
let
in
{
  environment.systemPackages = with pkgs; [
    fontconfig
    scripts.search-nf
  ];

  fonts = {
    fontconfig = {
      enable = true;

      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [ "CaskaydiaCove Nerd Font" ];
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];

        # serif = [ "DaddyTimeMono Nerd Font" ];
        # sansSerif = [ "CaskaydiaCove Nerd Font" ];
      };

      # Hinting aligns glyphs to pixel boundaries to improve rendering sharpness at low resolution
      hinting = {
        enable = true;

        # slight (fuzzier but more grid align, retains shape) -> medium -> full (opposite slight)
        style = "full";
      };
    };

    # fontDir.enable = true; TODO: reenable if comapatbility issues. Otherwise delete

    packages = with pkgs; [
      inter # used for reaper theme(s)

      nerd-fonts.caskaydia-cove
      nerd-fonts.daddy-time-mono

      twemoji-color-font
    ];
  };
}
