{
  dataCenter,
  rack,
  withMaster ? false,
  withFiler ? false,
  ...
}: let
  masterImport =
    if withMaster
    then ./master.nix
    else {};

  filerImport =
    if withFiler
    then ./filer.nix
    else {};

  volumeImport = ./volume.nix {inherit dataCenter rack;};
in {
  imports = [
    filerImport
    masterImport
    volumeImport
  ];
}
