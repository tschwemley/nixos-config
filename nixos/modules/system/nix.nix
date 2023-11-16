{
  nix.settings = {
    allowed-uris = [
      "https://git.sr.ht/~rycee"
    ];
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  # automatically trigger garbage collection (by default weekly)
  nix.gc.automatic = true;
}
