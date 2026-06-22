{
  config,
  pkgs,
  ...
}:
{
  # dependencies required by plugins
  home.packages = with pkgs; [
    f3d
    poppler-utils # pdf preview
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    initLua = /* lua */ ''
      require("full-border"):setup {
      	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
      	type = ui.Border.ROUNDED,
      }
    '';

    shellWrapperName = "y"; # old option was "yy"

    keymap = import ./keymap.nix;
    plugins = import ./plugins.nix pkgs.yaziPlugins;
    settings = import ./settings.nix;
  };
}
