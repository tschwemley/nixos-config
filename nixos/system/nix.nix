{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nix-doc
    nix-prefetch-git
  ];

  nix = {
    # TODO: re-enable or remove this (is it still necessary with current builds?
    # for documentation
    # extraOptions = ''
    #   # plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
    # '';

    gc = {
      dates = "0 0 8 * * 2"; # every tues at 08:00:00
      # stores time last triggered so if host was powered off during last schedule run it will trigger immediately
      persistent = true;
    };

    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      extra-sandbox-paths = ["/etc/sops/nix-sandbox"];
      sandbox = "relaxed";
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        # "https://yazi.cachix.org?priority=99"
        # "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
