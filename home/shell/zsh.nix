{config, ...}: let
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
    initExtra = ''
      . ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh
      export PATH=$PATH:${config.home.profileDirectory}/bin
    '';
  };
}
