{ lib, ... }: {
  imports = [
    ../programs/bat.nix
    ../programs/github.nix
    ../programs/glow.nix
    ../programs/lazygit.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/tmux.nix
    ../shell
  ];

  nixpkgs = {
    config = {
      allowUnfree = lib.mkDefault true;
      # TODO: check if this is still necessary with my current config
      # necessary due to home manager BUG: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1119760100
      allowUnfreePredicate = pkg: true;
    };
  };

  home.stateVersion = "23.05";
}
