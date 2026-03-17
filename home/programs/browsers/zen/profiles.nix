pkgs: {
  profiles.default.search = {
    force = true; # Needed for nix to overwrite search settings on rebuild
    default = "ddg"; # Aliased to duckduckgo, see other aliases in the link above
    engines = {
      # My NixOS Option and package search shortcut
      mynixos = {
        name = "My NixOS";
        urls = [
          {
            template = "https://mynixos.com/search?q={searchTerms}";
            params = [
              {
                name = "query";
                value = "searchTerms";
              }
            ];
          }
        ];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@nx" ]; # Keep in mind that aliases defined here only work if they start with "@"
      };
    };
  };
}
