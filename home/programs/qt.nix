{ lib, ... }: {
  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk3";
  };
}
