{
  inputs,
  additionalDirs ? [],
  additionalFiles ? [],
  ...
}: {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence = {
    "/persist" = {
      directories =
        [
          #"/etc/systemd/network"
          "/etc/ssh"
          "/root"
          "/var/log"
        ]
        ++ additionalDirs;

      files =
        [
          # "/var/run/secrets.d/age-keys.txt"
          # "/etc/machine-id"
        ]
        ++ additionalFiles;
    };
  };
}
