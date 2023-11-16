{...}: {
  disko = {
    devices = {
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            # When NixOS is initing /etc it doesn't copy configs from the
            # store into RAM. Instead, it links them to the nix store in the
            # persisted dir. 512M should be plenty of space (in fact it may
            # be prudent to downsize later. Current space ~30M).
            "size=512M"
			"defaults"
			"mode=755"
          ];
        };
      };
    };
  };
}
