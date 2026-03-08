{ self, pkgs, ... }:
{
  imports = [
    self.inputs.stylix.nixosModules.stylix
  ];

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
        # "Default Profile"
        "fd4lnfim"
      ];
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";

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

    # targets = {
    #   fontconfig.enable = false;
    #   font-packages.enable = false;
    # };
  };
}
