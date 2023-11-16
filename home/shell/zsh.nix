{
  config,
  pkgs,
  ...
}: let
  shellAliases = import ./aliases;
in {
  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };
    shellInit = ''
      . ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh
    '';
  };
}
