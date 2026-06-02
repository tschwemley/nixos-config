{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nix-prefetch-git
    nrepl
  ];

  nix = {
    gc = {
      dates = "0 0 8 * * 2"; # every tues at 08:00:00
      # stores time last triggered so if host was powered off during last schedule run it will trigger immediately
      persistent = true;
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = true;
      extra-sandbox-paths = [ "/etc/sops/nix-sandbox" ];
      sandbox = "relaxed";

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # nix-serve hard-codes priority 30; no idea if it matters but use higher prio values in case
      substituters = [
        "https://cache.nixos.org?priority=40"
        "https://nix-community.cachix.org?priority=50"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
