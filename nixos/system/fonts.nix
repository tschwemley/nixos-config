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

    # Print and exit if no matches found
    [[ -z $res ]] && echo "No result found for search term: $1" && exit 1

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

      # Hinting aligns glyphs to pixel boundaries to improve rendering sharpness at low resolution
      hinting = {
        enable = true;

        # slight (fuzzier but more grid align, retains shape) -> medium -> full (opposite slight)
        style = "full";
      };

      useEmbeddedBitmaps = true;
    };

    fontDir.enable = true;
  };
}
