{
  self,
  config,
  pkgs,
  ...
}:
{
  imports = [
    self.inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    image = ./gruvbox-castle.png;
    polarity = "dark";

    cursor = {
      name = "Posy_Cursor_Black";
      package = pkgs.posy-cursors;
      size = 32;
    };

    fonts =
      let
        inherit (pkgs) nerd-fonts;
        mkFont = package: name: { inherit package name; };
      in
      {
        emoji = mkFont pkgs.twemoji-color-font "Twitter Color Emoji";
        monospace = mkFont nerd-fonts.caskaydia-cove "CaskaydiaCove Nerd Font";
        serif = mkFont pkgs.inter "Inter";
        sansSerif = mkFont pkgs.inter "Inter";

        sizes = {
          applications = 12;
          desktop = 12;
        };
      };

    # BUG: failing due to upstream not updating away from kmscon module config.
    # UPSTREAM: https://github.com/nix-community/stylix/pull/2337/changes
    # TODO: revert when upstream pr is merged. If no effect noticed then leave set to false and
    # update comment
    targets.kmscon.enable = false;
  };

  home-manager.users.schwem.stylix = self.lib.mkIf (config.home-manager.users ? schwem) {
    icons = {
      enable = true;
      dark = "Gruvbox Plus Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    targets = {
      gtk.enable = false;

      qt = {
        enable = true;
        platform = "gtk3";
        # standardDialogs = "xdgdesktopportal"; TODO: uncomment? -- A/B this
      };

      spicetify.enable = true;

      wezterm = {
        enable = true;
        fonts.enable = false;
      };

      zen-browser = {
        enable = true;
        profileNames = [ "default" ];
      };
    };
  };
}
