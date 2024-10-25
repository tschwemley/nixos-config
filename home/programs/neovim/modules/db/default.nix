{
  lib,
  pkgs,
  ...
}:
{
  programs.neovim.plugins =
    with pkgs.vimPlugins;
    let
      dbee = nvim-dbee.overrideAttrs {
        meta.platforms = lib.platforms.linux ++ lib.platforms.darwin;
      };
    in
    [
      dbee
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
    ];

  xdg.configFile."nvim/after/plugin/db.lua".source = ./db.lua;
}
