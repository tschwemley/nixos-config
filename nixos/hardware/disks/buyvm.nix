{
  imports = let
    partitions = import ./grub-partition.nix // import ./efi-partitions.nix;
  in [
    (import ./ephemeral-root.nix "/dev/vda" partitions)
    ./swap.nix
  ];
}
