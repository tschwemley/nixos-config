{
  diskName ? "",
  useGrub ? false,
  ...
}: {
  boot = let
    loader =
      if useGrub
      then {
        grub = {
          efiSupport = true;
          efiInstallAsRemovable = true;
          devices = [diskName];
        };
      }
      else {
        systemd-boot = {
          enable = true;
          editor = false; # leaving true allows for root access to be gained via passing kernel param
        };
      };
  in {inherit loader;};
}
