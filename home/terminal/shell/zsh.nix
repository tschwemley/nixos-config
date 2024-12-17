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

        func nbuild() {
          nix build "$@" 2>/tmp/last-build.error.log
          $(tail -n1 /tmp/last-build.error.log | sed "s/.*\(nix log.*\)'./\1/")
        }

        # run command from nixpkgs via current system flake
        func run() {
          pkg=$1
          shift

          nix run ~/nixos-config#nixosConfigurations."$HOST".pkgs."$pkg" -- "$@"
        }

        func srun() {
          pkg=$1
          shift

          sudo nix run ~/nixos-config#nixosConfigurations."$HOST".pkgs."$pkg" -- "$@"
        }

        func tailf() { tail -f "$1" | bat --paging=never -l log }
      '';
  };
}
