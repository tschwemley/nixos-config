{ self, pkgs, ... }:
{
  imports = [
    self.inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
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
      };
  };

  home-manager.users.schwem.stylix.targets = {
    # fontconfig.enable = false;
    # font-packages.enable = false;

    waybar.enable = true;
    wezterm = {
      enable = true;
      fonts.enable = false;
    };

    zen-browser = {
      enable = true;
      profileNames = [
        "default"
        # "Default Profile"
        # "fd4lnfim"
      ];
    };
  };
}
