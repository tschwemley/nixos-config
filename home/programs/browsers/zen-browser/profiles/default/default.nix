self: pkgs: {
  extensions = import ./extensions.nix self pkgs;
  keyboardShortcuts = import ./keyboardShortcuts.nix;
  # search = import ./search.nix pkgs;
  # settings = import ./settings.nix;
  userChrome = import ./userChrome.nix pkgs;
}
