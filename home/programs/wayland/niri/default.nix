{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;

  cfg = config.programs.niri;
  # settingsFormat = pkgs.formats.kdl { };

  niriConfig = with types; submodule { };
in
{
  imports = [ ../../../services/mako.nix ];

  options = {
    programs.niri = {
      enable = lib.mkEnableOption;

      settings = lib.mkOption {
        type = lib.types.submodule {
          # freeformType = (pkgs.formats.yaml { }).type;
          freeformType = (pkgs.formats.json { }).type;
          # freeformType = lib.types.attrs;
        };

        default = { };

        description = ''
          Configuration written to {file}`$XDG_CONFIG_HOME/niri/config.kdl`

          See <https://github.com/YaLTeR/niri/wiki/Configuration:-Introduction> for details.
        '';
      };
    };
  };

  config = {
    # TODO: determine if these should be set. If so - whether they should be set here, as systemd
    # env vars, etc.
    # NOTE: XDG_CURRENT_DESKTOP gets set by default _somewhere_
    #
    # home = {
    #   sessionVariables = {
    #     GDK_SCALE = 2;
    #     XCURSOR_SIZE = 32;
    #     XDG_CURRENT_DESKTOP = "niri";
    #     XDG_SESSION_DESKTOP = "niri";
    #   };
    # };

    xdg.configFile."niri/binds.kdl".source = ./binds.kdl;
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."niri/layout.kdl".source = ./layout.kdl;
    xdg.configFile."niri/input.kdl".source = ./input.kdl;

    programs.niri.settings = {
      gestures = [
        { hot-corners = "off"; }
      ];
    };

    # xdg.configFile."niri/config-generated.kdl".text = lib.hm.generators.toKDL { } cfg.settings;
  };
}
