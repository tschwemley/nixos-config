self: pkgs: {
  default = {
    extensions = import ./extensions.nix self pkgs;
    keyboardShortcuts = import ./keyboardShortcuts.nix;
    # search = import ./search.nix pkgs;
    userChrome = import ./userChrome.nix pkgs;
  };
}
