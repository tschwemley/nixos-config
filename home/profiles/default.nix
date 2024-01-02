{...}: {
  imports = [
    ../programs/bat.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../programs/wcalc.nix
    ../programs/wezterm
    ../shell
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
    };
  };

  home.stateVersion = "23.05";
}
