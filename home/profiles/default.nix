{...}: {
  imports = [
    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../terminal
  ];

  # nixpkgs = {
  #   config = {
  #     allowUnfree = true;
  #     allowUnfreePredicate = pkg: true;
  #   };
  # };
}
