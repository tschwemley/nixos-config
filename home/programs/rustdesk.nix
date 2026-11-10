{ self, pkgs, ... }: {
  # BUG: https://nixpkgs-tracker.ocfox.me/?pr=585583 -- can revert once merged into nixos-unstable
  # home.packages = [ pkgs.rustdesk-flutter ];
  home.packages = [ self.inputs.nixpkgs-small.legacyPackages.x86_64-linux.rustdesk-flutter ];
}
