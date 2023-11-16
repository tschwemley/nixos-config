{inputs, ...}: {
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    # extra-sandbox-paths = ["/etc/skopeo/auth.json=/etc/nix/skopeo/auth.json"];
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [inputs.nixpkgs-wayland.overlay];

  # automatically trigger garbage collection (by default weekly)
  nix.gc.automatic = true;
}
