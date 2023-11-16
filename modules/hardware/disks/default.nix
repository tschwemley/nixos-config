{ ... }: {
	encryptedRoot = import ./encrypted-root.nix;
	ephemeralBtrfs = import ./ephemeral-btrfs.nix;
}
