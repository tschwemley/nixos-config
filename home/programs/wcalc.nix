{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ wcalc ];

  programs.zsh.shellAliases.wcalc = lib.mkIf config.programs.zsh.enable "wcalc -EE -P4";
}
