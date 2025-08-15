{ self, pkgs, ... }:
{
  imports = [ self.inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;

    # autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  };
}
