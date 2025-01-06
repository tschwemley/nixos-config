let
  root = import ./ephemeral-root.nix "/dev/vda" (import ./efi-partitions.nix);
in {
  imports = [
    root
    ./swap.nix
  ];
}
