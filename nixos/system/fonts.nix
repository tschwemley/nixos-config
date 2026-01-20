{
  pkgs,
  ...
}:
let
  search-nf = pkgs.writeShellScriptBin "search-nf" /* bash */ ''
    pattern="nf-\w*-.*?''${1}"
    res=$(curl -sL 'https://nerdfonts.com/cheat-sheet' \
         | rg "$pattern" \
         | awk -F'"' '{printf "| %c | %s |\n", strtonum("0x" $4), $2}'
    )


    cat <<MARKDOWN
    | Icon | NF Class  |
    | :--- | :-------  |
    $res
    MARKDOWN
  '';
in
{
  environment.systemPackages = with pkgs; [
    fontconfig
    search-nf
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

    #TODO: fix for steam?
    fontDir.enable = true;
    # fontDir.enable = true; TODO: reenable if comapatbility issues. Otherwise delete

    packages = with pkgs; [
      inter # used for reaper theme(s)

      nerd-fonts.caskaydia-cove
      nerd-fonts.daddy-time-mono

      twemoji-color-font
    ];
  };

  # TODO: keep/remove depending on steam behavior
  fonts.fontconfig.useEmbeddedBitmaps = true;
}
