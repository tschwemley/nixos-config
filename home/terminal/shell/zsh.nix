{config, ...}: let
  shellAliases = import ./aliases;
in {
  # home.file.".zsh_completions".source = ./completions;

  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };
    initExtra =
      /*
      bash
      */
      ''
        source ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh
        export PATH=$PATH:${config.home.profileDirectory}/bin

        # NOTE: if I add many more funcs its worth splitting off into their own file or dir
        # additional funcs
        func tbat() { tail -f "$1" | bat --paging=never -l log }

        # run command from nixpkgs via current system flake
        func run() { nix run ~/nixos-config#nixosConfigurations."$HOST".pkgs."$1" }
        func srun() { sudo nix run ~/nixos-config#nixosConfigurations."$HOST".pkgs."$1" }
      '';
  };
}
