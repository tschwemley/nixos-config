{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    # direnvrcExtra = ''
    #   use_flake() {
    #     watch_file flake.nix
    #     watch_file flake.lock
    #     eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
    #   }
    # '';
  };
}
