{
  imports = [
    ../neovim
    ../programs/bat.nix
    ../programs/ripgrep.nix
    ../programs/rustdesk.nix
    ../shell
  ];

			  # necessary due to home manager BUG: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1119760100
		  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  home.stateVersion = "23.05";
}
