{ self, pkgs, ... }:
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
  };

  home-manager.users.schwem.stylix.targets = {
    waybar = {
      enable = true;
      # addCss = false;
    };

    wezterm = {
      enable = true;
      fonts.enable = false;
    };

    zen-browser = {
      enable = true;
      profileNames = [ "default" ];
    };
  };
}
