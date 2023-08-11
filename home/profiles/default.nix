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

  home.stateVersion = "23.05";
}
