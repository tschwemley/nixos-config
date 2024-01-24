{...}: {
  imports = [
    ../programs/bat.nix
    ../programs/fzf.nix
    ../programs/navi.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/wcalc.nix
    ../programs/wezterm
    ../shell/direnv.nix
    ../shell/zsh.nix
  ];

  home = {
    homeDirectory = "/home/droid";
    username = "droid";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
