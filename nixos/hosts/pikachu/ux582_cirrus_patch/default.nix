{
  lib,
  pkgs,
  ...
}:

{
  boot = {
    kernelPatches = lib.singleton {
      name = "allow-sdhci-acpi";
      patch = null;
      extraConfig = ''
        ACPI_TABLE_UPGRADE y
      '';
    };
  };

  boot.initrd.prepend = [
    "${(pkgs.callPackage ./ux582_cirrus_patch.nix { })}/ux582_cirrus_patch.cpio"
  ];
}
