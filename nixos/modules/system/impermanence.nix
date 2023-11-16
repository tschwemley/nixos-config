{
  inputs,
  additionalDirs ? [],
  additionalFiles ? [],
  ...
}: {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    directories =
      [
        "/etc/nixos"
        "/var/log"
        "/var/lib"
      ]
      ++ additionalDirs;

    files =
      [
        "/etc/machine-id"
        "/etc/nix/id_rsa"
      ]
      ++ additionalFiles;
  };
}
