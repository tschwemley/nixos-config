{
  self,
  lib,
  pkgs,
  ...
}:
let
  # Fixes BUG: https://github.com/4evy/nixcord/issues/247
  discordPkg = lib.makeOverridable (
    args:
    pkgs.discord.override (
      builtins.removeAttrs args [
        "branch"
        "source"
      ]
    )
  ) { };
in
{
  imports = [ self.inputs.nixcord.homeModules.default ];

  programs.nixcord = {
    enable = true;

    discord = {
      package = discordPkg;
      equicord.enable = true;
    };

    config = {
      frameless = true;
      useQuickCss = true;
      themeLinks = [
        "https://raw.githubusercontent.com/round-panda/gruvbox-sharp/03f155ad53bf81ad38e69ad1ff798c97e7bda48e/GruvboxSharp.theme.css"
      ];
    };

    # NOTE: uncommenting this and rebuilding often fixes issues with discord not opening
    # discord.openASAR.enable = false;
  };
}
