{
  nix = {
    # automatically trigger garbage collection (by default weekly)
    gc.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      sandbox = "relaxed";
      substituters = [
        "https://cache.nixos.org?priority=10"
        # "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
