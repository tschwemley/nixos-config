{...}: {
  imports = [
    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/fzf.nix
    ../programs/navi.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/wcalc.nix
    ../programs/wezterm
    ../shell/zsh.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
    };
  };

  home.stateVersion = "23.05";
}
